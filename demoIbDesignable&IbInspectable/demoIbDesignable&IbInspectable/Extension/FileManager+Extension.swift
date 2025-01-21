//
//  FileManager+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import UIKit

extension FileManager {
 
    static func clearAllFiles() {
        let fileManager = FileManager.default
        guard let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return }
        do {
            let fileName = try fileManager.contentsOfDirectory(atPath: paths)
            for file in fileName {
                let filePath = URL(fileURLWithPath: paths).appendingPathComponent(file).absoluteURL
                try fileManager.removeItem(at: filePath)
            }
        } catch let error {
            print(error)
        }
    }
}
