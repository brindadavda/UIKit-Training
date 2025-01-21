//
//  Animation.swift
//  demoAnimation
//
//  Created by apple on 18/04/24.
//

import UIKit

class Animations{
    static let animationDuration: Double = 1.5
    static let delayBase: Double = 2.0
}


enum AnimationType {
    case fadeIn
    case indexDelay(IndexDelayType)
    case distanceDelay
    case transition
}

enum IndexDelayType {
    case fastMode
    case slowMode
}

extension Animations{
    class func fadeIn(cell : inout UICollectionViewCell){
        cell.alpha = 1
    }
    
    class func indexDelay(at index : Int, completion : @escaping () -> Void , delayMode : IndexDelayType){
        let fastDelay = sqrt(Double(index)) * Animations.delayBase
        let slowDelay = Double(index) * Animations.delayBase
        
        let delay = delayMode == .fastMode ? fastDelay : slowDelay
        
        UIView.animate(withDuration: Animations.animationDuration, delay: delay, options: .curveEaseOut, animations: {
          completion()
        })
    }
    
    class func distanceDelay(cell : UICollectionViewCell , completion : @escaping () -> Void){
        let column = Double(cell.frame.minX / cell.frame.width)
        let row = Double(cell.frame.minY / cell.frame.height)
        
        let distance = sqrt(pow(column, 2) + pow(row, 2))
        let delay = sqrt(distance) * Animations.delayBase
        UIView.animate(withDuration: Animations.animationDuration, delay: delay, options: [], animations: {
            completion()
        })
    }
    
    
    class func transitionEffect(cell : UICollectionViewCell , completion : @escaping () -> Void){
        cell.alpha = 1
        cell.transform = .identity
        
        UIView.animate(withDuration: animationDuration, delay: delayBase, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: [], animations: {
          completion()
        })
    }
    
    
}
