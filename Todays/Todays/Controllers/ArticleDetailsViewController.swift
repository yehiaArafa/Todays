//
//  ArticleDetailsViewController.swift
//  Todays
//
//  Created by Yehia Arafa on 3/10/18.
//  Copyright © 2018 Yehia Arafa. All rights reserved.
//

import UIKit
import WebKit


protocol ArticleDetailsViewControllerDelegate: class {
    func cancel(_ controller: ArticleDetailsViewController)
}

class ArticleDetailsViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    var isFirstView = false
    
    var articleURL: URLRequest?
    weak var delegate: ArticleDetailsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        forwardButton.isEnabled = false
        backButton.isEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        webView.load(articleURL!)
        isFirstView = true
    }

    
    @IBAction func forward(_ sender: Any) {
        if webView.canGoForward{
            webView.goForward()
        }
    }
    
    @IBAction func back(_ sender: Any) {
        if (isFirstView){
            delegate?.cancel(self)
        }
        if (webView.canGoBack){
            isFirstView = false
            webView.goBack()
        }
    }
}

extension ArticleDetailsViewController: WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if(webView.canGoBack){
            isFirstView = false
        }
        else{
           isFirstView = true
        }
        backButton.isEnabled = true
        forwardButton.isEnabled = webView.canGoForward
    }
}



