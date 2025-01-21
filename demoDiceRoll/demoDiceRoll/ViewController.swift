//
//  ViewController.swift
//  demoDiceRoll
//
//  Created by apple on 10/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageVIew1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    
    //setting images array
    let images = ["dice1","dice2","dice3","dice4","dice5","dice6"]
    
    
    @IBAction func actionRollDice(_ sender: UIButton) {
        //show your action here
        //for dice role
        let roll1Index : Int = Int(arc4random_uniform(6)) // 0...5
        let roll2Index : Int = Int(arc4random_uniform(6))  // 0...5
        
        imageVIew1.image = UIImage(named: images[roll1Index]+".png")
        imageView2.image = UIImage(named: images[roll2Index]+".png")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }


}

