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
    
    @IBOutlet weak var eCard1: UIImageView!
    @IBOutlet weak var eCard2: UIImageView!
    @IBOutlet weak var eCard3: UIImageView!
    @IBOutlet weak var eCard4: UIImageView!
    @IBOutlet weak var eCard5: UIImageView!
    @IBOutlet weak var eLabel: UILabel!
    @IBOutlet weak var result: UILabel!
    
    var eCardsImage = [String]()
    var eCards = [Card]()
    var youScore = 0
    var enemyScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cardsImage = [String]()
        var cards = [Card]()
        
        let tehuda = Deck().getRandom(count: 5)
        let eTehuda = Deck().getRandom(count: 5)
        
        for card in tehuda {
            let cardImage = Card.toImageName(card)
            cards.append(card)
            cardsImage.append(cardImage())
        }
        
        for eCard in eTehuda {
            let eCardImage = Card.toImageName(eCard)
            eCards.append(eCard)
            eCardsImage.append(eCardImage())
        }
        
        self.card1.image = UIImage(named: cardsImage[0])
        self.card2.image = UIImage(named: cardsImage[1])
        self.card3.image = UIImage(named: cardsImage[2])
        self.card4.image = UIImage(named: cardsImage[3])
        self.card5.image = UIImage(named: cardsImage[4])
        
        
        self.eCard1.image = UIImage(named: "r.png")
        self.eCard2.image = UIImage(named: "r.png")
        self.eCard3.image = UIImage(named: "r.png")
        self.eCard4.image = UIImage(named: "r.png")
        self.eCard5.image = UIImage(named: "r.png")
        
        let rowRankHand = judge.role(cards: cards)
        self.label.text = "あなたの手役は\(rowRankHand.0)です。"
        self.youScore = rowRankHand.1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func reload(_ sender: UIBarButtonItem) {
        self.view = nil
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ViewController")
        
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    @IBAction func battle(_ sender: UIButton) {
        self.eCard1.image = UIImage(named: eCardsImage[0])
        self.eCard2.image = UIImage(named: eCardsImage[1])
        self.eCard3.image = UIImage(named: eCardsImage[2])
        self.eCard4.image = UIImage(named: eCardsImage[3])
        self.eCard5.image = UIImage(named: eCardsImage[4])
        
        let rowRankHand = judge.role(cards: eCards)
        self.eLabel.text = "相手の手役は\(rowRankHand.0)です。"
        self.enemyScore = rowRankHand.1
        
        if self.youScore > self.enemyScore {
            self.result.text = "あなたの勝ちです"
        } else if self.youScore < self.enemyScore {
            self.result.text = "あなたの負けです"
        } else {
            self.result.text = "引き分けです"
        }
    }
}
