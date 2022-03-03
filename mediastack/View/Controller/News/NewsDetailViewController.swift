//
//  NewsDetailViewController.swift
//  mediastack
//
//  Created by Mukesh Lokare on 03/03/22.
//

import UIKit
import WebKit

class NewsDetailViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var webView: WKWebView!
    
    //MARK: Instances    
     var newsDetailViewModel : NewsDetailViewModelProtocol!

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadWebView()
    }
    
    // MARK: - Load WebView
    private func loadWebView(){
        if let url = self.newsDetailViewModel.url{
            self.webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }

}
