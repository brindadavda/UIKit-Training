//
//  DisplayImagePicker.swift
//  demoCoreData
//
//  Created by apple on 13/02/24.
//

import PhotosUI

class DisplayImagePicker: PHPickerViewControllerDelegate{
    
    static let shared = DisplayImagePicker()
    private var img = UIImageView()
    private var target = UIViewController()
    
    func displayImagePicker(img : UIImageView , target : UIViewController){
        var configuration = PHPickerConfiguration()
       configuration.selectionLimit = 1
        
        self.img = img
        self.target = target
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        picker.isEditing = true

        target.present(picker, animated: true)
    }
    
    internal func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
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
                        self.img.image = image
                        
                    }
                }
            }
            
            target.dismiss(animated: true)
        }
    }

    
}

