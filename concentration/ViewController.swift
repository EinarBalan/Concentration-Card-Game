//
//  ViewController.swift
//  concentration
//
//  Created by Einar Balan on 8/12/19.
//  Copyright © 2019 Einar Balan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numPairs: (numberOfPairs))
    
    var numberOfPairs: Int {
        return (buttonCards.count + 1) / 2
    }
    
    private var themes = [Theme(emojis: "👻🎃👽🍬🍭😈🤡", boardColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.9352525685), cardBackColor: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)), Theme(emojis: "😀😍🤩🤪😘🤬", boardColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), cardBackColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Theme(emojis: "⚽️🏀🏈⚾️🏐🎾", boardColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), cardBackColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), Theme(emojis: "🐶🐱🐭🐹🐷🦄", boardColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), cardBackColor: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)), Theme(emojis: "🐙🦑🦐🦀🐡🐠🐳", boardColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), cardBackColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), Theme(emojis: "🍎🍔🌶🍆🌮🌯🍱", boardColor: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), cardBackColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))]
    
    private var cardEmojis = "👻🎃👽🍬🍭😈🤡"
    private var cardBackgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
    private var boardColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.9352525685)
    private var emoji = [Card: String]()
    
    @IBOutlet private weak var labelFlipCount: UILabel!
    
    @IBOutlet weak var labelScore: UILabel!
    
    @IBOutlet private var buttonCards: [UIButton]!
    
    @IBOutlet weak var buttonNewGame: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame(nil)
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let touchIndex = buttonCards.firstIndex(of: sender) {
            game.chooseCard(at: touchIndex)
            updateViewFromModel()
            updateUI()
        }
        else {
            print("card not found in collection")
        }
        
    }
    
    @IBAction private func newGame(_ sender: UIButton?) {
        game = Concentration(numPairs: (numberOfPairs))
        updateUI()
        chooseRandomTheme()
        updateViewFromModel()
    }
    
    private func chooseRandomTheme() {
        let randTheme = themes[Int.random(in: themes.indices)]
        cardEmojis = randTheme.emojis
        cardBackgroundColor = randTheme.cardBackColor
        boardColor = randTheme.boardColor
        
    }
    
    private func updateViewFromModel() {
        view.backgroundColor = boardColor
        labelScore.textColor = cardBackgroundColor
        labelFlipCount.textColor = cardBackgroundColor
        buttonNewGame.setTitleColor(cardBackgroundColor, for: UIControl.State.normal)
        
        for index in buttonCards.indices {
            let button = buttonCards[index]
            let card = game.cards[index]
            if (card.isFaceUp) {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : cardBackgroundColor
            }
        }
        
    }
    
    private func updateUI() {
        labelFlipCount.text = "Flip Count: \(game.flipCount)"
        labelScore.text = "Score: \(game.score)"
    }
    
    private func emoji(for card: Card) -> String {
        // assign emoji to card id if it hasn't been set yet
        if (emoji[card] == nil), (cardEmojis.count > 0) {
            let randStringIndex = cardEmojis.index(cardEmojis.startIndex, offsetBy: Int.random(in: 0..<cardEmojis.count))
            emoji[card] = String(cardEmojis.remove(at: randStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
}

