//
//  Theme.swift
//  concentration
//
//  Created by Einar Balan on 8/15/19.
//  Copyright © 2019 Einar Balan. All rights reserved.
//

import UIKit

struct Theme {
    var emojis: String
    var boardColor: UIColor
    var cardBackColor: UIColor
    
    init(emojis: String, boardColor: UIColor, cardBackColor: UIColor) {
        self.emojis = emojis
        self.boardColor = boardColor
        self.cardBackColor = cardBackColor
    }
    
    
}
