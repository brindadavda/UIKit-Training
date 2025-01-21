//
//  CropVC.swift
//  demoCollectionView
//
//  Created by apple on 12/04/24.
//

import UIKit
import AVFoundation

class CropVC: UIViewController {
    
    static let storyboardIdentifier = "CropVC"
    
    
    @IBOutlet weak var cropedImagePreview: UIImageView!
    

    @IBOutlet weak var displayPageNoLabel: UILabel!
    
    
    @IBOutlet weak var originalImageview: UIImageView!
    
    var index = -1
    
    var cropedImage : UIImage = UIImage()
    
    
    var currentImage : UIImage!
    private var quad: Quadrilateral!
    
    public weak var delegate: CropImageViewDelegate?
    
    private var zoomGestureController: ZoomGestureController!
    
    private var quadViewWidthConstraint = NSLayoutConstraint()
    private var quadViewHeightConstraint = NSLayoutConstraint()
    
    

    private lazy var quadView: QuadrilateralView = {
        let quadView = QuadrilateralView()
        quadView.editable = true
//        quadView.strokeColor = UIColor.white.cgColor
//        quadView.backgroundColor = .lightGray
//        quadView.alpha = 0.3
        quadView.translatesAutoresizingMaskIntoConstraints = false
        return quadView
    }()
    

    public func cropImage() {
        guard let image = currentImage else { return }
        guard let quad = quadView.quad, let ciImage = CIImage(image: image) else {
            return
        }

        let cgOrientation = CGImagePropertyOrientation(image.imageOrientation)
        let orientedImage = ciImage.oriented(forExifOrientation: Int32(cgOrientation.rawValue))
        let scaledQuad = quad.scale(quadView.bounds.size, image.size)
        self.quad = scaledQuad

        // Cropped Image
        var cartesianScaledQuad = scaledQuad.toCartesian(withHeight: image.size.height)
        cartesianScaledQuad.reorganize()

        let filteredImage = orientedImage.applyingFilter("CIPerspectiveCorrection", parameters: [
            "inputTopLeft": CIVector(cgPoint: cartesianScaledQuad.bottomLeft),
            "inputTopRight": CIVector(cgPoint: cartesianScaledQuad.bottomRight),
            "inputBottomLeft": CIVector(cgPoint: cartesianScaledQuad.topLeft),
            "inputBottomRight": CIVector(cgPoint: cartesianScaledQuad.topRight)
        ])

        let croppedImage = UIImage.from(ciImage: filteredImage)
        delegate?.cropped(image: croppedImage)
    }
    
    private func setupViews() {
        view.addSubview(quadView)
    }
    
    
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    

    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        adjustQuadViewConstraints()
        displayQuad()
    }
    
    private func adjustQuadViewConstraints() {
        let frame = AVMakeRect(aspectRatio: currentImage.size, insideRect: originalImageview.bounds)
//        let frame = originalImageview.frame
        quadViewWidthConstraint.constant = frame.size.width
        quadViewHeightConstraint.constant = frame.size.height
    }
    
    private func displayQuad() {
        let imageSize = currentImage.size
        let size = CGSize(width: quadViewWidthConstraint.constant, height: quadViewHeightConstraint.constant)
        let imageFrame = CGRect(origin: quadView.frame.origin, size: size)

        let scaleTransform = CGAffineTransform.scaleTransform(forSize: imageSize, aspectFillInSize: imageFrame.size)
        let transforms = [scaleTransform]
        
        
        if quad != nil {
            let transformedQuad = quad.applyTransforms(transforms)
            quadView.drawQuadrilateral(quad: transformedQuad, animated: false)
        }
        
    }

    
    
    private func setupConstraints() {
        quadViewWidthConstraint = quadView.widthAnchor.constraint(equalToConstant: 0.0)
        quadViewHeightConstraint = quadView.heightAnchor.constraint(equalToConstant: 0.0)

        let quadViewConstraints = [
            quadView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quadView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            quadViewWidthConstraint,
            quadViewHeightConstraint
        ]

        NSLayoutConstraint.activate(quadViewConstraints)
    }

    private func addLongGesture(of controller: ZoomGestureController) {
        let touchDown = UILongPressGestureRecognizer(target: controller,
                                                     action: #selector(controller.handle(pan:)))
        touchDown.minimumPressDuration = 0
        
        let zoomSubView = UIView(frame: CGRect(x: 50, y: 100, width: view.bounds.width - 50, height: view.bounds.height - 50))
        zoomSubView.backgroundColor = .clear
        
        view.addSubview(zoomSubView)
        
        zoomSubView.addGestureRecognizer(touchDown)
    }
    
    
    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        cropImage()
        
        cropedImagePreview.image = cropedImage
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        originalImageview.image = currentImage
        displayPageNoLabel.text = "Page \(index+1)"
        
        delegate = self
        
        setupViews()
        setupConstraints()
        zoomGestureController = ZoomGestureController(image: currentImage, quadView: quadView)
        addLongGesture(of: zoomGestureController)
        
        quad = ScannerViewController.defaultQuad(forImage: originalImageview.image!)
    }
    
    
    deinit{
        print("CropVC Relaesed from memory.")
    }
    
    
}


extension CropVC : CropImageViewDelegate{
    func cropped(image: UIImage) {
        cropedImage = image
    }
}


protocol CropImageViewDelegate : AnyObject {
    func cropped(image: UIImage)
}
