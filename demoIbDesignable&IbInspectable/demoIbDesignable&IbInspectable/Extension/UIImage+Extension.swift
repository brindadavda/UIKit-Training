//
//  UIImage+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import UIKit
import PDFKit

extension UIImage {
    
    func resize(compress ratio:CGFloat? = nil, size imageSize:CGSize? = nil) -> UIImage {
        var rect = CGRect()
        if let ratio = ratio {
            rect = CGRect(x: 0, y: 0, width: size.width * ratio, height: size.height * ratio)
        }else if let imageSize = imageSize {
            rect = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
        }
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
    
    func saveInDirectory(fileName: String, extension _extension: String = "png", complition: ((_ directory: URL) -> ())? = nil) {
        if _extension == "png" {
            self.pngData()?.saveInDirectory(fileName: fileName, extension: _extension, complition: complition)
        }else if _extension == "jpg" || _extension == "jpeg" {
            self.jpegData(compressionQuality: 1)?.saveInDirectory(fileName: fileName, extension: _extension, complition: complition)
        }
    }
    
    func pngToBase64() -> String {
        return self.pngData()?.base64EncodedString(options: .endLineWithLineFeed) ?? ""
    }
    
    func upOrientationImage() -> UIImage? {
        switch imageOrientation {
        case .up:
            return self
        default:
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            draw(in: CGRect(origin: .zero, size: size))
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return result
        }
    }
}

