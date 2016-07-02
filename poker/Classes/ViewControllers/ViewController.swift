//
//  ViewController.swift
//  poker
//
//  Created by 高橋洸介 on 2016/07/02.
//  Copyright © 2016年 高橋洸介. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var card1: UIImageView!
    @IBOutlet weak var card2: UIImageView!
    @IBOutlet weak var card3: UIImageView!
    @IBOutlet weak var card4: UIImageView!
    @IBOutlet weak var card5: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cardsImage = [String]()
        var cards = [Int]()
        
        let tehuda = Deck().getRandom(count: 5)
        for card in tehuda {
            let cardImage = Card.toImageName(card)
            cards.append(card.number)
            cardsImage.append(cardImage())
        }
        
        self.card1.image = UIImage(named: cardsImage[0])
        self.card2.image = UIImage(named: cardsImage[1])
        self.card3.image = UIImage(named: cardsImage[2])
        self.card4.image = UIImage(named: cardsImage[3])
        self.card5.image = UIImage(named: cardsImage[4])
        
        let isTwoPair = hantei().pair(ints: cards)
        if isTwoPair {
            self.label.text = "ツーペア"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

