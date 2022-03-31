import UIKit

struct Model{
    
    let defaults = UserDefaults.standard
    
    var token: String?
    var tokenDate = 0
    var items: [Item]?
    
    weak var itemsFetchDelegate: itemsFetchDelegate?
    weak var alerErrordelegate: AlertErrorDelegate?
    
    func saveToken(){
        defaults.set(self.token, forKey: "UserToken")
        defaults.set(self.tokenDate, forKey: "TokenDate")
    }
    
    mutating func setNewToken(with str: String) {
        let token = makeTokenFromUrl(url: str)
        self.token = token
        
        let date = Date()
        let timeInterval = date.timeIntervalSince1970
        let dateToSave = Int(timeInterval)
        self.tokenDate = dateToSave
        saveToken()
    }
    
    func makeTokenFromUrl(url: String) -> String{
        let start = url.index(url.startIndex, offsetBy: 45)
        let end = url.index(url.startIndex, offsetBy: (45+84))
        let substr = url[start...end]
        
        return String(substr)
    }
    
    func isTokenWorking() -> Bool{
        let tokenDate = defaults.integer(forKey: "TokenDate")
        let newdDate = Date()
        let timeinterval = (Int(newdDate.timeIntervalSince1970))
        if timeinterval-tokenDate>=86400 {
            return false
        } else {
            return true
        }
    }
    
    mutating func getSavedToken(){
        self.token = defaults.string(forKey: "UserToken") ?? ""
    }

    
    func buildRequestUrl() -> String?{
        let ownerId = "-128666765"
        let albumId = "266276915"
        let version = "5.131"
        guard let token = self.token else {return nil}
        let str = "https://api.vk.com/method/photos.get?owner_id=\(ownerId)&album_id=\(albumId)&access_token=\(token)&v=\(version)"
        return str
    }
    
    func callDelegateDownloadFalse(_ reason: DownloadFallReason){
        DispatchQueue.main.async{
            alerErrordelegate?.downloadingFalled(with: reason)
        }
    }
    
    
    mutating func getServerResponse(to url:String){
        guard let requestURL = URL(string: url) else {
            callDelegateDownloadFalse(.URLIsFalse)
            return
        }
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: requestURL) { [self]  data, _, error in
            if let _ = error {
                callDelegateDownloadFalse(.noConnection)
            }
            guard let data = data else {
                return
            }
            guard let decodedData = parseJson(data) else {return}
            itemsFetchDelegate?.updateItems(decodedData)
        }
        dataTask.resume()
    }
    
    func parseJson(_ data:Data) -> [Item]?{
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(AlbumModel.self, from: data)
            let images = decodeData.response
            let answer = AlbumModel(response: images)
            return answer.response.items
        } catch {
            print(error)
            callDelegateDownloadFalse(.URLIsFalse)
            return nil
        }
    }
}

