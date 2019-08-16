//
//  Card.swift
//  concentration
//
//  Created by Einar Balan on 8/12/19.
//  Copyright © 2019 Einar Balan. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    //Hashable and Equatable implementation
    var hashValue: Int {return id}
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    //card properties
    var isFaceUp = false
    var isMatched = false
    var isSeen = false
    private var id: Int
    
    private static var idFactory = 0
    
    private static func getUniqueId() -> Int {
        idFactory += 1
        return idFactory
    }
    
    init() {
        id = Card.getUniqueId()
    }
    
    
}
