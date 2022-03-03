//
//  NewsViewController.swift
//  mediastack
//
//  Created by Mukesh Lokare on 02/03/22.
//

import UIKit

class NewsViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    private var activityIndicator = UIActivityIndicatorView()

    //MARK: Instances
    private var newsViewModel : NewsViewModelProtocol!
    private var pageOffset = 0
    
    //MARK: File Constants
    fileprivate struct Constant{
        static let cellIdentifier = "NewsTableViewCell"
        static let pageLimit = 10
    }
    
    //MARK: Lifecycle viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        newsViewModel = NewsViewModel(newsWebService: NewsWebservices())//Initialize ViewModel & pass required depdendencies.
        configureTableView()
        fetchNews()
    }

    //MARK: Configure TableView
    
    private func configureTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.register(view: NewsTableViewCell.self)
    }
   
    //MARK: Fetch News from API
    
    private func fetchNews(){
        
        //TODO: Make filter dynamic i.e sources, categories, countries, languages, keywords & sort
        newsViewModel.liveNews(sources: "", categories: "business,sports", countries: "us,au", languages: "en", keywords: "", sort: "published_desc", offset: pageOffset, limit: Constant.pageLimit) {
            //To be on safer side reload table data on main thread after background API call
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: Pagination
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
        activityIndicator.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        activityIndicator.startAnimating()
        self.tableView.tableFooterView = activityIndicator
        self.tableView.tableFooterView?.isHidden = false
    }
}

//MARK: UITableView DataSource
extension NewsViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsViewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let newsCell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        newsCell.newsItem = newsViewModel.detailsForCell(indexPath: indexPath)
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

//MARK: UITableView Delegate
extension NewsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell Clicked: \(indexPath.row)")
    }
}
