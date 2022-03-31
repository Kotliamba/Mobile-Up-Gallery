import UIKit

class ThirdCollectionViewCell: UICollectionViewCell{
    
    var viewUIimage = UIImageView()
    
    var loadedImage = UIImage()
    
    var downloadModel = ImageDownloadModel()
    
    func configurate(url: String, width: CGFloat){
        let cellView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        viewUIimage = UIImageView(frame: self.bounds)
        viewUIimage.image = UIImage(named: "placeholder")
        viewUIimage.clipsToBounds = true
        viewUIimage.contentMode = .scaleAspectFill
        viewUIimage.translatesAutoresizingMaskIntoConstraints = false
    
        contentView.addSubview(cellView)
        cellView.addSubview(viewUIimage)
        
        downloadModel.downloadImageDelegate = self
        
        downloadModel.downloadImage(from: url)
    }

    override func prepareForReuse() {
        viewUIimage.image = UIImage(named: "placeholder") ?? nil
    }
}

extension ThirdCollectionViewCell: downloadImageDelegate {
    func setImage(with image: UIImage) {
        DispatchQueue.main.async {
            self.viewUIimage.image = image
        }
            
    }
}
