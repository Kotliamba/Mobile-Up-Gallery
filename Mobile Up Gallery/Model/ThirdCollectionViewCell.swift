import UIKit

class ThirdCollectionViewCell: UICollectionViewCell {
    
    var viewUIimage = UIImageView()
    
    var loadedImage = UIImage()
    
    func doIt(url: String, width: CGFloat){
        let cellView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        viewUIimage = UIImageView(frame: self.bounds)
        viewUIimage.image = UIImage(named: "placeholder")
        viewUIimage.clipsToBounds = true
        viewUIimage.contentMode = .scaleAspectFill
        viewUIimage.translatesAutoresizingMaskIntoConstraints = false
    
        contentView.addSubview(cellView)
        cellView.addSubview(viewUIimage)
        
        downloadImage(from: URL(string: url)!)
    }

    
    func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.viewUIimage.image = UIImage(data: data)
            }
        }.resume()
    }
    
    override func prepareForReuse() {
        viewUIimage.image = UIImage(named: "placeholder") ?? nil
    }
}
