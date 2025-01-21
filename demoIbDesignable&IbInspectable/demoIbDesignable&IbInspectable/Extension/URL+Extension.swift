//
//  URL+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import Foundation

extension URL {
    
    var documentsDirectory: URL {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return URL(string: documentsDirectory)!
    }
    
    func urlInDocumentsDirectory(with filename: String) -> URL {
        return documentsDirectory.appendingPathComponent(filename)
    }
    
    func createDirectory(withIntermediateDirectories:Bool = true, attributes:[FileAttributeKey : Any]? = nil) -> Bool {
        do {
            try FileManager.default.createDirectory(atPath: self.path, withIntermediateDirectories: withIntermediateDirectories, attributes: attributes)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func exitsDirectory() -> Bool {
        return FileManager.default.fileExists(atPath: self.path)
    }
}
