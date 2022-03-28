//
//  ColCell.swift
//  Mobile Up Gallery
//
//  Created by Чаусов Николай on 28.03.2022.
//

import UIKit
import SnapKit

class ColCell: UICollectionViewCell {
    
    let testImage = UIImage(named: "testImage")
    
    var url = "" {
        didSet {
            imageView.image = testImage
            imageView.sd_setImage(with: URL(string: url))
        }
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var somedata = "AAA"
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
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
        
        print("BOUNDS ", self.bounds)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    


    func config(with image: UIImage){
        self.imageView.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    static func nib() -> UINib {
        
        return UINib(nibName: "ColCell", bundle: nil)
    }
}
