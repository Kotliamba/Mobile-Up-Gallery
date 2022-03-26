//
//  ViewController.swift
//  Mobile Up Gallery
//
//  Created by Чаусов Николай on 25.03.2022.
//

import UIKit
import SnapKit


protocol tokenAccessDelegate {
    func updateUrlWithToken(url: String)
}

class ViewController: UIViewController {

    
    private let buttonOAuth: UIButton = {
       let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Вход через VK", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 18)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        
        
        return button
    }()
    
    let labelFirst: UILabel = {
        let label = UILabel()
        label.text = "Mobile Up"
        label.textColor = .black
        label.font = UIFont(name: "TrebuchetMS-Bold", size: 48)
        label.numberOfLines = 1
        return label
    }()
    
    let labelSecond: UILabel = {
        let label = UILabel()
        label.text = "Gallery"
        label.textColor = .black
        label.font = UIFont(name: "TrebuchetMS-Bold", size: 48)
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        view.addSubview(buttonOAuth)
        view.addSubview(labelFirst)
        view.addSubview(labelSecond)
        
        buttonOAuth.addTarget(self, action: #selector(openWebView), for: .touchUpInside)
        
        makeConstraints()
    }


    
    @objc func openWebView(){
        guard let url = URL(string: "https://oauth.vk.com/authorize?client_id=8115175&redirect_uri=https://oauth.vk.com/blank.html&scope=2&display=mobile&response_type=token") else {return}
        let webViewController = WebController(url: url)
        webViewController.tokenDelegate = self

        present(webViewController, animated: true)
        
        
    }
    
    
    
    private func makeConstraints(){
        buttonOAuth.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-50)
            make.leading.equalTo(view).offset(24)
            make.trailing.equalTo(view).offset(-24)
            make.height.equalTo(56)
        }
        
        labelFirst.snp.makeConstraints { make in
            make.top.equalTo(view).offset(164)
            make.leading.equalTo(view).offset(24)
            make.trailing.equalTo(view).offset(-24)
        }
        
        labelSecond.snp.makeConstraints { make in
            make.top.equalTo(labelFirst.snp.bottom)
            make.leading.equalTo(view).offset(24)
            make.trailing.equalTo(view).offset(-24)
        }
    }
}

extension ViewController: tokenAccessDelegate {
    func updateUrlWithToken(url: String) {
        print("111111111111111111111111111111111111111111111111111111")
        print(url)
    }
    
}
