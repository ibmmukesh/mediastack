//
//  NewsViewController.swift
//  mediastack
//
//  Created by Mukesh Lokare on 02/03/22.
//

import UIKit

class NewsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    private var activityIndicator = UIActivityIndicatorView()
    let emptyView:EmptyView = EmptyView()
    
    //MARK: - Instances
    private var newsViewModel : NewsViewModelProtocol!
    private var pageOffset = 0
    var cache = NSCache<AnyObject, AnyObject>()
    
    //MARK: - File Constants
    fileprivate struct Constant{
        static let cellIdentifier = "NewsTableViewCell"
        static let pageLimit = 10
        static let activityIndicatorFrameHeight = 44
        static let newsDetailStoryboardIdentifier = "NewsDetailViewController"
        static let newsFilterStoryboardIdentifier = "NewsFilterViewController"
        static let googleFavURL = "https://www.google.com/s2/favicons?sz=64&domain="//Google URL to get fav icon based on site.
    }
    
    //MARK: - Lifecycle viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        newsViewModel = NewsViewModel(newsWebService: NewsWebservices())//Initialize ViewModel & pass required depdendencies.
        configureTableView()
        fetchNews()
    }
    
    //MARK: - Configure TableView
    
    private func configureTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.register(view: NewsTableViewCell.self)
    }
    
    //MARK: - Fetch News from API
    
    private func fetchNews(_ categories:String?="",_ countries: String?="",_ languages:String?=""){
        
        let parameter = NewsParameter(sources: "", categories: categories ?? "business,sports", countries: countries ?? "", languages: languages ?? "", keywords: "", sort: "published_desc", offset: pageOffset, limit: Constant.pageLimit)
        
        //TODO: Make filter dynamic i.e sources, categories, countries, languages, keywords & sort
        newsViewModel.liveNews(parameter:parameter) {
            //To be on safer side reload table data on main thread after background API call
            DispatchQueue.main.async {
                self.loadData()
            }
        }
    }
    
    private func loadData(){
        if let newsFeeds = self.newsViewModel.newsList, newsFeeds.count > 0{
            self.tableView.isUserInteractionEnabled = true
            self.tableView.reloadData()
        }
    }
    //MARK: - Pagination
    private func applyPagination(indexPath:IndexPath){
        
        guard let newsList = newsViewModel.newsList else{return}
        if indexPath.row == newsList.count - 1 { //Check last cell in the tableview
            if newsViewModel.pagination?.total ?? 0 > newsList.count{//Check total number of news & previous fetched news
                pageOffset += 10
                self.fetchNews()
            }
        }
    }
    
    private func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(Constant.activityIndicatorFrameHeight))
        activityIndicator.startAnimating()
        self.tableView.tableFooterView = activityIndicator
        self.tableView.tableFooterView?.isHidden = false
    }
    
    // MARK: - Navigation
    private func showNewsDetail(news:News){
        let storyboard = UIStoryboard(name:AppConstant.mainStorboard, bundle: nil)
        let newsDetailController : NewsDetailViewController = storyboard.instantiateViewController(withIdentifier: Constant.newsDetailStoryboardIdentifier) as! NewsDetailViewController
        newsDetailController.newsDetailViewModel = NewsDetailViewModel(news: news)//Initialize ViewModel & pass required depdendencies.
        self.navigationController?.pushViewController(newsDetailController, animated: true)
    }
    
    @IBAction func filterBarButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name:AppConstant.mainStorboard, bundle: nil)
        let newsFilterController : NewsFilterViewController = storyboard.instantiateViewController(withIdentifier: Constant.newsFilterStoryboardIdentifier) as! NewsFilterViewController
        newsFilterController.newsFilterViewModel = NewsFilterViewModel()
        newsFilterController.onFilterAppy = {[weak self](category, country, language) in
            guard let self = self else { return }
            self.fetchNews(category.joined(separator: ","),country.joined(separator: ","),language.joined(separator: ","))
        }
        self.present(newsFilterController, animated: true, completion: nil)
    }
    
}

////MARK: - EmptyViewDelegate
extension NewsViewController: EmptyViewDelegate{
    func refreshClicked() {
        fetchNews()
    }
}

//MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsViewModel.newsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let newsCell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        if let newsList = self.newsViewModel.newsList, newsList.count > 0{
            let newsItem = newsViewModel.detailsForCell(indexPath: indexPath)
            self.loadSourceAndNewAvatar(newsCell: newsCell, newsItem: newsItem)
            newsCell.newsItem = newsItem
        }
        
        self.applyPagination(indexPath: indexPath)
        return newsCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            self.configureActivityIndicator()
        }
    }
}
//MARK: - Cache
extension NewsViewController{
    
    private func loadSourceAndNewAvatar(newsCell: NewsTableViewCell, newsItem: News?){
        
        if let img = cache.object(forKey: newsItem?.image as AnyObject) {
            newsCell.newsImageView.image = img as? UIImage
        }else {
            DispatchQueue.global().async {
                if let url = URL(string: newsItem?.image ?? ""){
                    do{
                        let data = try Data(contentsOf: url)
                        DispatchQueue.main.async {
                            newsCell.newsImageView.image = UIImage(data: data)
                            self.cache.setObject(UIImage(data: data)!, forKey: newsItem?.image as AnyObject)
                        }
                    }catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
        if let imageURLStr = newsItem?.url{
            if let imageURL = URL(string: "\(Constant.googleFavURL)\(imageURLStr)"){
                if let img = cache.object(forKey: imageURL as AnyObject) {
                    newsCell.sourceImageView.image = img as? UIImage
                }else {
                    DispatchQueue.global().async {
                        let data = NSData(contentsOf: imageURL)
                        DispatchQueue.main.async {
                            if let imageData = data{
                                newsCell.sourceImageView.image = UIImage(data: imageData as Data)
                                self.cache.setObject(UIImage(data: imageData as Data)!, forKey: newsItem?.image as AnyObject)
                            }
                        }
                    }
                }
            }
        }
    }
}

//MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newsList = self.newsViewModel.newsList, newsList.count > 0{
            self.showNewsDetail(news: newsList[indexPath.row])
        }
    }
}
