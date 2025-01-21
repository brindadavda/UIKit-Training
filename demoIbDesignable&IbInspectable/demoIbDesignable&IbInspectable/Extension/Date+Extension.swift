//
//  Date+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import Foundation

extension Date {
    
    func timeStamp() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
    func formateToString(_ output :DateFormate = .yyyy_MM_ddHHmmssaZ, timeZone:TimeZone? = TimeZone(abbreviation: "UTC")) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = output.rawValue
        let stringDate = dateFormatter.string(from: self)
        return stringDate
    }
    
    func formateToGMTtimeString(_ input:DateFormate = .yyyy_MM_ddHHmmssaZ, timeZone:TimeZone? = TimeZone(abbreviation: "UTC")) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = input.rawValue
        let timeDateString = dateFormatter.string(from: self)
        return timeDateString
    }
    
    func formate(_ output :DateFormate = .yyyy_MM_ddHHmmssaZ, timeZone:TimeZone? = TimeZone(abbreviation: "UTC")) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = output.rawValue
        let stringDate = dateFormatter.string(from: self)
        return stringDate
    }
}


enum DateFormate:String {
    case yyyyMMddTHHmmssSSSXXXXX = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    case MMddyyyyhhmma = "MM/dd/yyyy hh:mm a"
    case MMddyyyyhhmmssa = "MM/dd/yyyy hh:mm:ss a"

    case yyyy_MM_ddTHHmmssSSSZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case yyyy_MM_ddTHHmmssZ = "yyyy-MM-dd'T'HH:mm:ssZ"
    case ddMMyyyyhhmmssa = "dd/MM/yyyy hh:mm:ss a"
    
    case yyyy_MM_ddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
    case yyyy_MM_ddhhmmss = "yyyy-MM-dd hh:mm:ss"
    case yyyy_MM_ddHHmmss = "yyyy-MM-dd HH:mm:ss"
    case yyyy_MM_ddHHmmssZ = "yyyy-MM-dd HH:mm:ss Z"
    case yyyy_MM_ddhhmmssaZ = "yyyy-MM-dd hh:mm:ss a Z"
    case yyyy_MM_ddHHmmssaZ = "yyyy-MM-dd HH:mm:ss a Z"
    case hhmma = "hh:mm a"
    case ddMMyyyy = "dd/MM/yyyy"
    case MMddyyyy = "MM/dd/yyyy"
    case yyyy_MM_dd = "yyyy-MM-dd"
    case yyyyMMddHHmmssSSSS = "yyyyMMddHHmmssSSSS"
    case dd_MMMM_yyyy = "dd MMMM yyyy"
    case dd_MM_yyyy = "dd-MM-yyyy"
    case MM_dd_yyyy = "MM-dd-yyyy"
    case d_MMMM_yyyy = "d MMMM yyyy"
    case HHmm = "HH:mm"
    case HHmmss = "HH:mm:ss"
    case MMMMyyyy = "MMMM yyyy"
    case HHmm_dd_MMMM_yyyy = "HH:mm dd MMMM yyyy"
    case HHmm__dd_MMM_yyyy = "HH:mm, dd MMM yyyy"

    case yyyyMMddTHHmmssSSZ = "yyyy-MM-dd'T'HH:mm:ss.SSZ"

}
