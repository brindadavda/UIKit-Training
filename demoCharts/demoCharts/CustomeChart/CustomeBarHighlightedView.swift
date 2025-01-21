//
//  CustomeBarHighlightedView.swift
//  demoCharts
//
//  Created by apple on 14/06/24.
//

import Foundation
import FLCharts
import UIKit

///MARK: - making custome highlightBar
///
///
public final class CustomeBarHighlightedView: UIView, HighlightedView {
    
    public var dataValue: String?
    
    private let dataValueLabel = UILabel()
    private let unitOfMeasureLabel = UILabel()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = FLColor.lightGray
        layer.cornerRadius = 5
        dataValueLabel.text = "0"
        dataValueLabel.textColor = .black
        dataValueLabel.textAlignment = .right
        dataValueLabel.font = .preferredFont(for: .subheadline, weight: .bold)
        dataValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        unitOfMeasureLabel.textColor = .black.withAlphaComponent(0.5)
        unitOfMeasureLabel.textAlignment = .left
        unitOfMeasureLabel.font = .preferredFont(for: .footnote, weight: .medium)
        unitOfMeasureLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(dataValueLabel)
        NSLayoutConstraint.activate([
            dataValueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dataValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dataValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        addSubview(unitOfMeasureLabel)
        NSLayoutConstraint.activate([
            unitOfMeasureLabel.leadingAnchor.constraint(equalTo: dataValueLabel.trailingAnchor, constant: 3),
            unitOfMeasureLabel.bottomAnchor.constraint(equalTo: dataValueLabel.bottomAnchor),
            unitOfMeasureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var intrinsicContentSize: CGSize {
        CGSize(width: 10 + dataValueLabel.intrinsicWidth + 5 + unitOfMeasureLabel.intrinsicWidth + 10,
               height: 10 + dataValueLabel.intrinsicHeight + 10)
    }
    
    public func update(with value: String?) {
        dataValueLabel.text = value
    }
    
    public func update(withChartData chartData: FLChartData?) {
        unitOfMeasureLabel.text = chartData?.yAxisUnitOfMeasure
    }
}


extension UIView {
    
    var intrinsicWidth: CGFloat {
        intrinsicContentSize.width
    }
    
    var intrinsicHeight: CGFloat {
        intrinsicContentSize.height
    }
    
    static func quickAnimation(_ animations: @escaping () -> Void) {
        animate(withDuration: 0.25, animations: animations)
    }
    
    static func animateContraints(for view: UIView, damping: CGFloat, response: CGFloat, delay: TimeInterval = 0) {
        animate(damping: 0.6, response: 0.7) {
            view.layoutIfNeeded()
        }
    }
    
    static func animate(damping: CGFloat, response: CGFloat, delay: TimeInterval = 0, animations: @escaping () -> Void, completion: ((UIViewAnimatingPosition) -> Void)? = nil) {
        var animator = UIViewPropertyAnimator()
        let timingParameters = UISpringTimingParameters(damping: damping, response: response)
        animator = UIViewPropertyAnimator(duration: 0, timingParameters: timingParameters)
        animator.addAnimations(animations)
        if let completion = completion {
            animator.addCompletion(completion)
        }
        animator.startAnimation(afterDelay: delay)
    }
}
