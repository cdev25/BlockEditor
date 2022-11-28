//
//  Block.swift
//  BlockEditor
//
//  Created by Mini on 11/26/22.
//

import Foundation

var BLOCKCOUNT = 0

struct Block {
    var count : Int
    var id : String
    var type : BlockTypes
    var data : BlockData
}

func nextBlockCount() -> Int {
    BLOCKCOUNT += 1
    return BLOCKCOUNT
}
