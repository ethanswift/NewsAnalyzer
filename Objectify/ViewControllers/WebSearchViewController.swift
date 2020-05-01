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
    
    var searchKeywords: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillSearchKeywords()

        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        webView.backgroundColor = #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1)
//        let webConfig = WKWebViewConfiguration()
//        webView.frame = .zero
//
//        webView = WKWebView(frame: .zero, configuration: webConfig)
        
        let query: String = produceURL()
        let url = "http://news.google.com/news?q=\(query)" 
        print(url) // words with space
        if url != "" {
            webView.load(URLRequest(url: URL(string: url)!))
        }
        // Do any additional setup after loading the view.
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func fillSearchKeywords () {
        for category in categories {
            category.categoryName.components(separatedBy: " ")
            searchKeywords.append(category.categoryName)
        }
        for item in items {
            if item.sentencePartType == "entity" {
                searchKeywords.append(item.text)
            } else if item.sentencePartType == "keyword" {
                searchKeywords.append(item.text)
            }
        }
    }
    
    func produceURL () -> String {
        var result: String = ""
        if searchKeywords.count != 0 {
            for searchKeyword in searchKeywords {
                result += "\(searchKeyword)+"
            }
            result.removeLast()
        }
        return result
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
