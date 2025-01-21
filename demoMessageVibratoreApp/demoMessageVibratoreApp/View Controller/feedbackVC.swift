//
//  feedbackVC.swift
//  demoMessageVibratoreApp
//
//  Created by apple on 12/02/24.
//

import UIKit

class feedbackVC: UIViewController {

    @IBOutlet weak var backbtn: UIButton!
    
    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    }
    

   

}
