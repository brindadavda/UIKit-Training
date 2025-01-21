//
//  Bundel+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import UIKit

extension Bundle {
    
    static var version:String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    static var build: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
    
    static var identifier: String {
        return Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? ""
    }
    
    static var displayName: String {
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    }

    static func nibView<T:UIView>(_ view:T.Type, owner:Any? = nil,options:[UINib.OptionsKey : Any]? = [UINib.OptionsKey : Any]()) -> T? {
        return (Bundle.main.loadNibNamed(T().makeName, owner: owner, options: options)?.filter({ if let _ = $0 as? T { return true } else { return false }}).first as? T)
    }
    
    static func nibMultiView<T:UIView>(nibName:String, view:T.Type, owner:Any? = nil,options:[UINib.OptionsKey : Any]? = [UINib.OptionsKey : Any]()) -> T? {
        return (Bundle.main.loadNibNamed(nibName, owner: owner, options: options)?.filter({ if let _ = $0 as? T { return true } else { return false }}).first as? T)
    }
    
    static func filePathToData(forResource:String, ofType:String) -> Data? {
        if let path = Bundle.main.path(forResource: forResource, ofType: ofType) {
            return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        }
        return nil
    }
    
    static func filePathToJSON(forResource:String, ofType:String) -> Any? {
        if let path = Bundle.main.path(forResource: forResource, ofType: ofType), let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
            return try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        }
        return nil
    }
}
