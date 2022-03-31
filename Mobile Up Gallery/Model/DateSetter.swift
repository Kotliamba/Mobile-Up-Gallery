import Foundation

struct DateSetter {
    
    static func getDate(date: Int) -> String{
        let timeInterval = TimeInterval(date)
        let NSdate = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "d MMMM yyyy"
        return dateFormatter.string(from: NSdate)
    }
}
