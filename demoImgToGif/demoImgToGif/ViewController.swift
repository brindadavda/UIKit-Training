//
//  ViewController.swift
//  demoImgToGif
//
//  Created by apple on 16/04/24.
//

import UIKit
import UniformTypeIdentifiers
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        images.append(imageView.image!)
        images.append(UIImage(systemName: "trash")!)
        
        imageToGif()
        
        
    }

    func loadGif(url : String){
        let gifURL : String = url
           let imageURL = UIImage.gifImageWithURL(gifURL)
           let imageView3 = UIImageView(image: imageURL)
           imageView3.frame = CGRect(x: 20.0, y: 390.0, width: self.view.frame.size.width - 40, height: 150.0)
           view.addSubview(imageView3)
    }
    

    func imageToGif(){
        if let gifimgurl = UIImage.animatedGif(from: images){
            loadGif(url: gifimgurl)
        }
    }
    
    


}

