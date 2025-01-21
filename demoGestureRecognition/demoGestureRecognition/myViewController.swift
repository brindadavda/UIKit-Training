//
//  myViewController.swift
//  demoGestureRecognition
//
//  Created by apple on 09/01/24.
//

import UIKit

class myViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        //set the direction of gesture
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        
        //adding gesture to self view
        self.view.addGestureRecognizer(rightSwipe)
        
    }
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer){
        //perform selectore
        print("potjtj")
        performSegue(withIdentifier: "moveBackword", sender: self)
    }


}
