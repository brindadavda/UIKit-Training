//
//  CustomViewVC.swift
//  demoAutoLayout
//
//  Created by apple on 11/03/24.
//

import UIKit

class CustomViewVC: UIViewController {

    @IBOutlet weak var CustomShapeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        DispatchQueue.main.async {
            print("CustomViewVC : ---> \(self.CustomShapeView.bounds.height)")
        }
        
        
        let shape = CustomeShap(startPoint: CGPoint(x: 0, y: CustomShapeView.bounds.height/2))
        let subLayer = shape.getCustomeShape()
        
        CustomShapeView.layer.addSublayer(subLayer)
        
        CustomShapeView.backgroundColor = .cyan
        
        
    }
}
