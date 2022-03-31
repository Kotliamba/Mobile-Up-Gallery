import UIKit

protocol tokenAccessDelegate: AnyObject {
    func updateUrlWithToken(url: String)
    func webKitFall()
}

protocol downloadImageDelegate: AnyObject{
    func setImage(with image:UIImage)
}

protocol itemsFetchDelegate: AnyObject {
    func updateItems(_ :[Item])
}
protocol AlertErrorDelegate: AnyObject {
    func downloadingFalled(with problem: DownloadFallReason)
}

enum DownloadFallReason{
    case noConnection
    case URLIsFalse
}
