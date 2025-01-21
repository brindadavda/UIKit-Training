//
//  String+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import UIKit

extension String {
    
    var empty:Bool {
        return self.isEmpty == true || self.trimmingCharacters(in: .whitespacesAndNewlines) == "" || self == ""
    }
    
    func trim(_ characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        return self.trimmingCharacters(in: characterSet)
    }
    
    var isValidEmail:Bool {
        let email = self
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
    
    var base64ToImage:UIImage? {
        guard let imageData = Data(base64Encoded: self) else { return nil }
        return UIImage(data: imageData)
    }
    
    var double:Double {
        return Double(self) ?? 0.0
    }
    
    var int:Int {
        return Int(Double(self) ?? 0.0)
    }
    
    var float:Float {
        return Float(self) ?? 0.0
    }
    
    func extractLinksFromString() -> [URL] {
        var arrURL = [URL]()
        let text = self
        let types: NSTextCheckingResult.CheckingType = .link
        let detector = try? NSDataDetector(types: types.rawValue)
        guard let detect = detector else {
           return []
        }
        let matches = detect.matches(in: text, options: .reportCompletion, range: NSMakeRange(0, text.count))
        for match in matches {
            if let url = match.url {
                arrURL.append(url)
            }
        }
        return arrURL
    }
    
    func flag() -> String {
        let country = self
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
    
    func replaceHexToEmpty() -> String {
        return self.replacingOccurrences(of: "#", with: "")
    }
    
    func addHexInColorCode() -> String {
        return "#\(self.replaceHexToEmpty())"
    }
    
    func generateQRCode() -> UIImage? {
        let string = self
        let data = string.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    static func CheckFornull(cstring:UnsafePointer<UInt8>!) -> String {
        if let csString = cstring {
            return String(cString: csString)
        } else {
            return ""
        }
    }
    
    var color: UIColor? {
        return UIColor(hex: self)
    }
    
    var colorFromHex: UIColor {
        var code = self
        if code.contains("x") {
            code = self.components(separatedBy: "x").last ?? ""
        }
        var cString:String = code.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func unicodeToEmoji() -> String {
        var result = self
        do {
            let regex = try NSRegularExpression(pattern: "(U\\+([0-9A-F]+))", options: [.caseInsensitive])
            let matches = regex.matches(in: result, options: [], range: NSRange(location: 0, length: result.utf16.count))
            for m in matches.reversed() {
                let range1 = m.range(at: 1)
                let range2 = m.range(at: 2)
                if let codePoint = Int(result[Range(range2, in: result)!], radix: 16) {
                    let emoji = String(UnicodeScalar(codePoint)!)
                    let startIndex = result.index(result.startIndex, offsetBy: range1.location)
                    let endIndex = result.index(startIndex, offsetBy: range1.length)
                }
            }
        } catch {
            print("Error in regex: \(error)")
        }
        return result
    }
}
