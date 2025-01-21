//
//  ViewController.swift
//  demoSplitVC
//
//  Created by apple on 02/03/24.
//

import UIKit

class ViewController: UIViewController {

    var text = ""  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        titleLbl.text = text
    }


    @IBOutlet weak var titleLbl: UILabel!
}

