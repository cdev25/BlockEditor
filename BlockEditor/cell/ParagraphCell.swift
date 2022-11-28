//
//  ParagraphCell.swift
//  BlockEditor
//
//  Created by Mini on 11/26/22.
//

import Foundation
import UIKit

class ParagraphCell : UITableViewCell, BlockCell {
    
    var toolbar : BlockToolbar!
    
    let field = UITextField()
    
    var block : Block?
    
    weak var editor : BlockEditor?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(field)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.delegate = self
        
        NSLayoutConstraint.activate([
            field.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            field.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            field.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            field.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutMarginsDidChange() {
        print(">>> \(self.block?.count) layoutMarginsDidChange \(self.frame)")
        updateToolbarFrame()
    }
    
    
    func blockCellBecomeFocus() {
        self.field.becomeFirstResponder()
        showToolBar()
    }
    
    func load(block: Block) {
        guard let blockParagraph = block.data as? BlockParagraph else {
            return
        }
        self.block = block
        field.text = blockParagraph.text
    }
 
    func showToolBar() {
        
        guard let window = self.window else {
            return
        }
        
        hideToolbar()
        
        let boundingRect = window.bounds.inset(by: window.safeAreaInsets)
        self.toolbar = self.toolbar ?? BlockToolbar()
        self.toolbar.delegate = self
        self.toolbar.count = block?.count
        window.addSubview(toolbar)
        
        print(">>> field.frame \(field.frame) field.bounds \(field.bounds)")
        print(">>> contentView.frame \(contentView.frame) contentView.bounds \(contentView.bounds)")
        print(">>> cell.frame \(self.frame) cell.bounds \(self.bounds)")
        
        
        toolbar.frame = .init(origin: .init(x: self.frame.minX, y: self.frame.maxY + window.safeAreaInsets.top), size: .init(width: 200, height: 40))
        toolbar.alpha = 0.0
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseOut]) { [unowned self] () in
            self.toolbar.alpha = 1.0
        } completion: { bool in
            
        }

    }
    
    func hideToolbar() {
        self.toolbar?.removeFromSuperview()
        self.toolbar = nil
    }
    
    func updateToolbarFrame() {
        guard let toolbar = self.toolbar else {
            return
        }
        
        guard let window = self.contentView.window else {
            preconditionFailure("Can't find anchor view's window")
        }
        
        toolbar.frame = .init(origin: .init(x: self.frame.minX, y: self.frame.maxY + window.safeAreaInsets.top), size: .init(width: 200, height: 40))
    }
}

extension ParagraphCell : UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Tooltip.shared.show(message: "TESTing", anchor: self.contentView, direction: .down)
        showToolBar()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Tooltip.shared.hide()
        hideToolbar()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let editor = self.editor else { return false }
        
        guard let indexPath = editor.tableView.indexPath(for: self) else { return false }
        
        self.field.endEditing(true)
        
        editor.newLine(indexPath: indexPath)
        
        return false
    }
    
}


extension ParagraphCell : BlockToolbarDelegate {
    func blockToolbarDelete() {
        guard let block = self.block else { return }
        self.editor?.deleteBlock(block: block)
    }
}
