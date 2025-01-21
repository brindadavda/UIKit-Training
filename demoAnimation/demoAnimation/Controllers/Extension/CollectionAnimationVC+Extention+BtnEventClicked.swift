//
//  CollectionAnimationVC+Extention+BtnEventClicked.swift
//  demoAnimation
//
//  Created by apple on 18/04/24.
//

import UIKit

//MARK :- Button Clicked Event
extension CollectionAnimationVC{
    @IBAction func fadeInAction(_ sender: UIButton) {
        selectedAnimationType = .fadeIn
        cv.reloadData()
    }
    
    
    @IBAction func indexDelayAction(_ sender: UIButton) {
        
        let bottomSheet = UIAlertController(title: nil, message: "Select Index Delay Type.", preferredStyle: .actionSheet)
        
        let fastmodeAction = UIAlertAction(title: "Fast Animation", style: .default , handler: {_ in
            self.selectedAnimationType = .indexDelay(.fastMode)
        })
        
        let slowmodeAction = UIAlertAction(title: "Slow Animation", style: .default,handler: {_ in
            self.selectedAnimationType = .indexDelay(.slowMode)
        })
        
        bottomSheet.addAction(fastmodeAction)
        bottomSheet.addAction(slowmodeAction)
        
        self.present(bottomSheet, animated: true,completion: {
            self.cv.reloadData()
        })
        
    }

    @IBAction func distanceDelayAction(_ sender: UIButton) {
        selectedAnimationType = .distanceDelay
        cv.reloadData()
    }
    
    @IBAction func transitionEffectAction(_ sender: UIButton) {
        selectedAnimationType = .transition
        cv.reloadData()
    }
    
}
