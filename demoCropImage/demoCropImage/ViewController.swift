//
//  ViewController.swift
//  demoCropImage
//
//  Created by apple on 20/03/24.
//

import UIKit

class ViewController: UIViewController {
    
    var SelectedImg : UIImage? = nil
    var imageCropView: ImageCropView?
    var flipImg : UIImage!
    
    
    @IBOutlet weak var viewCorop: ImageCropView!
    
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    func initialiseCropView() {
        guard let image = img.image else {return}
      
        deInitialiseCropView()
        imageCropView = ImageCropView(frame: CGRect(x: 0, y: 0, width:
        self.viewCorop.frame.size.width,height: self.viewCorop.frame.size.height))
        imageCropView?.cropLineColor = .black
        viewCorop.addSubview(imageCropView!)
        flipImg = image
        //        print(flipImg)
        imageCropView?.image = image
        
        imageCropView?.backgroundColor = .cyan
    }
    
    func deInitialiseCropView() {
        imageCropView?.removeFromSuperview()
        imageCropView = nil
    }

    
    func cropImage(sourceImage: inout UIImage){
        initialiseCropView()
    }
    
    
    @IBAction func cropImage(_ sender: UIButton) {
        cropImage(sourceImage: &(img.image)!)
    }
    
    
    @IBAction func saveImg(_ sender: Any) {
    }
    

}

