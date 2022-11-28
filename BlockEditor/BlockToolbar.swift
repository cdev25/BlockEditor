//
//  BlockToolbar.swift
//  BlockEditor
//
//  Created by Mini on 11/26/22.
//

import Foundation
import UIKit

protocol BlockToolbarDelegate : class {
    func blockToolbarDelete()
}

class BlockToolbar : UIView {
    var label = UILabel()
    
    var addButton : UIButton = .init()
    var delButton : UIButton = .init()
    
    weak var delegate : BlockToolbarDelegate?
    
    // TODO: remove this. for debug only
    var count : Int? {
        didSet {
            self.label.text = count?.description ?? ".."
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
        self.addSubview(label)
        self.addSubview(addButton)
        self.addSubview(delButton)
        
        label.text = count?.description ?? ".."
        addButton.setTitle("ADD", for: .normal)
        addButton.layer.borderColor = UIColor.black.cgColor
        addButton.layer.cornerRadius = 4
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        
        delButton.setTitle("DEL", for: .normal)
        delButton.layer.borderColor = UIColor.black.cgColor
        delButton.layer.cornerRadius = 4
        delButton.addTarget(self, action: #selector(delButtonPressed), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("BlockToolbar init(coder: )")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = .init(origin: .zero, size: .init(width: 20, height: 20))
        addButton.frame = .init(origin: .init(x: 20, y: 0), size: .init(width: 40, height: 40))
        delButton.frame = .init(origin: .init(x: 20 + 40 + 4, y: 0), size: .init(width: 40, height: 40))
    }
    
    
    
    @objc func addButtonPressed() {
        
    }
    
    @objc func delButtonPressed() {
        self.delegate?.blockToolbarDelete()
    }
}


//public enum TooltipDirection {
//    case up
//    case down
//}

//class TooltipView : ResizeableNode {
//    static let arrowSize = CGSize(width: 14.0, height: 7.0)
//    static let padding : CGFloat = 5
//
//    var message : String = ""
//    var direction : TooltipDirection = .up
//    var arrow = ASDisplayNode()
//
//    var label = ReTextNode()
//
//    convenience init(message: String, direction: TooltipDirection) {
//        //self.init(frame: .zero)
//        self.init()
//        self.message = message
//        self.direction = direction
//        setup()
//    }
//
//
//    func setup() {
//        label.setText(message, color: .white)
//        label.backgroundColor = Common.baseColor.black.uicolor
//        label.textContainerInset = .init(all: TooltipView.padding)
//        label.border(radius: 6, noBorder: true)
//        label.clipsToBounds = true
//
//        arrow.setViewBlock {
//            return tell(TriangleView(arrowDirection: self.direction == .up ? .down : .up)) {
//                $0.arrowColor = Common.baseColor.black.uicolor
//            }
//        }
//    }
//
//    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
//
//        return ASLayoutSpec.vStackSpec {
//            arrow
//                .frame(size: TooltipView.arrowSize)
//            ASInsetLayoutSpec()
//                .child(label)
//                .insets(.init(all: 0))
//        }.spacing(0).align(.center)
//
//    }
//
//    func tooltipRect(anchor: UIView) -> CGRect {
//
//        let maxWidth = UIScreen.main.traitCollection.horizontalSizeClass == .compact
//            ? UIScreen.main.bounds.width * 0.8
//            : UIScreen.main.bounds.width * 0.5
//
//        let textbounds = label.attributedText!
//            .boundingRect(with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude),
//                          options: .usesLineFragmentOrigin,
//                          context: nil)
//        let tooltipSize = CGSize (width: textbounds.size.width + TooltipView.padding * 2,
//                                  height: textbounds.size.height + TooltipView.padding * 2)
//
//        let tooltipOrigin = { () -> CGPoint in
//            switch direction {
//            case .up:
//                return CGPoint(x: anchor.frame.width/2 - tooltipSize.width/2,
//                               y: 0 - tooltipSize.height)
//            case .down:
//                return CGPoint(x: anchor.frame.width/2 - tooltipSize.width/2,
//                               y: anchor.frame.height + TooltipView.arrowSize.height)
//            }
//        }()
//
//        let convertedOrigin = anchor.convert(tooltipOrigin, to: anchor.window)
//        let fittedOrigin = { () -> CGPoint in
//            if convertedOrigin.x < 0 {
//                return CGPoint(x: 10, y: convertedOrigin.y)
//            } else if (convertedOrigin.x + tooltipSize.width) > anchor.window!.frame.width {
//                return CGPoint(x: anchor.window!.frame.width - 10 - tooltipSize.width, y: convertedOrigin.y)
//            }
//            return convertedOrigin
//        }()
//
//        let tooltipRect = CGRect(origin: fittedOrigin, size: tooltipSize)
//
//        return tooltipRect
//    }
//
//}
//
