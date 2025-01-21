//
//  PreviewTodoDataVC.swift
//  demoAutoLayout
//
//  Created by apple on 23/01/24.
//

import UIKit

class PreviewTodoDataVC: UIViewController {

    @IBOutlet weak var todoIV: UIImageView!

    @IBOutlet weak var todoTitleLabel: UILabel!
    
    @IBOutlet weak var todoDesctiprionLabel: UILabel!
    
    //get the value for that you need to store somewhere
    var img = UIImage()
    var todoTitle: String = ""
    var todoDescription: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        todoIV.image = img
        todoTitleLabel.text = todoTitle
        todoDesctiprionLabel.text = todoDescription
        
        //enabling pintch gesture on image for zoom in
        enableZoom(todoIV)
        //zoom out while double tap by person
        doubleTap(todoIV)
        
    }
    
    //using pintch enable zoom in and out of the given imageView
    func enableZoom(_ selector : UIImageView) {
      let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
    
        selector.isUserInteractionEnabled = true
        selector.addGestureRecognizer(pinchGesture)
    }

    @objc
    private func startZooming(_ sender: UIPinchGestureRecognizer) {
      let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
      guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
      sender.view?.transform = scale
      sender.scale = 1
    }
    
    
    func doubleTap(_ selector : UIImageView){
        let TapGesture = UITapGestureRecognizer(target: self, action: #selector(stopZooming(_ : )))
        
        TapGesture.numberOfTapsRequired = 2
        selector.isUserInteractionEnabled = true
        selector.addGestureRecognizer(TapGesture)
    }
    
    @objc
    private func stopZooming(_ sender: UITapGestureRecognizer) {
        sender.view?.transform = CGAffineTransform(scaleX: 1, y: 1)
    }
    
}


