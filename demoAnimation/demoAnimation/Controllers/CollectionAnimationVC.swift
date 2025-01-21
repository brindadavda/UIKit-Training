//
//  CollectionAnimationVC.swift
//  demoAnimation
//
//  Created by apple on 18/04/24.
//

import UIKit

class CollectionAnimationVC: UIViewController {
    
    
    static let storyboardIdentifier = "CollectionAnimationVC"
    
    @IBOutlet weak var cv: UICollectionView!
    
    let total_no_of_cell = 100
    
    let cell_reusable_identifier = "cell"
    
    static let cell_width = 50
    static let cell_hight = 50
    
    var selectedAnimationType : AnimationType = .fadeIn
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        cv.delegate = self
        cv.dataSource = self
    }
 
    
    
   
}


