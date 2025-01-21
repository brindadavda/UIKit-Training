//
//  ViewController.swift
//  demoTabBar
//
//  Created by apple on 08/01/24.
//

import UIKit
import PhotosUI

class ViewController: UIViewController  , UINavigationControllerDelegate , UIImagePickerControllerDelegate, PHPickerViewControllerDelegate {
    

    @IBOutlet weak var imageView: UIImageView!
    
  
    @IBAction func ActionSelectImage(_ sender: UIButton) {
       
        displayImagePicker()
    }

    
    
        func displayImagePicker() {
            var configuration = PHPickerConfiguration()
           configuration.selectionLimit = 1
    
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            picker.isEditing = true
    
           present(picker, animated: true, completion: nil)
        }

       // Delegate method for PHPickerViewController
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            //dismiss(animated: true, completion: nil)
            
            

            guard let itemProvider = results.first?.itemProvider else {
                return
           }

           if itemProvider.canLoadObject(ofClass: UIImage.self) {
               itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                   if let error = error {
                      print("Error loading image: \(error.localizedDescription)")
                   } else if let image = image as? UIImage {
                       // Use the selected image
                       DispatchQueue.main.async {
                           // Update UI with the selected image
                           self.imageView.image = image
                           
                       }
                   }
            }
               
               self.dismiss(animated: true)
            }
       }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = imageView.bounds.height/2
    
    }
    
}

