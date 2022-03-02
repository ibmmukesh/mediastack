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
    
    //MARK: Instances
    private var newsViewModel : NewsViewModelProtocol!

    
    //MARK: File Constants
    fileprivate struct Constant{
        static let cellIdentifier = "NewsTableViewCell"
    }
    
    //MARK: Lifecycle viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureTableView()
        fetchNews()
    }

    //MARK: Configure Table
    
    private func configureTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.register(view: NewsTableViewCell.self)
    }
    
    //MARK: Fetch News from API
    
    private func fetchNews(){
        newsViewModel = NewsViewModel(newsWebService: NewsWebservices())
        
        newsViewModel.liveNews(sources: "", categories: "business,sports", countries: "us,au", languages: "en", keywords: "", sort: "published_desc", offset: 0, limit: 100) {
                
            if let _ = self.newsViewModel.newsList{
                //To be on safer side reload table data on main thread after background API call
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
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
        return newsCell
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
