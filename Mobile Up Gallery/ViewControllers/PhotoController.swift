//
//  PhotoController.swift
//  Mobile Up Gallery
//
//  Created by Чаусов Николай on 29.03.2022.
//

import UIKit
import SnapKit

class PhotoController: UIViewController {
    
    private var safeAreaView = UIView()
    
    var url = ""
    
    var imageView = UIImageView()
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = "Дата отсутсвует"
        label.font = UIFont.SFDisplaySemibold(size: 18)
        label.textColor = .black
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        self.view.addSubview(label)

        imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        downloadImage(from: URL(string: url)!)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.view )
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        self.navigationItem.titleView = label
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareImage))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .plain, target: self, action: #selector(closeViewController))
        navigationItem.leftBarButtonItem?.tintColor = .black
        

        
    }
    
    func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.imageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    convenience init(url: String, date: Int){
        self.init()
        self.url = url
        
        label.text = DateSetter.getDate(date: date)
    }
    
    
 
    @objc private func shareImage(){
        let shareSheet = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        shareSheet.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in
            if activityType == .saveToCameraRoll {
                self.alertError(title: NSLocalizedString("Alert for saved photo", comment: ""), message: NSLocalizedString("Alert message for nice choice", comment: ""))
            }
            guard let type = activityType?.rawValue else {return}
            if type.contains("SaveToFiles") {
                self.alertError(title: NSLocalizedString("Alert for donwloaded photo", comment: ""), message: NSLocalizedString("Alert message for nice choice", comment: ""))
            }
            if let _ = error {
                self.alertError(title: NSLocalizedString("Alert for error in share menu", comment: ""), message: NSLocalizedString("Alert message for error in share menu", comment: ""))
            }
         }
        
        
        present(shareSheet, animated: true)
    }
    
    @objc private func closeViewController(){
        self.navigationController?.popViewController(animated: true)
    }
    
}
