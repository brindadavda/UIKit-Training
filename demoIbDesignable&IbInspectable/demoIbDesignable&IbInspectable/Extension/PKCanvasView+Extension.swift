//
//  PKCanvasView+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import UIKit
import PencilKit

extension PKCanvasView {
    
    func asImage() -> UIImage? {
        let canvasView = self
        let visibleBounds = canvasView.drawing.bounds
        let renderer = UIGraphicsImageRenderer(size: visibleBounds.size)
        let image = renderer.image { context in
            context.cgContext.translateBy(x: -visibleBounds.origin.x, y: -visibleBounds.origin.y)
            context.cgContext.clip(to: CGRect(origin: .zero, size: canvasView.bounds.size))
            canvasView.drawing.image(from: visibleBounds, scale: 1.0).draw(in: visibleBounds)
        }
        return image
    }
    
}
