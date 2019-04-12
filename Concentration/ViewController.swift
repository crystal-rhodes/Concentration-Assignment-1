//
//  ViewController.swift
//  Concentration
//
//  Created by Man Vu Minh on 2019-03-30.
//  Copyright © 2019 Man Vu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    lazy var chosenSetsOfEmoji = getIndexOfChosenEmoji
    
    var getIndexOfChosenEmoji: Int {
        return Int.random(in: 0..<emojiChoices.count)
    }
    
    var numberOfPairsOfCards: Int {
            return (cardButtons.count + 1) / 2
    }
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func onNewGamePressed(_ sender: Any) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        chosenSetsOfEmoji = getIndexOfChosenEmoji
        updateViewFromModel()
    }
    
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = [
        ["🥰", "🙃", "😏", "😝", "😃", "😍", "🥰", "🤪", "🥶", "😱"],
        ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯"],
        ["🍏", "🍎", "🍐","🍊", "🍋", "🍌","🍉", "🍇", "🍓", "🍈"],
        ["⚽️", "🏀", "🏈","⚾️", "🥎", "🎾","🏐", "🏉", "🥏", "🎱"],
        ["🚗", "🚕", "🚙","🚌", "🚎", "🏎","🚓", "🚑", "🚒", "🚐"],
        ["⌚️", "📱", "💻","⌨️", "🖥", "🖨","🖱", "🖲", "🕹", "🗜"],
    ]
    
    var emoji = [Int:String]()
    
    @IBAction func touchCard(_ sender: UIButton) {
//        flipCount += 1
        
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            print("cardNumber = \(cardNumber)")
            updateViewFromModel()
            
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        scoreLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.6289438605, blue: 0, alpha: 0) :  #colorLiteral(red: 1, green: 0.6289438605, blue: 0, alpha: 1)
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil {
            if emojiChoices[chosenSetsOfEmoji].count > 0 {
                let randomIndex = Int.random(in: 0 ..< emojiChoices[chosenSetsOfEmoji].count)
                emoji[card.identifier] = emojiChoices[chosenSetsOfEmoji].remove(at: randomIndex)
            }
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

