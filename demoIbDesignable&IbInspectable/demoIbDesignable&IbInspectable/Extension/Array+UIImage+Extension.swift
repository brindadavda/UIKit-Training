//
//  File.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import UIKit

extension Array where Element == UIImage {
    
    func createPDF(_ fileName: String, complition: @escaping ((_ url: URL?) -> ())) {
        let data = NSMutableData()
        UIGraphicsBeginPDFContextToData(data, CGRect.zero, nil)
        for image in self {
            let imgView = UIImageView.init(image: image)
            UIGraphicsBeginPDFPageWithInfo(imgView.bounds, nil)
            let context = UIGraphicsGetCurrentContext()
            imgView.layer.render(in: context!)
        }
        UIGraphicsEndPDFContext()
        if let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("\(fileName)").appendingPathExtension("pdf") {
            data.write(to: outputURL, atomically: true)
            complition(outputURL)
            return
        }
        complition(nil)
    }
}
