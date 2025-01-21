//
//  TableView+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import UIKit

extension UITableView {
    
    func cell<T:UITableViewCell>(_ type:T, indexPath: IndexPath) -> T? {
        guard let cell = self.dequeueReusableCell(withIdentifier: type.makeName, for: indexPath) as? T else {
            return nil
        }
        return cell
    }
}

