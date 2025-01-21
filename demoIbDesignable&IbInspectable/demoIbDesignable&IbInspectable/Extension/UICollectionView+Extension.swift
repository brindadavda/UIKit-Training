//
//  UICollectionView+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import UIKit

extension UICollectionView {
    
    func cell<T:UICollectionViewCell>(_ type:T, indexPath: IndexPath) -> T? {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: type.makeName, for: indexPath) as? T else {
            return nil
        }
        return cell
    }
}
