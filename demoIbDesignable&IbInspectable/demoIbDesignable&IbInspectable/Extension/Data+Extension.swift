//
//  Data+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import UIKit

extension Data {
    
    func asImage() -> UIImage? {
        return UIImage(data: self)
    }
    
    func saveInDirectory(fileName: String, extension _extension: String = "png", complition: ((_ directory: URL) -> ())? = nil) {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = directory.appendingPathComponent("\(fileName).\(_extension)")
        var data: Data?
        if _extension == "png" {
            data = self
        }else if _extension == "jpg" || _extension == "jpeg" {
            data = self
        }
        if let data = data {
            do {
                try data.write(to: fileURL)
                complition?(fileURL)
            } catch {
                print("error saving file to documents:", error)
            }
        }
    }
}
