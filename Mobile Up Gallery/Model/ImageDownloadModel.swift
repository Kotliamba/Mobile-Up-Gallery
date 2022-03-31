import UIKit

struct ImageDownloadModel{
    
    weak var downloadImageDelegate: downloadImageDelegate?
    weak var alertErrorDelegate: AlertErrorDelegate?
 
    func downloadImage(from url: String) {
        guard let requestURL = URL(string: url) else {
            alertErrorDelegate?.downloadingFalled(with: .URLIsFalse)
            return
        }
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            if let _ = error {
                alertErrorDelegate?.downloadingFalled(with: .noConnection)
            }
            guard let data = data else { return }
            DispatchQueue.main.async() {
                guard let image = UIImage(data: data) else {
                    alertErrorDelegate?.downloadingFalled(with: .noConnection)
                    return
                }
                downloadImageDelegate?.setImage(with: image)
            }
        }.resume()
    }
}
