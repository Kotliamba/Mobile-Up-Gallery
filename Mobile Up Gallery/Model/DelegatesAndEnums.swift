import UIKit

protocol tokenAccessDelegate: AnyObject {
    func updateUrlWithToken(url: String)
    func webKitFall()
}
protocol itemsFetchDelegate {
    func updateItems(_ :[Item])
    func downloadingFalled(with problem: DownloadFallReason)
}

enum DownloadFallReason{
    case noConnection
    case URLIsFalse
}
