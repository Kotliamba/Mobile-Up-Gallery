//
//  UICollectionViewViewController.swift
//  Mobile Up Gallery
//
//  Created by Чаусов Николай on 27.03.2022.
//

import UIKit

class UICollectionViewViewController: UIViewController {
    
    var imageSet = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for item in imageSet {
            if let url = item.sizes.last?.url{
                print(url)
            }
        }
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
