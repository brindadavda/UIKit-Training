//
//  CropVC.swift
//  demoCropImage
//
//  Created by apple on 03/05/24.
//

import UIKit
import Photos

class CropVC: UIViewController {
    
    static let storyboardIdentifier = "CropVC"
    
    @IBOutlet weak var originalImageview: UIImageView!
    
    
    public var image: UIImage = UIImage(named: "img")!
    
    internal var isAutoSaveToLibray: Bool = false
  
    
    /*
     The optional photo tweaks controller delegate.
     */
    public weak var delegate: IGRPhotoTweakViewCustomizationDelegate?
    
    
    public lazy var photoView: IGRPhotoTweakView! = { [unowned self] by in
        let photoView = IGRPhotoTweakView(frame: self.view.bounds,
                                          image: self.image,
                                          customizationDelegate: self)
        photoView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(photoView)
        
        return photoView
        }(())
    
    @IBOutlet weak var cv: UICollectionView!{
        didSet{
            cv.delegate = self
            cv.dataSource = self
        }
    }
    
    var arrImgs = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

//MARK: - Customization
extension CropVC {
    public func customBorderColor() -> UIColor {
        return UIColor.cropLine()
    }
    
    public func customBorderWidth() -> CGFloat {
        return 1.0
    }
    
    public func customCornerBorderWidth() -> CGFloat {
        return kCropViewCornerWidth
    }
    
    public func customCornerBorderLength() -> CGFloat {
        return kCropViewCornerLength
    }
    
    public func customCropLinesCount() -> Int {
        return kCropLinesCount
    }
    
    public func customGridLinesCount() -> Int {
        return kGridLinesCount
    }
    
    public func customIsHighlightMask() -> Bool {
        return true
    }
    
    public func customHighlightMaskAlphaValue() -> CGFloat {
        return 0.3
    }
    
    public func customCanvasInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: kCanvasHeaderHeigth, left: 0, bottom: 0, right: 0)
    }
}


extension CropVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CropVCCVCell.cellReuasableIdentifier, for: indexPath) as! CropVCCVCell
        
//        cell.imageViewForScan.image = arrImgs[indexPath.row].getImg()

       
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    
    
    
    
}



extension CropVC : IGRPhotoTweakViewCustomizationDelegate {
    public func borderColor() -> UIColor {
        return self.customBorderColor()
    }
    
    public func borderWidth() -> CGFloat {
        return self.customBorderWidth()
    }
    
    public func cornerBorderWidth() -> CGFloat {
        return self.customCornerBorderWidth()
    }
    
    public func cornerBorderLength() -> CGFloat {
        return self.customCornerBorderLength()
    }
    
    public func cropLinesCount() -> Int {
        return self.customCropLinesCount()
    }
    
    public func gridLinesCount() -> Int {
        return self.customGridLinesCount()
    }
    
    public func isHighlightMask() -> Bool {
        return self.customIsHighlightMask()
    }
    
    public func highlightMaskAlphaValue() -> CGFloat {
        return self.customHighlightMaskAlphaValue()
    }
    
    public func canvasInsets() -> UIEdgeInsets {
        return self.customCanvasInsets()
    }
}

//MARK:- Helper
extension CropVC {
    public func cropAction() {
        var transform = CGAffineTransform.identity
        // translate
        let translation: CGPoint = self.photoView.photoTranslation
        transform = transform.translatedBy(x: translation.x, y: translation.y)
        // rotate
        transform = transform.rotated(by: self.photoView.radians)
        // scale
        
        let t: CGAffineTransform = self.photoView.photoContentView.transform
        let xScale: CGFloat = sqrt(t.a * t.a + t.c * t.c)
        let yScale: CGFloat = sqrt(t.b * t.b + t.d * t.d)
        transform = transform.scaledBy(x: xScale, y: yScale)
        
        if let fixedImage = self.image.cgImageWithFixedOrientation() {
            if let imageRef = fixedImage.transformedImage(transform,
                                                       zoomScale: self.photoView.scrollView.zoomScale,
                                                       sourceSize: self.image.size,
                                                       cropSize: self.photoView.cropView.frame.size,
                                                          imageViewSize: self.photoView.photoContentView.bounds.size){
                let image = UIImage(cgImage: imageRef)
                
                if self.isAutoSaveToLibray {
                    
                    self.saveToLibrary(image: image)
                }
                
                self.photoTweaksController(didFinishWithCroppedImage: image)
            }
            
           
        }
    }
    
    internal func saveToLibrary(image: UIImage) {
        let writePhotoToLibraryBlock: (() -> Void)? = {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(image:didFinishSavingWithError:contextInfo:)), nil)
        }
        
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            writePhotoToLibraryBlock!()
        }
        else {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) in
                if status == PHAuthorizationStatus.authorized {
                    DispatchQueue.main.async{
                        writePhotoToLibraryBlock!()
                    }
                }
                else {
                    DispatchQueue.main.async{
                        let ac = UIAlertController(title: "Authorization error",
                                                   message: "App don't granted to access to Photo Library",
                                                   preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        ac.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (action) in
                            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                return
                            }
                            
                            if UIApplication.shared.canOpenURL(settingsUrl) {
                                if #available(iOS 10.0, *) {
                                    UIApplication.shared.open(settingsUrl)
                                } else {
                                    UIApplication.shared.openURL(settingsUrl)
                                }
                            }
                        }))
                        self.present(ac, animated: true, completion: nil)
                    }
                }
            })
        }
    }
    
    @objc func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        if error != nil {
            let ac = UIAlertController(title: "Save error",
                                       message: error?.localizedDescription,
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
}


extension CropVC {
    
    func photoTweaksController(didFinishWithCroppedImage croppedImage: UIImage) {
        
    }
    
    func photoTweaksControllerDidCancel() {
        
    }
    
    
}
