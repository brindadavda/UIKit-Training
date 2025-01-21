//
//  ViewController.swift
//  demoBarCodeGenerator
//
//  Created by apple on 06/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var TextFiled: UITextField!
    
    @IBOutlet weak var BarIV: UIImageView!
    
    @IBOutlet weak var QrIV: UIImageView!
    
    @IBAction func ActionBarcodeGenerator(_ sender: UIButton) {
        
      
            if let myString = TextFiled.text{
                //converting string input formate to ascii
                let asciiData = myString.data(using: .ascii, allowLossyConversion: false)
                
                //instance of CIfilter
                let barcode =  CIFilter(name: "CICode128BarcodeGenerator")
                
                //set the input value converted in ascii in barcode
                barcode?.setValue(asciiData, forKey: "inputMessage")
                
                //get the image in UIImage formate
                let img : UIImage = UIImage(ciImage: (barcode?.outputImage)!)
                
                //set the generated UIImage put to barcode ui image
                BarIV.image = img
                
                       }
    
    }
    
    @IBAction func ActionQrcodeGenerator(_ sender: UIButton) {
        if let myString = TextFiled.text{
            //converting string input formate to ascii
            let asciiData = myString.data(using: .ascii, allowLossyConversion: false)
            
            //instance of CIfilter
            let barcode = CIFilter(name: "CIQRCodeGenerator")
            
            //set the input value converted in ascii in barcode
            barcode?.setValue(asciiData, forKey: "inputMessage")
            
            //get the image in UIImage formate
            let img : UIImage = UIImage(ciImage: (barcode?.outputImage)!)
            
            //set the generated UIImage put to barcode ui image
            QrIV.image = img
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

