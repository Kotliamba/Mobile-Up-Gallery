//
//  ViewController.swift
//  Mobile Up Gallery
//
//  Created by Чаусов Николай on 25.03.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var model = Model()
    
    var items = [Item]()
    
    private let buttonOAuth: UIButton = Button.getButton()
    
    private let labelFirst: UILabel = Label.getFistScreenLabel(with: "Mobile Up")
    
    private let labelSecond: UILabel = Label.getFistScreenLabel(with: "Gallery")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        view.addSubview(buttonOAuth)
        view.addSubview(labelFirst)
        view.addSubview(labelSecond)
        
        model.itemsFetchDelegate = self
        
        buttonOAuth.addTarget(self, action: #selector(openWebView), for: .touchUpInside)
        
        makeConstraints()
        
        if model.isTokenWorking() {
            goToSecondScreen()
        }
    }

    @objc func openWebView(){
        guard let url = URL(string: "https://oauth.vk.com/authorize?client_id=8115175&redirect_uri=https://oauth.vk.com/blank.html&scope=2&display=mobile&response_type=token") else {return}
        let webViewController = WebController(url: url)
        
        webViewController.tokenDelegate = self

        present(webViewController, animated: true)
    }
    
    private func goToSecondScreen(){
        print("Trying second Screen")
            let imagesViaUrlAndDate = self.items
            let secondViewController = UICollectionViewViewController()
            let nav = UINavigationController(rootViewController: secondViewController)
            secondViewController.imageSet = imagesViaUrlAndDate
        print("Trying to present")
        present(nav, animated: true)
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
        model.setNewToken(with: url)
        guard let requestURL = model.buildRequestUrl() else {
            print("Reques fail")
            return  }
        model.getServerResponse(to: requestURL)
        }
    
}
extension ViewController: itemsFetchDelegate {
        func updateItems(_ items: [Item]) {
            DispatchQueue.main.async {
                self.items = items
                self.goToSecondScreen()
        }
    }

}
