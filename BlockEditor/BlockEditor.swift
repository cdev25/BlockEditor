//
//  BlockEditor.swift
//  BlockEditor
//
//  Created by Mini on 11/26/22.
//


import Foundation
import UIKit



class BlockEditor : UITableViewController {
    
    static func spawn() -> BlockEditor {
        return BlockEditor(style: .plain)
    }
    
    
    var content = [Block]()
    var footerView = UIView()
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ParagraphCell.self, forCellReuseIdentifier: "ParagraphCell")
        tableView.allowsSelection = false
        
        let footerTapper = UIGestureRecognizer(target: self, action: #selector(footerTapped))
        footerView.addGestureRecognizer(footerTapper)
        footerView.backgroundColor = .orange
        
        button.addTarget(self, action: #selector(footerTapped), for: .touchUpInside)
        button.backgroundColor = .green
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return button
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var block = content[indexPath.row]
        let isNew = block.id == "new"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ParagraphCell", for: indexPath) as? ParagraphCell else { return .init() }
        
        cell.editor = self
        
        if block.id == "new" {
            block.id = UUID.init().uuidString
            content[indexPath.row] = block
        }
        
        cell.load(block: block)
        
        if isNew {
            cell.blockCellBecomeFocus()
        }
        
        return cell
    }
    
    @objc func footerTapped() {
        
        // TODO: check if the last block is empty and become first responder instead of adding a new block
        
        if let last = content.last {
            if (last.type == .paragraph || last.type == .header)
                && last.data.isEmpty {
                
                
            }
                
        }
        
        let newBlock = Block(count: nextBlockCount(), id: "new", type: .paragraph, data: BlockParagraph.init(text: ""))
        content.append(newBlock)
        self.tableView.insertRows(at: [.init(row: content.count - 1, section: 0)], with: .automatic)
    }
    
    func newLine(indexPath: IndexPath) {
        let newBlock = Block(count: nextBlockCount(), id: "new", type: .paragraph, data: BlockParagraph.init(text: ""))
        content.insert(newBlock, at: indexPath.row + 1)
        self.tableView.insertRows(at: [.init(row: indexPath.row + 1, section: 0)], with: .automatic)
    }
    
    func deleteBlock(block: Block) {
        if let match = self.content.firstIndex(where: { $0.count == block.count }) {
            self.content.remove(at: match)
            self.tableView.deleteRows(at: [.init(row: match, section: 0)], with: .automatic)
        }
    }
}

