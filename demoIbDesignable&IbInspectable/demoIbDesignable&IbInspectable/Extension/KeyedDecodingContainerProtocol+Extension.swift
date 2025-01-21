//
//  KeyedDecodingContainerProtocol+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import Foundation

extension KeyedDecodingContainerProtocol {
    func decodeString(forKey:KeyedDecodingContainer<Key>.Key) -> String {
        if let value = try? self.decodeIfPresent(String.self, forKey: forKey) {
            return value
        }else if let value = try? self.decodeIfPresent(Int.self, forKey: forKey) {
            return  "\(value)"
        }else if let value = try? self.decodeIfPresent(Double.self, forKey: forKey) {
            return  "\(value)"
        }
        return ""
    }
    
    func decodeArrayString(forKey:KeyedDecodingContainer<Key>.Key) -> [String] {
        if let value = try? self.decodeIfPresent([String].self, forKey: forKey) {
            return value
        }else if let value = try? self.decodeIfPresent([Int].self, forKey: forKey) {
            return value.map({ $0.string })
        }else if let value = try? self.decodeIfPresent([Double].self, forKey: forKey) {
            return value.map({ $0.string })
        }
        return []
    }
    
    func decodeInt(forKey:KeyedDecodingContainer<Key>.Key) -> Int {
        if let value = try? self.decodeIfPresent(String.self, forKey: forKey) {
            return Int(value) ?? 0
        }else if let value = try? self.decodeIfPresent(Int.self, forKey: forKey) {
            return  value
        }else if let value = try? self.decodeIfPresent(Double.self, forKey: forKey) {
            return  Int(value)
        }
        return 0
    }
    
    func decodeInt64(forKey:KeyedDecodingContainer<Key>.Key) -> Int64 {
        if let value = try? self.decodeIfPresent(String.self, forKey: forKey) {
            return Int64(value) ?? 0
        }else if let value = try? self.decodeIfPresent(Int64.self, forKey: forKey) {
            return  value
        }else if let value = try? self.decodeIfPresent(Double.self, forKey: forKey) {
            return  Int64(value)
        }
        return 0
    }
    
    func decodeDouble(forKey:KeyedDecodingContainer<Key>.Key) -> Double {
        if let value = try? self.decodeIfPresent(String.self, forKey: forKey) {
            return Double(value) ?? 0
        }else if let value = try? self.decodeIfPresent(Int.self, forKey: forKey) {
            return  Double(value)
        }else if let value = try? self.decodeIfPresent(Double.self, forKey: forKey) {
            return  value
        }
        return 0
    }
    
    func decodeBool(forKey:KeyedDecodingContainer<Key>.Key) -> Bool {
        if let value = try? self.decodeIfPresent(Bool.self, forKey: forKey) {
            return value
        }
        return false
    }
    
    func decodeData(forKey:KeyedDecodingContainer<Key>.Key) -> Data? {
        if let value = try? self.decodeIfPresent(Data.self, forKey: forKey) {
            return value
        }
        return nil
    }
    
    func decodeDate(forKey:KeyedDecodingContainer<Key>.Key) -> Date? {
        if let value = try? self.decodeIfPresent(Date.self, forKey: forKey) {
            return value
        }
        return nil
    }
    
    func decodeObject<T:Codable>(_ type:T.Type, forKey:KeyedDecodingContainer<Key>.Key) -> T? {
        if let value = try? self.decodeIfPresent(type, forKey: forKey) {
            return value
        }
        return nil
    }
}
