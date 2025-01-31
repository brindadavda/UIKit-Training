//
//  Crop.swift
//  demoCropImage
//
//  Created by apple on 20/03/24.
//

import Foundation
import UIKit

@IBDesignable
class ImageCropView: UIView {
    
    var defaultWidth : CGFloat = 250
    var defaultHeight : CGFloat = 400
    var buttonSize = CGSize(width: 50, height: 50)
    var middleButtonSize = CGSize(width: 50, height: 50)
    var centerButtonSize = CGSize(width: 100, height: 100)
    // MARK: Public Property
    // Set Image
    @IBInspectable
    public var image: UIImage? {
        get {
            return self.imageView.image
        }
        set {
            self.imageView.image = newValue
            self.scrollView.setZoomScale(1, animated: false)
            if self.scrollView.delegate == nil {
                self.initVariables()
            }
            self.cropLineHidden(newValue)
            self.scrollView.layoutIfNeeded()
            self.dimLayerMask(animated: false)
            DispatchQueue.main.async { [weak self] in
                self?.imageMinAdjustment(animated: false)
            }
        }
    }
    
    // Background color of scroll
    @IBInspectable
    public var scrollViewBackgroundColor: UIColor? {
        get {
            return self.scrollView.backgroundColor
        }
        set {
            self.scrollView.backgroundColor = newValue
        }
    }
    
    // Background color of image
    @IBInspectable
    public var imageViewBackgroundColor: UIColor? {
        get {
            return self.imageView.backgroundColor
        }
        set {
            self.imageView.backgroundColor = newValue
        }
    }
    // Minimum zoom for scrolling
    @IBInspectable
    public var scrollViewMinimumZoomScale: CGFloat {
       get {
           return self.scrollView.minimumZoomScale
       }
       set {
           self.scrollView.minimumZoomScale = newValue
       }
    }
       
    // Maximum zoom for scrolling
    @IBInspectable
    public var scrollViewMaximumZoomScale: CGFloat {
       get {
           return self.scrollView.maximumZoomScale
       }
       set {
           self.scrollView.maximumZoomScale = newValue
       }
    }
    
    // MARK: Private Property
     lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        self.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.edgesConstraint(subView: scrollView)
        return scrollView
    }()
    
     lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        self.scrollView.addSubview(imageView)
        imageView.center = self.scrollView.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.edgesConstraint(subView: imageView)
        self.scrollView.sizeConstraint(subView: imageView)
        return imageView
    }()
    
     lazy var dimView: CropDimView = {
        self.scrollView.alpha = 1
        let view = CropDimView()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.edgesConstraint(subView: view)
        return view
    }()
    
    // Color of dim view not in the crop area
    @IBInspectable
    public var dimBackgroundColor: UIColor? {
        get {
            return self.dimView.backgroundColor
        }
        set {
            self.dimView.backgroundColor = newValue
        }
    }
   
    //MARK: CropView Properities
    lazy var cropView: CropView = {
        self.dimView.alpha = 1
        let cropView = CropView()
        self.addSubview(cropView)
        cropView.translatesAutoresizingMaskIntoConstraints = false
        self.cropLeadingConstraint = self.leadingConstraint(subView: cropView, constant: 0).priority(945)
        self.cropTrailingConstraint = self.trailingConstraint(subView: cropView, constant: 0).priority(945)
        self.cropTopConstraint = self.topConstraint(subView: cropView, constant: 0).priority(945)
        self.cropBottomConstraint = self.bottomConstraint(subView: cropView, constant: 0).priority(945)
        self.cropLeadingInitialConstraint = self.leadingConstraint(subView: cropView, constant: 0).priority(945)
        self.cropTrailingInitialConstraint = self.trailingConstraint(subView: cropView, constant: 0).priority(945)
        self.cropTopInitialConstraint = self.topConstraint(subView: cropView, constant: 0).priority(945)
        self.cropBottomInitialConstraint = self.bottomConstraint(subView: cropView, constant: 0).priority(945)
           return cropView
    }()
    
    public var isCrop = true {
        willSet {
            self.leftTopButton.isHidden = !newValue
            self.leftBottomButton.isHidden = !newValue
            self.rightTopButton.isHidden = !newValue
            self.rightBottomButton.isHidden = !newValue
            self.dimView.isHidden = !newValue
            self.cropView.isHidden = !newValue
            self.topButton.isHidden = !newValue
            self.bottomButton.isHidden = !newValue
            self.leftButton.isHidden = !newValue
            self.rightButton.isHidden = !newValue
        }
    }

    // Line color of crop view
    @IBInspectable
    public var cropLineColor: UIColor? {
        get {
            return self.cropView.lineColor
        }
        set {
            self.cropView.lineColor = newValue
            self.leftTopButton.edgeLine(newValue)
            self.leftBottomButton.edgeLine(newValue)
            self.rightTopButton.edgeLine(newValue)
            self.rightBottomButton.edgeLine(newValue)
        }
    }
    
    var cropLeadingConstraint: NSLayoutConstraint?
    var cropTrailingConstraint: NSLayoutConstraint?
    var cropTopConstraint: NSLayoutConstraint?
    var cropBottomConstraint: NSLayoutConstraint?
    var lineButtonTouchPoint: CGPoint?
    var cropLeadingInitialConstraint: NSLayoutConstraint?
    var cropTrailingInitialConstraint: NSLayoutConstraint?
    var cropTopInitialConstraint: NSLayoutConstraint?
    var cropBottomInitialConstraint: NSLayoutConstraint?
    
    // Side button and corner button of crop
    lazy var leftTopButton: LineButton = {
        let button = LineButton(.leftTop, buttonSize: buttonSize)
        let cropView = self.cropView
        self.addSubview(button)
        self.topConstraint(item: cropView, subView: button, constant: 10)
        self.leadingConstraint(item: cropView, subView: button, constant: 10)
        button.addTarget(self, action: #selector(self.cropButtonLeftTopDrag(_:forEvent:)), for: .touchDragInside)
        return button
    }()
    
    lazy var leftBottomButton: LineButton = {
        let button = LineButton(.leftBottom, buttonSize: buttonSize)
        let cropView = self.cropView
        self.addSubview(button)
        self.bottomConstraint(item: cropView, subView: button, constant: -14)
        self.leadingConstraint(item: cropView, subView: button, constant: 10)
        button.addTarget(self, action: #selector(self.cropButtonLeftBottomDrag(_:forEvent:)), for: .touchDragInside)
        return button
    }()
    
    lazy var rightTopButton: LineButton = {
        let button = LineButton(.rightTop, buttonSize: buttonSize)
        let cropView = self.cropView
        self.addSubview(button)
        self.topConstraint(item: cropView, subView: button, constant: 10)
        self.trailingConstraint(item: cropView, subView: button, constant: -10)
        button.addTarget(self, action: #selector(self.cropButtonRightTopDrag(_:forEvent:)), for: .touchDragInside)
        return button
    }()
    
    lazy var rightBottomButton: LineButton = {
        let button = LineButton(.rightBottom, buttonSize: buttonSize)
        let cropView = self.cropView
        self.addSubview(button)
        self.bottomConstraint(item: cropView, subView: button, constant: -14)
        self.trailingConstraint(item: cropView, subView: button, constant: -10)
        button.addTarget(self, action: #selector(self.cropButtonRightBottomDrag(_:forEvent:)), for: .touchDragInside)
        return button
    }()
    
    lazy var topButton: LineButton = {
        let button = LineButton(.top, buttonSize: middleButtonSize)
        let cropView = self.cropView
        self.addSubview(button)
        self.topConstraint(item: cropView, subView: button, constant: 20)
        self.centerXConstraint(item: cropView, subView: button)
        self.widthConstraint(constant: 50)
        button.addTarget(self, action: #selector(self.cropButtonTopDrag(_:forEvent:)), for: .touchDragInside)
        return button
    }()
    
    lazy var leftButton: LineButton = {
        let button = LineButton(.left, buttonSize: middleButtonSize)
        let cropView = self.cropView
        self.addSubview(button)
        self.centerYConstraint(item: cropView, subView: button)
        self.leadingConstraint(item: cropView, subView: button, constant: 10)
        self.heightConstraint(constant: 50)
        button.addTarget(self, action: #selector(self.cropButtonLeftDrag(_:forEvent:)), for: .touchDragInside)
        return button
    }()
    
    lazy var rightButton: LineButton = {
        let button = LineButton(.right, buttonSize: middleButtonSize)
        let cropView = self.cropView
        self.addSubview(button)
        self.centerYConstraint(item: cropView, subView: button)
        self.trailingConstraint(item: cropView, subView: button, constant: -10)
        self.heightConstraint(constant: 50)
        button.addTarget(self, action: #selector(self.cropButtonRightDrag(_:forEvent:)), for: .touchDragInside)
        return button
    }()
    
    lazy var bottomButton: LineButton = {
        let button = LineButton(.bottom, buttonSize: middleButtonSize)
        let cropView = self.cropView
        self.addSubview(button)
        self.bottomConstraint(item: cropView, subView: button, constant: -10)
        self.centerXConstraint(item: cropView, subView: button)
        self.widthConstraint(constant: 50)
        button.addTarget(self, action: #selector(self.cropButtonBottomDrag(_:forEvent:)), for: .touchDragInside)
        return button
    }()
        
    // MARK: Init
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        if self.scrollView.delegate == nil {
            self.initVariables()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        if self.scrollView.delegate == nil {
            self.initVariables()
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.updateConstraintsIfNeeded()
    }
    
    // MARK: Public Method
    /**
     crop method.
     If there is no image to crop, Error 404 is displayed.
     If there is no image in the crop area, Error 503 is displayed.
     If the image is successfully cropped, the success delegate or callback function is called.
     **/
    public func crop(_ handler: ((Error?, UIImage?) -> Void)? = nil) {
        guard let image = self.imageView.image else {
            let error = NSError(domain: "Image is empty.", code: 404, userInfo: nil)
            handler?(error, nil)
            return
        }
        
        DispatchQueue.main.async {
            let imageSize = self.imageView.frameForImageInImageViewAspectFit
            let widthRate =  self.bounds.width / imageSize.width
            let heightRate = self.bounds.height / imageSize.height
            var factor: CGFloat
            if widthRate < heightRate {
                factor = image.size.width / self.scrollView.frame.width
            } else {
                factor = image.size.height / self.scrollView.frame.height
            }
            let scale = 1 / self.scrollView.zoomScale
            let imageFrame = self.imageView.imageFrame
            let x = (self.scrollView.contentOffset.x + self.cropView.frame.origin.x - imageFrame.origin.x) * scale * factor
            let y = (self.scrollView.contentOffset.y + self.cropView.frame.origin.y - imageFrame.origin.y) * scale * factor
            let width = self.cropView.frame.size.width * scale * factor
            let height = self.cropView.frame.size.height * scale * factor
            let cropArea = CGRect(x: x, y: y, width: width, height: height)
            
            guard let cropCGImage = image.cgImage?.cropping(to: cropArea) else {
                let error = NSError(domain: "There is no image in the Crop area.", code: 503, userInfo: nil)
                handler?(error, nil)
                return
            }
            let cropImage = UIImage(cgImage: cropCGImage)
            handler?(nil, cropImage)
        }
    }
    
}
// MARK: Private Method Init
extension ImageCropView {
    // Side button and corner button group of crops
    var lineButtonGroup: [LineButton] {
        return [self.leftTopButton, self.leftBottomButton, self.rightTopButton, self.rightBottomButton, self.topButton, self.leftButton, self.bottomButton, self.rightButton]
    }

    // Init
    func initVariables() {
        self.scrollView.clipsToBounds = true
        self.scrollView.delegate = self
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
               
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFit
               
        self.cropLineHidden(self.image)
        //CropLineColor will be set below
        self.cropLineColor = self.cropLineColor ?? .white
        self.scrollViewMinimumZoomScale = 1.0
        self.scrollViewMaximumZoomScale = 5.0
        self.scrollViewBackgroundColor = .clear
        self.imageViewBackgroundColor = .clear
        self.dimBackgroundColor = self.dimBackgroundColor ?? UIColor(white: 0, alpha: 0.0)
        self.lineButtonGroup.forEach { (button) in
            button.delegate = self
                button.addTarget(self, action: #selector(self.cropButtonTouchDown(_:forEvent:)), for: .touchDown)
                button.addTarget(self, action: #selector(self.cropButtonTouchUpInside(_:forEvent:)), for: .touchUpInside)
        }
    }
    // Does not display lines when the image is nil.
    func cropLineHidden(_ image: UIImage?) {
        self.cropView.alpha = image == nil ? 0 : 1
        self.leftTopButton.alpha = image == nil ? 0 : 1
        self.leftBottomButton.alpha = image == nil ? 0 : 1
        self.rightBottomButton.alpha = image == nil ? 0 : 1
        self.rightTopButton.alpha = image == nil ? 0 : 1
        self.topButton.alpha = image == nil ? 0 : 1
        self.rightButton.alpha = image == nil ? 0 : 1
        self.bottomButton.alpha = image == nil ? 0 : 1
        self.leftButton.alpha = image == nil ? 0 : 1
     }
}

//MARK: ScrollViewDelegate Methods
extension ImageCropView : UIScrollViewDelegate{
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale <= 1 {
            let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
            let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
            scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
        } else {
            let imageSize = self.imageView.frameForImageInImageViewAspectFit
            if self.isImageRateHeightGreaterThan(imageSize) {
                let imageOffset = -imageSize.origin.y
                let scrollOffset = (scrollView.bounds.height - scrollView.contentSize.height) * 0.5
                if imageOffset > scrollOffset {
                    scrollView.contentInset = UIEdgeInsets(top: imageOffset, left: 0, bottom: imageOffset, right: 0)
                } else {
                    scrollView.contentInset = UIEdgeInsets(top: scrollOffset, left: 0, bottom: scrollOffset, right: 0)
                }
            } else {
                let imageOffset = -imageSize.origin.x
                let scrollOffset = (scrollView.bounds.width - scrollView.contentSize.width) * 0.5
                if imageOffset > scrollOffset {
                    scrollView.contentInset = UIEdgeInsets(top: 0, left: imageOffset, bottom: 0, right: imageOffset)
                } else {
                    scrollView.contentInset = UIEdgeInsets(top: 0, left: scrollOffset, bottom: 0, right: scrollOffset)
                }
            }
        }
    }
    
    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.cropLeadingInitialConstraint?.constant = 0
        self.cropTrailingInitialConstraint?.constant = 0
        self.cropTopInitialConstraint?.constant = 0
        self.cropBottomInitialConstraint?.constant = 0
    }

    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}


// MARK: Private Method Crop
extension ImageCropView {
    func isImageRateHeightGreaterThan(_ imageSize: CGRect) -> Bool {
        let widthRate =  self.bounds.width / imageSize.width
        let heightRate = self.bounds.height / imageSize.height
        return widthRate < heightRate
    }
    // Max Image
    func imageMaxAdjustment(_ duration: TimeInterval = 0.4, animated: Bool) {
         self.imageAdjustment(.zero, duration: duration, animated: animated)
     }
     
     // Min Image
    func imageMinAdjustment(_ duration: TimeInterval = 0.4, animated: Bool) {
         var point: CGPoint
         let imageSize = self.imageView.frameForImageInImageViewAspectFit
         if self.isImageRateHeightGreaterThan(imageSize) {
             point = CGPoint(x: 0, y: imageSize.origin.y)
         } else {
             point = CGPoint(x: imageSize.origin.x, y: 0)
         }
         self.imageAdjustment(point, duration: duration, animated: animated)
     }
    
    func imageAdjustment(_ point: CGPoint, duration: TimeInterval = 0.4, animated: Bool) {
        self.cropLeadingConstraint?.constant = -point.x
        self.cropTrailingConstraint?.constant = point.x
        self.cropTopConstraint?.constant = -point.y
        self.cropBottomConstraint?.constant = point.y
        self.cropLeadingInitialConstraint?.constant = -point.x
        self.cropTrailingInitialConstraint?.constant = point.x
        self.cropTopInitialConstraint?.constant = -point.y
        self.cropBottomInitialConstraint?.constant = point.y
        if animated {
            UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.layoutIfNeeded()
                self.scrollView.layoutIfNeeded()
                self.scrollView.updateConstraintsIfNeeded()
                self.updateConstraintsIfNeeded()
            }, completion: nil)
        }
    }
}

// MARK: Private Method Dim
extension ImageCropView {
    // Modify the dim screen mask.
    func dimLayerMask(_ duration: TimeInterval = 0.4, animated: Bool) {
        guard let cropLeadingConstraint = self.cropLeadingConstraint,
            let cropTrailingConstraint = self.cropTrailingConstraint,
            let cropTopConstraint = self.cropTopConstraint,
            let cropBottomConstraint = self.cropBottomConstraint else { return }
        let width = self.scrollView.bounds.width - (-cropLeadingConstraint.constant + cropTrailingConstraint.constant)
        let height = self.scrollView.bounds.height - (-cropTopConstraint.constant + cropBottomConstraint.constant)
      

        for constraint in self.leftButton.constraints where constraint.firstAttribute == .height {
            constraint.constant = height - 100.0
        }
        for constraint in self.rightButton.constraints where constraint.firstAttribute == .height {
            constraint.constant = height - 100.0
        }
        for constraint in self.topButton.constraints where constraint.firstAttribute == .width {
            constraint.constant = width - 100.0
        }
        for constraint in self.bottomButton.constraints where constraint.firstAttribute == .width {
            constraint.constant = width - 100.0
        }
        self.dimView.layoutIfNeeded()
        
        let path = UIBezierPath(rect: CGRect(
            x: -cropLeadingConstraint.constant,
            y: -cropTopConstraint.constant,
            width: width,
            height: height
        ))
        path.append(UIBezierPath(rect: self.dimView.bounds))
        
        self.dimView.mask(path.cgPath, duration: duration, animated: animated)
    }
}

//MARK:  Crop LineView
class CropView: UIView {
    private let margin: CGFloat = 0
    private let lineSize: CGFloat = 3
    
    var lineColor: UIColor? = UIColor.white.withAlphaComponent(0.8) {
        willSet {
            self.topLineView.backgroundColor = newValue
            self.bottomLineView.backgroundColor = newValue
            self.leftLineView.backgroundColor = newValue
            self.rightLineView.backgroundColor = newValue
            self.horizontalRightLineView.backgroundColor = newValue
            self.horizontalLeftLineView.backgroundColor = newValue
            self.verticalTopLineView.backgroundColor = newValue
            self.verticalBottomLineView.backgroundColor = newValue
        }
    }
    
    lazy var topLineView: UIView = {
        let view = UIView()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: self.margin).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: self.margin).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: self.margin).priority(950))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.lineSize).priority(950))
        return view
    }()
    
    lazy var leftLineView: UIView = {
        let view = UIView()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: self.margin).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: self.margin).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: self.margin).priority(950))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: self.lineSize).priority(950))
        return view
    }()
    
    lazy var bottomLineView: UIView = {
        let view = UIView()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: self.margin).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: self.margin).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: self.margin).priority(950))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.lineSize).priority(950))
        return view
    }()
    
    lazy var rightLineView: UIView = {
        let view = UIView()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: self.margin).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: self.margin).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: self.margin).priority(950))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: self.lineSize).priority(950))
        return view
    }()
    
    lazy var horizontalLeftLineView: UIView = {
        let view = UIView()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self.horizontalLeftView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self.bottomLineView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self.topLineView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).priority(950))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: self.lineSize).priority(950))
        return view
    }()
    
    lazy var horizontalRightLineView: UIView = {
        let view = UIView()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self.bottomLineView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self.topLineView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).priority(950))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: self.lineSize).priority(950))
        return view
    }()
    
    lazy var verticalTopLineView: UIView = {
        let view = UIView()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self.verticalTopView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self.leftLineView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self.rightLineView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).priority(950))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.lineSize).priority(950))
        return view
    }()
    
    lazy var verticalBottomLineView: UIView = {
        let view = UIView()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self.leftLineView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self.rightLineView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).priority(950))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.lineSize).priority(950))
        return view
    }()
    
    lazy var horizontalLeftView: UIView = {
        let view = UIView()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self.leftLineView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self.bottomLineView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self.topLineView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).priority(950))
        return view
    }()
    
    lazy var horizontalRightView: UIView = {
        let view = UIView()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self.horizontalRightLineView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self.bottomLineView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self.topLineView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self.rightLineView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self.horizontalLeftView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0).priority(950))
        return view
    }()
    
    lazy var verticalTopView: UIView = {
        let view = UIView()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self.topLineView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self.leftLineView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self.rightLineView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).priority(950))
        return view
    }()
    
    lazy var verticalBottomView: UIView = {
        let view = UIView()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self.verticalBottomLineView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self.leftLineView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self.rightLineView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self.verticalTopView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0).priority(950))
        self.addConstraint(NSLayoutConstraint(item: self.bottomLineView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).priority(950))
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initVars()
    }
    
    init() {
        super.init(frame: .zero)
        
        self.initVars()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initVars()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initVars() {
        self.isUserInteractionEnabled = false
        self.backgroundColor = .clear
        self.topLineView.alpha = 1
        self.leftLineView.alpha = 1
        self.bottomLineView.alpha = 1
        self.rightLineView.alpha = 1
        self.horizontalLeftLineView.alpha = 0
        self.horizontalRightLineView.alpha = 0
        self.verticalTopLineView.alpha = 0
        self.verticalBottomLineView.alpha = 0
        
        self.horizontalLeftView.alpha = 0
        self.horizontalRightView.alpha = 0
        self.verticalTopView.alpha = 0
        self.verticalBottomView.alpha = 0
    }
    
    func line(_ isHidden: Bool, animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3) {
                if isHidden {
                    self.horizontalRightLineView.alpha = 0
                    self.horizontalLeftLineView.alpha = 0
                    self.verticalTopLineView.alpha = 0
                    self.verticalBottomLineView.alpha = 0
                } else {
                    self.horizontalRightLineView.alpha = 1
                    self.horizontalLeftLineView.alpha = 1
                    self.verticalTopLineView.alpha = 1
                    self.verticalBottomLineView.alpha = 1
                }
            }
        } else {
            if isHidden {
                self.horizontalRightLineView.alpha = 0
                self.horizontalLeftLineView.alpha = 0
                self.verticalTopLineView.alpha = 0
                self.verticalBottomLineView.alpha = 0
            } else {
                self.horizontalRightLineView.alpha = 1
                self.horizontalLeftLineView.alpha = 1
                self.verticalTopLineView.alpha = 1
                self.verticalBottomLineView.alpha = 1
            }
        }
    }
}
// CropDimView
class CropDimView: UIView {
    var path: CGPath?
    init() {
        super.init(frame: .zero)
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func mask(_ path: CGPath, duration: TimeInterval, animated: Bool) {
        self.path = path
        if let mask = self.layer.mask as? CAShapeLayer {
            mask.removeAllAnimations()
            if animated {
                let animation = CABasicAnimation(keyPath: "path")
                animation.delegate = self
                animation.fromValue = mask.path
                animation.toValue = path
                animation.byValue = path
                animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                animation.isRemovedOnCompletion = false
                animation.fillMode = .forwards
                animation.duration = duration
                mask.add(animation, forKey: "path")
            } else {
                mask.path = path
            }
        } else {
            let maskLayer = CAShapeLayer()
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
            maskLayer.backgroundColor = UIColor.clear.cgColor
            maskLayer.path = path
            self.layer.mask = maskLayer
        }
    }
}
// MARK: Private Method Touch Action
extension ImageCropView {
    @objc func cropButtonCenterDragEnded(_ sender: LineButton, forEvent event: UIEvent){
        self.cropLineColor = UIColor.red.withAlphaComponent(0.7)
        
    }
    @objc func cropButtonCenterDrag(_ sender: LineButton, forEvent event: UIEvent) {
        
        guard let cropLeadingConstraint = self.cropLeadingConstraint,
            let cropTrailingConstraint = self.cropTrailingConstraint,
            let cropTopConstraint =  self.cropTopConstraint,
            let cropBottomConstraint =  self.cropBottomConstraint else {
                return
        }
        guard let touchPoint = self.lineButtonTouchPoint,
            let currentPoint = self.cropButtonDrag(sender, forEvent: event) else {
                return
        }
        self.dragCenterButton(currentPoint: currentPoint, touchPoint: touchPoint, constraintX: (lead: cropLeadingConstraint, trail: cropTrailingConstraint), constraintY: (top: cropTopConstraint, bottom: cropBottomConstraint))
        
    }
    func dragCenterButton(currentPoint : CGPoint, touchPoint : CGPoint, constraintX: (lead: NSLayoutConstraint, trail: NSLayoutConstraint), constraintY: (top: NSLayoutConstraint, bottom: NSLayoutConstraint)){
        var moveFrame : Bool = false

        let lConstant = constraintX.lead.constant - (currentPoint.x - touchPoint.x)
        let rConstant = constraintX.trail.constant - (currentPoint.x - touchPoint.x)
        let tConstant = constraintY.top.constant - (currentPoint.y - touchPoint.y)
        let bConstant = constraintY.bottom.constant - (currentPoint.y - touchPoint.y)
        
        if lConstant < self.cropLeadingInitialConstraint?.constant ?? 0 && rConstant > self.cropTrailingInitialConstraint?.constant ?? 0{
            if (lConstant <= 0 || currentPoint.x - touchPoint.x > 0) &&
                     (rConstant > 0 || currentPoint.x - touchPoint.x < 0) {
                moveFrame = true
                self.cropLeadingConstraint?.constant = lConstant
                self.cropTrailingConstraint?.constant = rConstant
            }
        }
        if tConstant < self.cropTopInitialConstraint?.constant ?? 0  && bConstant > self.cropBottomInitialConstraint?.constant ?? 0 {
            if (tConstant <= 0 || currentPoint.y - touchPoint.y > 0) &&
                     (bConstant > 0 || currentPoint.y - touchPoint.y < 0) {
                moveFrame = true
                self.cropTopConstraint?.constant = tConstant
                self.cropBottomConstraint?.constant = bConstant
            }
            
        }
        if moveFrame{
            moveFrame = false
            self.dimLayerMask(animated: false)
        }
        
    }

    // Touch Down Button
    @objc  func cropButtonTouchDown(_ sender: LineButton, forEvent event: UIEvent) {
        guard let touch = event.touches(for: sender)?.first else { return }
        self.lineButtonTouchPoint = touch.location(in: self.cropView)
        self.cropView.line(false, animated: true)
        self.dimLayerMask(animated: false)
        self.lineButtonGroup
            .filter { sender != $0 }
            .forEach { $0.isUserInteractionEnabled = false }
    }
    
    // Touch Up Inside Button
    @objc func cropButtonTouchUpInside(_ sender: LineButton, forEvent event: UIEvent) {
        self.lineButtonTouchPoint = nil
        self.cropView.line(true, animated: true)
        self.dimLayerMask(animated: false)
        self.lineButtonGroup
            .forEach { $0.isUserInteractionEnabled = true }
    }
    
    func cropButtonDrag(_ sender: LineButton, forEvent event: UIEvent) -> CGPoint? {
        guard let touch = event.touches(for: sender)?.first else { return nil }
        return touch.location(in: self.cropView)
    }
    
    @objc func cropButtonLeftTopDrag(_ sender: LineButton, forEvent event: UIEvent) {
        guard let cropLeadingConstraint = self.cropLeadingConstraint,
            let cropTrailingConstraint = self.cropTrailingConstraint,
            let cropTopConstraint =  self.cropTopConstraint,
            let cropBottomConstraint =  self.cropBottomConstraint else { return }
        guard let touchPoint = self.lineButtonTouchPoint,
            let currentPoint = self.cropButtonDrag(sender, forEvent: event) else { return }
        
        self.dragLeftTopButton(currentPoint: currentPoint, touchPoint: touchPoint, constraintX: (lead: cropLeadingConstraint, trail: cropTrailingConstraint), constraintY: (top: cropTopConstraint, bottom: cropBottomConstraint))
    }
    func dragLeftTopButton(currentPoint : CGPoint, touchPoint : CGPoint, constraintX: (lead: NSLayoutConstraint, trail: NSLayoutConstraint), constraintY: (top: NSLayoutConstraint, bottom: NSLayoutConstraint)){
        let hConstant = constraintX.lead.constant - (currentPoint.x - touchPoint.x)
        let vConstant = constraintY.top.constant - (currentPoint.y - touchPoint.y)
        if hConstant < self.cropLeadingInitialConstraint?.constant ?? 0 && vConstant < cropTopInitialConstraint?.constant ?? 0 {
            self.cropLeadingConstraint?.constant = hConstant
            self.cropTopConstraint?.constant = vConstant
            self.dimLayerMask(animated: false)
        }
    }
    
    @objc func cropButtonLeftBottomDrag(_ sender: LineButton, forEvent event: UIEvent) {
        guard let cropLeadingConstraint = self.cropLeadingConstraint,
            let cropTrailingConstraint = self.cropTrailingConstraint,
            let cropTopConstraint =  self.cropTopConstraint,
            let cropBottomConstraint =  self.cropBottomConstraint else { return }
        guard let touchPoint = self.lineButtonTouchPoint,
            let currentPoint = self.cropButtonDrag(sender, forEvent: event) else { return }
        self.dragLeftBottomButton(currentPoint: currentPoint, touchPoint: touchPoint, constraintX: (lead: cropLeadingConstraint, trail: cropTrailingConstraint), constraintY: (top: cropTopConstraint, bottom: cropBottomConstraint))

    }
    func dragLeftBottomButton(currentPoint : CGPoint, touchPoint : CGPoint, constraintX: (lead: NSLayoutConstraint, trail: NSLayoutConstraint), constraintY: (top: NSLayoutConstraint, bottom: NSLayoutConstraint)){
        let hConstant = constraintX.lead.constant - (currentPoint.x - touchPoint.x)
        let vConstant = constraintY.bottom.constant - (currentPoint.y - touchPoint.y)
        if hConstant < self.cropLeadingInitialConstraint?.constant ?? 0 && vConstant > cropBottomInitialConstraint?.constant ?? 0 {
            self.lineButtonTouchPoint?.y = currentPoint.y
            self.cropLeadingConstraint?.constant = hConstant
            self.cropBottomConstraint?.constant = vConstant
            self.dimLayerMask(animated: false)
        }

    }
    
    @objc func cropButtonRightTopDrag(_ sender: LineButton, forEvent event: UIEvent) {
        guard let cropLeadingConstraint = self.cropLeadingConstraint,
            let cropTrailingConstraint = self.cropTrailingConstraint,
            let cropTopConstraint =  self.cropTopConstraint,
            let cropBottomConstraint =  self.cropBottomConstraint else { return }
        guard let touchPoint = self.lineButtonTouchPoint,
            let currentPoint = self.cropButtonDrag(sender, forEvent: event) else { return }
        
        self.dragRightTopButton(currentPoint: currentPoint, touchPoint: touchPoint, constraintX: (lead: cropLeadingConstraint, trail: cropTrailingConstraint), constraintY: (top: cropTopConstraint, bottom: cropBottomConstraint))
    }
    func dragRightTopButton(currentPoint : CGPoint, touchPoint : CGPoint, constraintX: (lead: NSLayoutConstraint, trail: NSLayoutConstraint), constraintY: (top: NSLayoutConstraint, bottom: NSLayoutConstraint)){
        let hConstant = constraintX.trail.constant - (currentPoint.x - touchPoint.x)
        let vConstant = constraintY.top.constant - (currentPoint.y - touchPoint.y)
        if hConstant > self.cropTrailingInitialConstraint?.constant ?? 0 && vConstant < cropTopInitialConstraint?.constant ?? 0 {
            self.lineButtonTouchPoint?.x = currentPoint.x
            self.cropTrailingConstraint?.constant = hConstant
            self.cropTopConstraint?.constant = vConstant
            self.dimLayerMask(animated: false)
        }
    }
    
    @objc func cropButtonRightBottomDrag(_ sender: LineButton, forEvent event: UIEvent) {
        guard let cropLeadingConstraint = self.cropLeadingConstraint,
        let cropTrailingConstraint = self.cropTrailingConstraint,
        let cropTopConstraint =  self.cropTopConstraint,
        let cropBottomConstraint =  self.cropBottomConstraint else { return }
        guard let touchPoint = self.lineButtonTouchPoint,
        let currentPoint = self.cropButtonDrag(sender, forEvent: event) else { return }
        
        self.dragRightBottomButton(currentPoint: currentPoint, touchPoint: touchPoint, constraintX: (lead: cropLeadingConstraint, trail: cropTrailingConstraint), constraintY: (top: cropTopConstraint, bottom: cropBottomConstraint))
    }
    func dragRightBottomButton(currentPoint : CGPoint, touchPoint : CGPoint, constraintX: (lead: NSLayoutConstraint, trail: NSLayoutConstraint), constraintY: (top: NSLayoutConstraint, bottom: NSLayoutConstraint)){
        let hConstant = constraintX.trail.constant - (currentPoint.x - touchPoint.x)
        let vConstant = constraintY.bottom.constant - (currentPoint.y - touchPoint.y)
        if hConstant > self.cropTrailingInitialConstraint?.constant ?? 0 && vConstant > cropBottomInitialConstraint?.constant ?? 0 {
            self.lineButtonTouchPoint?.x = currentPoint.x
            self.lineButtonTouchPoint?.y = currentPoint.y
            self.cropTrailingConstraint?.constant = hConstant
            self.cropBottomConstraint?.constant = vConstant
            self.dimLayerMask(animated: false)
        }
    }
    @objc func cropButtonLeftDrag(_ sender: LineButton, forEvent event: UIEvent) {
        guard let cropLeadingConstraint = self.cropLeadingConstraint,
            let cropTrailingConstraint = self.cropTrailingConstraint else { return }
        guard let touchPoint = self.lineButtonTouchPoint,
            let currentPoint = self.cropButtonDrag(sender, forEvent: event) else { return }
        
        self.dragLeftButton(currentPoint: currentPoint, touchPoint: touchPoint, constraintX: (lead: cropLeadingConstraint, trail: cropTrailingConstraint))
        
            }
    func dragLeftButton(currentPoint : CGPoint, touchPoint : CGPoint, constraintX: (lead: NSLayoutConstraint, trail: NSLayoutConstraint)){
        let hConstant = constraintX.lead.constant - (currentPoint.x - touchPoint.x)
        if hConstant < self.cropLeadingInitialConstraint?.constant ?? 0 {
            self.cropLeadingConstraint?.constant = hConstant
            self.dimLayerMask(animated: false)
        }
    }
    
    @objc func cropButtonTopDrag(_ sender: LineButton, forEvent event: UIEvent) {
        guard let cropTopConstraint =  self.cropTopConstraint,
            let cropBottomConstraint =  self.cropBottomConstraint else { return }
        guard let touchPoint = self.lineButtonTouchPoint,
            let currentPoint = self.cropButtonDrag(sender, forEvent: event) else { return }
        self.dragTopButton(currentPoint: currentPoint, touchPoint: touchPoint, constraintY: (top: cropTopConstraint, bottom: cropBottomConstraint))
        
    }
    
    func dragTopButton(currentPoint : CGPoint, touchPoint : CGPoint, constraintY: (top: NSLayoutConstraint, bottom: NSLayoutConstraint)){
        let vConstant = constraintY.top.constant - (currentPoint.y - touchPoint.y)
        if vConstant < cropTopInitialConstraint?.constant ?? 0{
            self.cropTopConstraint?.constant = vConstant
            self.dimLayerMask(animated: false)
        }
    }
    
    @objc func cropButtonRightDrag(_ sender: LineButton, forEvent event: UIEvent) {
        guard let cropLeadingConstraint = self.cropLeadingConstraint,
            let cropTrailingConstraint = self.cropTrailingConstraint else { return }
        guard let touchPoint = self.lineButtonTouchPoint,
            let currentPoint = self.cropButtonDrag(sender, forEvent: event) else { return }
               
        self.dragRightButton(currentPoint: currentPoint, touchPoint: touchPoint, constraintX: (lead: cropLeadingConstraint, trail: cropTrailingConstraint))

    }
    func dragRightButton(currentPoint : CGPoint, touchPoint : CGPoint, constraintX: (lead: NSLayoutConstraint, trail: NSLayoutConstraint)){
        let hConstant = constraintX.trail.constant - (currentPoint.x - touchPoint.x)
        if hConstant > self.cropTrailingInitialConstraint?.constant ?? 0 {
            self.lineButtonTouchPoint?.x = currentPoint.x
            self.cropTrailingConstraint?.constant = hConstant
            self.dimLayerMask(animated: false)
        }
    }
    
    @objc func cropButtonBottomDrag(_ sender: LineButton, forEvent event: UIEvent) {
        guard let cropTopConstraint =  self.cropTopConstraint,
            let cropBottomConstraint =  self.cropBottomConstraint else { return }
        guard let touchPoint = self.lineButtonTouchPoint,
            let currentPoint = self.cropButtonDrag(sender, forEvent: event) else { return }
        
        self.dragBottomButton(currentPoint: currentPoint, touchPoint: touchPoint, constraintY: (top: cropTopConstraint, bottom: cropBottomConstraint))

    }
    func dragBottomButton(currentPoint : CGPoint, touchPoint : CGPoint, constraintY: (top: NSLayoutConstraint, bottom: NSLayoutConstraint)){
        let vConstant = constraintY.bottom.constant - (currentPoint.y - touchPoint.y)
        if vConstant > cropBottomInitialConstraint?.constant ?? 0 {
            self.lineButtonTouchPoint?.y = currentPoint.y
            self.cropBottomConstraint?.constant = vConstant
            self.dimLayerMask(animated: false)
        }
    }
}

// MARK: CAAnimationDelegate
extension CropDimView: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let path = self.path else { return }
        if let mask = self.layer.mask as? CAShapeLayer {
            mask.removeAllAnimations()
            mask.path = path
        }
    }
}

// MARK: LineButtonDelegate
extension ImageCropView: LineButtonDelegate {
    // When highlighted on the line button disappears, Enable interaction for all buttons.
    func lineButtonUnHighlighted() {
        self.lineButtonTouchPoint = nil
        self.cropView.line(true, animated: true)
        self.dimLayerMask(animated: false)
        self.lineButtonGroup
            .forEach { $0.isUserInteractionEnabled = true }
    }
}
// Called when the button's highlighted is false.
protocol LineButtonDelegate: class {
    func lineButtonUnHighlighted()
}

// Side, Edge LineButton
class LineButton: UIButton {
    weak var delegate: LineButtonDelegate?
    private var type: ButtonLineType
    
    override var isHighlighted: Bool {
        didSet {
            if !self.isHighlighted {
                self.delegate?.lineButtonUnHighlighted()
            }
        }
    }
    // MARK: Init
    init(_ type: ButtonLineType, buttonSize : CGSize) {
        self.type = type
        super.init(frame: CGRect(x: 0, y: 0, width: buttonSize.width, height: buttonSize.height))
        self.setTitle(nil, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func edgeLine(_ color: UIColor?) {
        self.setImage(self.type.view(color)?.imageWithView?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
}

enum ButtonLineType {
    case center
    case leftTop, rightTop, leftBottom, rightBottom, top, left, right, bottom
    
    var rotate: CGFloat {
        switch self {
        case .leftTop:
            return 0
        case .rightTop:
            return CGFloat.pi/2
        case .rightBottom:
            return CGFloat.pi
        case .leftBottom:
            return CGFloat.pi/2*3
        case .top:
            return 0
        case .left:
            return CGFloat.pi/2*3
        case .right:
            return CGFloat.pi/2
        case .bottom:
            return CGFloat.pi
        case .center:
            return 0
        }
    }
    
    var yMargin: CGFloat {
        switch self {
        case .rightBottom, .bottom:
            return 1
        default:
            return 0
        }
    }
    
    var xMargin: CGFloat {
        switch self {
        case .leftBottom:
            return 1
        default:
            return 0
        }
    }
    
    func view(_ color: UIColor?) -> UIView? {
        var view: UIView?
        if self == .leftTop || self == .rightTop || self == .leftBottom || self == .rightBottom {
            view = ButtonLineType.EdgeView(self, color: color)
        } else {
            view = ButtonLineType.SideView(self, color: .clear)
        }
        view?.isOpaque = false
        view?.tintColor = color
        return view
    }
    
    class LineView: UIView {
        var type: ButtonLineType
        var color: UIColor?
        
        init(_ type: ButtonLineType, color: UIColor?) {
            self.type = type
            self.color = color
            super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func apply(_ path: UIBezierPath) {
            var pathTransform  = CGAffineTransform.identity
            pathTransform = pathTransform.translatedBy(x: 25, y: 25)
            pathTransform = pathTransform.rotated(by: self.type.rotate)
            pathTransform = pathTransform.translatedBy(x: -25 - self.type.xMargin, y: -25 - self.type.yMargin)
            path.apply(pathTransform)
            path.closed()
            path.strokeFill(self.color ?? .white)
        }
    }
    
    class EdgeView: LineView {
        override func draw(_ rect: CGRect) {
            let path = UIBezierPath()
                .move(5, 5)
                .line(5, 100)
                .line(8, 100)
                .line(8, 8)
                .line(100, 8)
                .line(100, 5)
                .line(5, 5)
             
            self.apply(path)
        }
    }
    class SideView: LineView {
        override func draw(_ rect: CGRect) {
            let path = UIBezierPath()
                .move(15, 6)
                .line(35, 6)
                .line(35, 8)
                .line(15, 8)
                .line(15, 6)
            self.apply(path)
        }
    }
}

