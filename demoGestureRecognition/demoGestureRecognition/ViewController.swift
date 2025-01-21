//
//  ViewController.swift
//  demoGestureRecognition
//
//  Created by apple on 09/01/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeActionMoveForward(swipe:)))
        //set the direction of gesture
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        
        //adding gesture to self view
        self.view.addGestureRecognizer(leftSwipe)
    }
    
    
    //swipeAction func
    @objc func swipeActionMoveForward(swipe: UISwipeGestureRecognizer){
        //perform selectore
        performSegue(withIdentifier: "moveForward", sender: self)
    }


}

