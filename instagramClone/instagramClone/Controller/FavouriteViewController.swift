//
//  FavouriteViewController.swift
//  instagramClone
//
//  Created by apple on 15/01/24.
//

import UIKit

class FavouriteViewController: UIViewController {

    @IBOutlet weak var IV: UIImageView!
    
    @IBOutlet weak var IVView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        UIViewRoundGradient(to: IVView, startColor: .red, endColor: .blue, lineWidth: 5, startPoint: .topLeft, endPoint: .bottomRight)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
