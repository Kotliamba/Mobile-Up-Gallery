//
//  SecondCell.swift
//  Mobile Up Gallery
//
//  Created by Чаусов Николай on 28.03.2022.
//

import UIKit

class SecondCell: UICollectionViewCell {
    
    let testImage = UIImage(named: "testImage")
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        print("Initializing")
        let cellView = UIView(frame: frame)
        self.contentView.addSubview(cellView)

        cellView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(frame.width)
            make.height.equalTo(frame.height)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        imageView.image = testImage
        
        print("BOUNDS ", self.bounds)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
