//
//  ViewController.swift
//  EditingApp
//
//  Created by apple on 28/06/24.
//

import UIKit
import PixelSDK

class ViewController: UIViewController, EditControllerDelegate {
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func editingAction(_ sender : UIButton){
        PixelSDK.shared.primaryFilters = PixelSDK.defaultStandardFilters
              
              let container = ContainerController()
              container.editControllerDelegate = self
              
              let nav = UINavigationController(rootViewController: container)
              nav.modalPresentationStyle = .fullScreen
              self.present(nav, animated: true, completion: nil)
    }
    
    func editController(_ editController: EditController, didLoadEditing session: Session) {
            // Called after the EditController's view did load.
        }
        
        func editController(_ editController: EditController, didFinishEditing session: Session) {
            // Called when the Next button in the EditController is pressed.
            // Use this time to either dismiss the UINavigationController, or push a new controller on.
            
//            let controller = PostController()
//            controller.session = session
//            
//            editController.navigationController?.pushViewController(controller, animated: true)
        }
        
        func editController(_ editController: EditController, didCancelEditing session: Session?) {
            // Called when the back button in the EditController is pressed.
        }
}

