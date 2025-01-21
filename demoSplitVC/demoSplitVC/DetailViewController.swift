//
//  DetailViewController.swift
//  demoSplitVC
//
//  Created by apple on 02/03/24.
//

import UIKit

class DetailViewController: UIViewController, ColorSelectionDelegate {
    func colorSelected(selectedColor: UIColor) {
        view.backgroundColor = selectedColor
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        MasterViewController.delegate = self
        // Do any additional setup after loading the view.
        title = "Selected color"
    }
    
}
