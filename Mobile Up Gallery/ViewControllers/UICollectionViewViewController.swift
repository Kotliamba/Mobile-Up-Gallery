//
//  UICollectionViewViewController.swift
//  Mobile Up Gallery
//
//  Created by Чаусов Николай on 27.03.2022.
//

import UIKit
import SnapKit
import SDWebImage

class UICollectionViewViewController: UIViewController {
    
    var imageSet = [Item]()
    let testImage = UIImage(named: "testImage")
    
    var setOfURLs = [String]()
    
    var setOfDates = [Int]()
    
    var viewWidth = CGFloat(0)
    
    var imageUrlTestSet = ["https://sun9-38.userapi.com/impf/c855216/v855216374/155021/sD1z-P0M5rM.jpg?size=1280x853&quality=96&sign=67158a2f2ae1a4eda43a5c2ae47718d2&type=album", "https://sun9-81.userapi.com/impf/rR5pPP45vh5vHxlKbFs5glLwMbphaJW_TBKHmg/3_n8spqOChQ.jpg?size=1280x853&quality=96&sign=ead0298bfec1ed05c77e3ee26d694fc9&type=album", "https://sun9-69.userapi.com/impf/SQtm3xGpOlS5kI4eJ-5lH649LF-359MCNFnBiw/6Ty2cvJ9xlE.jpg?size=1280x853&quality=95&sign=7684a477931e71c4bac7bb73f4b3d462&type=album", "https://sun9-28.userapi.com/impf/BeGsQT3s5B9F7-zRAkQ7cKpFGoxW6TtvKoiGCg/yi_vKyI_23U.jpg?size=1280x853&quality=96&sign=553ba2eacd1309d8d9e2a84860be357a&type=album",     "https://sun9-70.userapi.com/impf/_Cf-3MYGw8CNxoJU3C_y9Gwh-hsXgtM0B1ERFw/Ld-cKbzHRhk.jpg?size=1280x853&quality=95&sign=5ea7b5e25252545d66fa1dff25941a9e&type=album", "https://sun9-85.userapi.com/impf/aMYHbO-hOkHV_BXCwPO51AtpAIHhlEucXnG6OA/hB4IDG95pb0.jpg?size=1280x853&quality=95&sign=bf06f4441c7d9a196e105218c28c6aec&type=album", "https://sun9-47.userapi.com/impf/B_8I4o31GgOGX_1oCChI1UuciK1FcZa1jMxbNw/qur-8xawoJU.jpg?size=1280x853&quality=96&sign=9f448003ec38414bc0edb0fdfb01c4aa&type=album", "https://sun9-19.userapi.com/impf/rRlfFuhkYTqxwmwCJeT7hW18dEgft4epaQmUGQ/e5bf4iwe6PY.jpg?size=1280x853&quality=95&sign=b54088131d8d8f1b724a1632955d86af&type=album", "https://sun9-88.userapi.com/impf/OC5TM-brk2soK6CJm9vxNJXHYEseNHsEhRnjgQ/ghynj8C5wNg.jpg?size=1280x853&quality=95&sign=2bddbad65c5676129f8004be7a2c91c5&type=album", "https://sun9-63.userapi.com/impf/gn7IELSKBwzvlCT-GJnjbEAd77jZGIcfKPa_wQ/xDaXBq5T5XY.jpg?size=1280x853&quality=96&sign=e79152d9ceaa112f52fe8c5685e03e15&type=album", "https://sun9-32.userapi.com/impf/SG16wcmC7uZ-MTcO9u-OynvyEy7J9TDPi_-udw/cbMljtiGkfs.jpg?size=1280x853&quality=96&sign=ebdaaea84d51f0852028c0fbb080775b&type=album", "https://sun9-38.userapi.com/impf/l4cj-9mCVHZNcJUIr6lzX898-IO7jQQWxtlKnw/MYbiwPe4Sec.jpg?size=1280x853&quality=96&sign=500f9ce080439103676547a5a6e478c3&type=album" ]
    
    var dateImageTest = [1572948926,1628857637,1641810946,1572948926,1628857637,1641810946,1572948926,1628857637,1641810946,1572948926,1628857637,1641810946]
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        
        return collection
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = "Mobile Up Gallery"
        label.font = UIFont.SFDisplaySemibold(size: 18)
        label.textColor = .black
        
        return label
    }()
    
    private var rightButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выход", for: .normal)
        button.titleLabel?.font = UIFont.SFDisplayMedium(size: 18)
        button.setTitleColor(UIColor.black, for: .normal)
         
        return button
    }()
    
    private var safeAreaView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in imageSet {
            if let url = item.sizes.last?.url{
                setOfURLs.append(url)
            }
        }
        for item in imageSet {
            setOfDates.append(item.date)
        }
        
        self.view.backgroundColor = .white
        
        view.addSubview(safeAreaView)
        
        safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        safeAreaView.backgroundColor = .green
        
        rightButton.addTarget(self, action: #selector(toFirstViewController), for: .touchUpInside)
        
        self.navigationItem.titleView = label
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)

        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(ThirdCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        
        makeConstraints()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.backgroundColor = .white
    }
    
    @objc private func toFirstViewController(){
        print("Trying to die")
        self.dismiss(animated: true)
    }
    
     func makeConstraints(){
         let guide = view.safeAreaLayoutGuide
         NSLayoutConstraint.activate([
             safeAreaView.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
             safeAreaView.bottomAnchor.constraint(equalToSystemSpacingBelow: guide.bottomAnchor, multiplier: 1.0),
             safeAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             safeAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
         ])
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaView)
        }
     }
}

extension UICollectionViewViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let newVC = PhotoController(url: setOfURLs[indexPath.row], date: setOfDates[indexPath.row])
        self.navigationController?.pushViewController(newVC, animated: true)
        print("Cell tapped")
    }
}
extension UICollectionViewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return setOfURLs.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! ThirdCollectionViewCell
        cell.doIt(url: setOfURLs[indexPath.row], width: viewWidth-1)
        
        return cell
    }
    
    
}
extension UICollectionViewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewWidth = view.frame.width/2
        return CGSize(width: viewWidth-1, height: viewWidth-1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
