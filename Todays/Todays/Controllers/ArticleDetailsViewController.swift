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
    
    @IBOutlet weak var progressBar: UIProgressView!
    var isFirstView: Bool!
    var articleURL: URLRequest?
    var isLoading: Bool!
    var timer: Timer!
    
    weak var delegate: ArticleDetailsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        forwardButton.isEnabled = false
        backButton.isEnabled = true
        progressBar.progress = 0.0
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
    
    @objc func timerCallBack(){
        if(isLoading != nil){
            if (progressBar.progress >= 1){
                progressBar.isHidden = true
                timer.invalidate()
            }
            else{
                progressBar.progress += 0.05
            }
        }
        else{
            progressBar.progress += 0.05
            if (progressBar.progress >= 0.85){
                 progressBar.progress = 0.95
            }
        }
    }
    
}



extension ArticleDetailsViewController: WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressBar.progress = 0.0
        isLoading = true
        timer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(ArticleDetailsViewController.timerCallBack), userInfo: nil, repeats: true)
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isLoading = false
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



