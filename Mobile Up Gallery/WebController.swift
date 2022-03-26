//
//  WebController.swift
//  Mobile Up Gallery
//
//  Created by Чаусов Николай on 26.03.2022.
//

import UIKit
import WebKit

class WebController: UIViewController {
    
    private let url: URL
    var tokenDelegate: tokenAccessDelegate?
    
    private let webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        config.preferences = preferences
        
        let web = WKWebView(frame: .zero, configuration: config)
        
        
        return web
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        webView.load(URLRequest(url: url))
        webView.addObserver(self, forKeyPath: "URL",options: .new, context: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webView.frame = view.bounds
    }
    
    init(url: URL){
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let newValue = change?[NSKeyValueChangeKey.newKey] {
            if let newURL = (newValue as? NSURL){
                guard let str = newURL.absoluteString else {return}
                if str.contains("https://oauth.vk.com/blank.html#access_token="){
                    tokenDelegate?.updateUrlWithToken(url: str)
                    print("DISMISING WEBCONTROLLER")
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    deinit {
        print("DEINITIAL WEBCONTROLLER")
    }
    
}
