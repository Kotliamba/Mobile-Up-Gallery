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
    weak var tokenDelegate: tokenAccessDelegate?
    
    var lastUrl = ""
    
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
        
        //custom func to clean cashe
        WKWebView.clean()
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
                guard let str = newURL.absoluteString else {
                    tokenDelegate?.webKitFall()
                    return
                }
                lastUrl = str
                if str.contains("https://oauth.vk.com/blank.html#access_token="){
                    dismiss(animated: true) { [weak self] in
                        self?.tokenDelegate?.updateUrlWithToken(url: str)
                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !lastUrl.contains("https://oauth.vk.com/blank.html#access_token="){
            DispatchQueue.main.async{
                self.tokenDelegate?.webKitFall()
            }
        }
    }
}


