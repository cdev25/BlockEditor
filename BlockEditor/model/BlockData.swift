//
//  BlockData.swift
//  BlockEditor
//
//  Created by Mini on 11/26/22.
//

import Foundation
import UIKit


protocol BlockData {
    var isEmpty : Bool { get }
}

struct BlockHeading : BlockData {
    var text : String
    var level : Int
    var isEmpty: Bool { return text.isEmpty }
}

struct BlockParagraph : BlockData {
    var text : String
    var isEmpty: Bool { return text.isEmpty }
}

struct BlockList : BlockData {
    var style : String // ordered/unordered
    var items : [String]
    var isEmpty: Bool { return items.isEmpty }
}

struct BlockImage : BlockData {
    var file : UIImage?
    var caption : String
    var isEmpty: Bool { return file == nil }
}
