//
//  ImageScannerVC.swift
//  demoCollectionView
//
//  Created by apple on 11/04/24.
//

import UIKit

class ImageScannerVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    
    public weak var imageScannerDelegate: ImageScannerControllerDelegate?

    // MARK: - Life Cycle

    /// A black UIView, used to quickly display a black screen when the shutter button is presseed.
    internal let blackFlashView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    private func detect(image: UIImage, completion: @escaping (Quadrilateral?) -> Void) {
        // Whether or not we detect a quad, present the edit view controller after attempting to detect a quad.
        // *** Vision *requires* a completion block to detect rectangles, but it's instant.
        // *** When using Vision, we'll present the normal edit view controller first, then present the updated edit view controller later.

        guard let ciImage = CIImage(image: image) else { return }
        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        let orientedImage = ciImage.oriented(forExifOrientation: Int32(orientation.rawValue))

        if #available(iOS 11.0, *) {
            // Use the VisionRectangleDetector on iOS 11 to attempt to find a rectangle from the initial image.
            VisionRectangleDetector.rectangle(forImage: ciImage, orientation: orientation) { quad in
                let detectedQuad = quad?.toCartesian(withHeight: orientedImage.extent.height)
                completion(detectedQuad)
            }
        } else {
            // Use the CIRectangleDetector on iOS 10 to attempt to find a rectangle from the initial image.
            let detectedQuad = CIRectangleDetector.rectangle(forImage: ciImage)?.toCartesian(withHeight: orientedImage.extent.height)
            completion(detectedQuad)
        }
    }

    public func useImage(image: UIImage) {
//        guard topViewController is ScannerViewController else { return }
//
//        detect(image: image) { [weak self] detectedQuad in
//            guard let self else { return }
//            let editViewController = EditScanViewController(image: image, quad: detectedQuad, rotateImage: false)
//            self.setViewControllers([editViewController], animated: true)
//        }
    }

    public func resetScanner() {
//        setViewControllers([ScannerViewController()], animated: true)
    }

    private func setupConstraints() {
        let blackFlashViewConstraints = [
            blackFlashView.topAnchor.constraint(equalTo: view.topAnchor),
            blackFlashView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: blackFlashView.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: blackFlashView.trailingAnchor)
        ]

        NSLayoutConstraint.activate(blackFlashViewConstraints)
    }

    internal func flashToBlack() {
        view.bringSubviewToFront(blackFlashView)
        blackFlashView.isHidden = false
        let flashDuration = DispatchTime.now() + 0.05
        DispatchQueue.main.asyncAfter(deadline: flashDuration) {
            self.blackFlashView.isHidden = true
        }
    }
    
    
    @IBAction func scannerVC(_ sender: UIButton) {
        let scannerVC = ScannerViewController()
//        scannerVC.modalPresentationStyle = .fullScreen
//        self.present(scannerVC, animated: true)
        
        navigationController?.pushViewController(scannerVC, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(arrImgs.count)
        if arrImgs.count >= 1{
            collectionView.reloadData()
        }
    }
    
    

}


extension ImageScannerVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImgs.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.imageView.image = arrImgs[indexPath.row]
        cell.imageView.contentMode = .scaleToFill
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 200)
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cropVC = storyboard?.instantiateViewController(withIdentifier: CropVC.storyboardIdentifier) as! CropVC
        
        cropVC.currentImage = arrImgs[indexPath.row]
        cropVC.index = indexPath.row
        
        navigationController?.pushViewController(cropVC, animated: true)
    }
}



