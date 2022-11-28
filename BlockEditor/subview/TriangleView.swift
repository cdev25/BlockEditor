//
//  TriangleView.swift
//  BlockEditor
//
//  Created by Mini on 11/26/22.
//

import Foundation
import UIKit

class TriangleView : UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    var arrowDirection : UIPopoverArrowDirection = .up
    var arrowColor : UIColor = .white
    
    convenience init(arrowDirection: UIPopoverArrowDirection) {
        self.init(frame: .zero)
        self.arrowDirection = arrowDirection
    }
    
    override func draw(_ rect: CGRect) {
        
        let width = self.layer.frame.size.width
        let height = self.layer.frame.size.height

        let path = CGMutablePath()

        switch arrowDirection {
        case .down:
            path.move   (to: CGPoint(x: 0       , y: 0))
            path.addLine(to: CGPoint(x: width/2 , y: height))
            path.addLine(to: CGPoint(x: width   , y: 0))
            path.addLine(to: CGPoint(x: 0       , y: 0))
        default:
            // up
            path.move   (to: CGPoint(x: 0       , y: height))
            path.addLine(to: CGPoint(x: width/2 , y: 0))
            path.addLine(to: CGPoint(x: width   , y: height))
            path.addLine(to: CGPoint(x: 0       , y: height))
        }
        

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = self.arrowColor.cgColor

        layer.insertSublayer(shape, at: 0)
    
    }
}
