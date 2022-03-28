//
//  ThirdCollectionViewCell.swift
//  Mobile Up Gallery
//
//  Created by Чаусов Николай on 28.03.2022.
//

import UIKit

class ThirdCollectionViewCell: UICollectionViewCell {
    
    var viewUIimage = UIImageView()
    
    
    func doIt(url: String, width: CGFloat){
        let cellView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        viewUIimage = UIImageView(frame: self.bounds)
        cellView.addSubview(viewUIimage)
        viewUIimage.clipsToBounds = true
        viewUIimage.contentMode = .scaleAspectFill
        viewUIimage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cellView)
        
        viewUIimage.sd_setImage(with: URL(string: url),placeholderImage: UIImage(named: "placeholder"))
    }
    
    override func prepareForReuse() {
        viewUIimage.image = nil
    }
    
    
}
