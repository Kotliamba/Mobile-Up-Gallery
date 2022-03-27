import UIKit

protocol tokenAccessDelegate: AnyObject {
    func updateUrlWithToken(url: String)
}
protocol itemsFetchDelegate {
    func updateItems(_ :[Item])
}
struct Model{
    var token: String?
    var tokenDate: Date?
    var items: [Item]?
    var itemsFetchDelegate: itemsFetchDelegate?

    func getLastToken() -> String? {
        return token
    }
    
    mutating func setNewToken(with str: String) {
        let token = makeTokenFromUrl(url: str)
        self.token = token
        self.tokenDate = Date()
    }
    
    func makeTokenFromUrl(url: String) -> String{
        let start = url.index(url.startIndex, offsetBy: 45)
        let end = url.index(url.startIndex, offsetBy: (45+84))
        let substr = url[start...end]
        
        return String(substr)
    }
    
    func isTokenWorking() -> Bool{
        guard let date = self.tokenDate else { return false}
        let timeinterval = (Int(date.timeIntervalSinceNow) * -1)
        if timeinterval>=86400 {
            return false
        } else {
            return true
        }
    }
    
    func buildRequestUrl() -> String?{
        let ownerId = "-128666765"
        let albumId = "266276915"
        let version = "5.131"
        guard let token = self.token else {return nil}
        let str = "https://api.vk.com/method/photos.get?owner_id=\(ownerId)&album_id=\(albumId)&access_token=\(token)&v=\(version)"
        return str
    }
    
    mutating func getServerResponse(to url:String){
        guard let requestURL = URL(string: url) else {return}
        print("Запрос по адресу + \(url)")
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: requestURL) { [self]  data, response, error in
            if let error = error {
                print("ERROR!")
                print(error)
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
            return nil
        }
    }
}

