import Foundation

extension String {
    
    var formatToHTTPS: String {
        var formattedURL = self
        guard !formattedURL.isEmpty, formattedURL.count > 5 else { return formattedURL }
        if !self.substring(to: 5).elementsEqual("https") {
            formattedURL.insert("s", at: self.index(self.startIndex, offsetBy: 4))
        }
        return formattedURL
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
