//
//  WebSearchViewController.swift
//  Objectify
//
//  Created by ehsan sat on 4/25/20.
//  Copyright © 2020 ehsan sat. All rights reserved.
//

import UIKit
import WebKit

class WebSearchViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    var items: [Item] = []
    
    var docs: [Doc] = []
    
    var categories: [Categories] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        webView.uiDelegate = self
        let webConfig = WKWebViewConfiguration()
        webView.frame = .zero
        
        webView = WKWebView(frame: .zero, configuration: webConfig)
        
        let url = "http://news.google.com/news?q=appreciated+apparent"
        
        webView.load(URLRequest(url: URL(fileURLWithPath: url)))
        // Do any additional setup after loading the view.
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func produceURL () {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
