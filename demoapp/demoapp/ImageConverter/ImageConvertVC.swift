//
//  ImageConvertVC.swift
//  demoapp
//
//  Created by apple on 30/04/24.
//

import UIKit
import Foundation
import SDWebImage

enum Status{
    case Sucess
    case Pending
    case Failer
}

enum ConvertCategory{
    case jpg
    case gif
    case psd
    case bmp
    case eps
    case svg
    case exr
    case ico
    case tiff
    case tga
    case wbmp
    case webp
    case odd
    case ps
    case pdf
    case png
    
    var status: Status {
            switch self {
            case .jpg , .gif, .psd, .bmp, .svg ,.tiff, .pdf, .png:
                return .Sucess
            case .ico , .webp ,  .tga,  .ps:
                return .Pending
            case .wbmp, .odd , .exr , .eps:
                return .Failer
            }
        }
}

class ImageConvertVC: UIViewController {
    
    @IBOutlet weak var inputImage: UIImageView!
    
    static let storyboardIdentifier = "ImageConvertVC"
    
    private var inputimg : UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        inputimg = inputImage.image
        
        
    }
    
    
    //MARK:- All the converts event
    @IBAction func jpgConvert(_ sender: UIButton) {
     // Example usage
       
        if let pngImage = inputImage.image {
            let outputPath = "example.jpg" // Only the file name, the directory will be documents directory
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let outputURL = documentsDirectory.appendingPathComponent(outputPath)
                print(outputURL)
                convertPNGtoJPEG(pngImage: pngImage, outputFilePath: outputURL.path, compressionQuality: 0.8)
            } else {
                print("Failed to get Documents directory")
            }
        }
    }
    
    @IBAction func gifConvert(_ sender: UIButton) {
        
        // Example usage
        if let pngImage = inputImage.image  {
            let outputPath = "example.gif" // Only the file name, the directory will be documents directory
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let outputURL = documentsDirectory.appendingPathComponent(outputPath)
                convertPNGtoGIF(pngImage: pngImage, outputFilePath: outputURL.path)
                print(outputURL)
            } else {
                print("Failed to get Documents directory")
            }
        }
    }
    
    @IBAction func psdConvert(_ sender: UIButton) {
        // Usage example ( Process )
        let outputPath = "example.psd"
        guard let pngImage = inputImage.image else { return }
        convertPngToPsd(pngImage: pngImage, outputFilePath: outputPath)
        //print(outputPath)
    }
    
    @IBAction func bmpConvert(_ sender: UIButton) {
        // Usage example ( Failed )
        if let pngImage = inputImage.image {
//            let outputPath = "example.bmp"
//            convertPngToBmp(pngImage: pngImage, outputFilePath: outputPath)
            
            if let inputImage = inputImage.image {
            createImageDestination(inputImage: inputImage)
               
        } else {
            print("Failed to load input image")
        }
        }
    }
    
    @IBAction func epsConvert(_ sender: UIButton) {
        // Usage example ( Failed )
        if let pngImage = inputImage.image {
            let outputPath = "example.eps" // Only the file name, the directory will be documents directory
            convertPngToEps(pngImage: pngImage, outputFilePath: outputPath)
            print(outputPath)
        }

    }
    
    
    
    
    
    
    @IBAction func svgConvert(_ sender: UIButton) {
        // Usage example ( Done )
        if inputimg == inputImage.image{
            if let pngImage = inputImage.image{
                convertPngToSvgUsingLibrary(originalImage: pngImage, imageView: inputImage)
            }
        }else{
            inputImage.image = inputimg
        }
        
       
        
        
    }
    
    @IBAction func exrConvert(_ sender: UIButton) {
        // Usage example ( Failed )
    
        if let pngImage = inputImage.image{
            let outputPath = "example.exr" // Only the file name, the directory will be documents directory
                do {
                    try convertPngToExr(pngImage: pngImage, outputFilePath: outputPath)
                } catch {
                    print("Error converting PNG to EXR: \(error)")
                }
        }
    }

    @IBAction func icoConvert(_ sender: UIButton) {
        // Usage example ( Panding )
//        if let pngImage = inputImage.image {
//            let outputPath = "example.ico" // Only the file name, the directory will be documents directory
//            do {
//                try convertPngToIco(pngImage: pngImage, outputFilePath: outputPath)
//            } catch {
//                print("Error converting PNG to ICO: \(error)")
//            }
//        }
        
        if let inputImage = inputImage.image {
        createImageDestination(inputImage: inputImage)
    } else {
        print("Failed to load input image")
    }

    }
    
    @IBAction func tiffConvert(_ sender: UIButton) {
        // Example usage
        // Example usage (Done)
        if let pngPath = Bundle.main.path(forResource: "pngImg2", ofType: "png") {
            let pngURL = URL(fileURLWithPath: pngPath)
            
            let documentsDirectoryURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let tiffURL = documentsDirectoryURL.appendingPathComponent("image.tiff")

            if convertPNGtoTIFF(pngURL: pngURL, tiffURL: tiffURL) {
                print("Successfully converted PNG to TIFF. TIFF file saved at:", tiffURL)
            } else {
                print("Failed to convert PNG to TIFF")
            }
        } else {
            print("PNG image file not found")
        }
        
    }
    
    @IBAction func tgaConvert(_ sender: UIButton) {
        // Example usage (Partial Done Testing remaining )
        if let pngPath = Bundle.main.path(forResource: "pngImg2", ofType: "png"){
            let pngURL = URL(fileURLWithPath: pngPath)
            convertPNGtoTGA(pngURL: pngURL) { success, error in
                if success {
                    print("Successfully converted PNG to TGA")
                } else {
                    print("Failed to convert PNG to TGA: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
        
    }
    
    @IBAction func wbmpConvert(_ sender: UIButton) {
        // Example usage ( Failed )
        if let pngPath = Bundle.main.path(forResource: "pngImg", ofType: "png"){
            let pngURL = URL(fileURLWithPath: pngPath)
            let wbmpURL = URL(fileURLWithPath: "image.wbmp")

            convertPNGtoWBMP(pngURL: pngURL, wbmpFileName: "image.wbmp")
        }
        
    }
    
    @IBAction func webpConvert(_ sender: UIButton) {
        // Example usage ( Partialy done )
        if let image_download = inputImage.image {
           let photo:Data = image_download.sd_imageData(as: SDImageFormat.webP)!
            let outputFilePath = "example.webP"
            do {
                // Get the documents directory URL
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let outputURL = documentsDirectory.appendingPathComponent(outputFilePath)

                // Ensure the directory exists
                let outputDirectory = outputURL.deletingLastPathComponent()
                try FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: true, attributes: nil)

                try photo.write(to: outputURL)
                print("Successfully wrote webP file to \(outputURL.path)")
            } catch {
                print("Failed to write webP file: \(error)")
            }
           
        }
    
      
       
    }
    
    @IBAction func oddConvert(_ sender: UIButton) {
        // Usage example ( Failed )
        if let pngFilePath = Bundle.main.path(forResource: "pngImg", ofType: "png") {
            let outputFilePath = "example.odd" // Only the file name, the directory will be documents directory
            convertPNGtoODD(pngURL: URL(fileURLWithPath: pngFilePath), oddFileName: "example")
            
    
//            do {
////               Attempt the PNG to SVG conversion
//
//                try inputImage.image?.convertToOdd(outputFilePath:outputFilePath)
//              print("Successfully converted PNG to ODD!")
//            } catch {
//              // Handle potential errors during conversion
//              print("Error converting PNG to ODD: \(error)")
//            }
        }
    }
    
    @IBAction func psConvert(_ sender: UIButton) {
        // Example usage (Partial Done Testing remaining )
        if let pngImage = inputImage.image {
            let outputPath = "example.ps" // Only the file name, the directory will be the documents directory
            convertPNGtoPS(pngImage: pngImage, outputFileName: outputPath)
        }

    }
    
    @IBAction func pdfConvert(_ sender: UIButton) {
        // Example usage
        if let pngImage = inputImage.image  {
            let outputPath = "example.pdf" // Only the file name, the directory will be documents directory
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let outputURL = documentsDirectory.appendingPathComponent(outputPath)
                convertPNGtoPDF(pngImage: pngImage, outputFilePath: outputURL.path)
            } else {
                print("Failed to get Documents directory")
            }
        }
    }
    
    @IBAction func pngConvert(_ sender: UIButton) {
    }
}
