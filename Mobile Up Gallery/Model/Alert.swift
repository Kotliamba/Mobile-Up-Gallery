import UIKit

extension UIViewController {
    
    func alertError(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertController.addAction(alertOk)
        
        present(alertController, animated: true)
    }
    
}
