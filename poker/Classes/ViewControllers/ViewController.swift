//
//  ViewController.swift
//  poker
//
//  Created by 高橋洸介 on 2016/07/02.
//  Copyright © 2016年 高橋洸介. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var eLabel: UILabel!
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    var cardsImage = [String]()
    var cards = [Card]()
    var youScore = 0
    
    var eCardsImage = [String]()
    var eCards = [Card]()
    var enemyScore = 0
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cardCollectionView.allowsMultipleSelection = true
        if cards.count != 5 {
            let tehuda = Deck().getRandom(count: 5)
            let eTehuda = Deck().getRandom(count: 5)
            
            for card in tehuda {
                let cardImage = Card.toImageName(card)()
                cards.append(card)
                cardsImage.append(cardImage)
            }
            
            for eCard in eTehuda {
                let eCardImage = Card.toImageName(eCard)()
                eCards.append(eCard)
                eCardsImage.append(eCardImage)
            }
        }
        let rowRankHand = judge.role(cards: cards)
        self.label.text = "あなたの手役は\(rowRankHand.0)です。"
        self.youScore = rowRankHand.1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func reload(_ sender: UIButton) {
//        self.view = nil
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "ViewController")
//        
//        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    @IBAction func change(_ sender: UIButton) {
        var count = 0
        for card in cards {
            if card.selected == true {
                let changeCard = Deck().changeCard()
                cards[count] = changeCard
                
            }
            count += 1
        }
        loadView()
        viewDidLoad()
    }
    
    @IBAction func battle(_ sender: UIButton) {
        
        self.flag = true
        self.cardCollectionView.reloadData()
        
        let rowRankHand = judge.role(cards: eCards)
        self.eLabel.text = "相手の手役は\(rowRankHand.0)です。"
        self.enemyScore = rowRankHand.1
        
        if self.youScore > self.enemyScore {
            self.result.text = "あなたの勝ちです。"
        } else if self.youScore < self.enemyScore {
            self.result.text = "あなたの負けです。"
        } else {
            self.result.text = "引き分けです。"
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
        
        switch indexPath.section {
        case 0:
            if flag {
                let name = eCards[indexPath.row].toImageName()
                cell.setImage(card: name)
            } else {
                let card = "r.png"
                cell.setImage(card: card)
            }
        case 1:
            cell.frame = CGRect(x: cell.frame.minX, y: 330, width: cell.frame.width, height: cell.frame.height)
            let name = cards[indexPath.row].toImageName()
            cell.setImage(card: name)
        default:
            print("error")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            print("")
        case 1:
            let cell = cardCollectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
            if cell.cardImage.frame.minY == 20.0 {
                cell.cardImage.frame = CGRect(x: cell.cardImage.frame.minX, y: 0, width: cell.cardImage.frame.width, height: cell.cardImage.frame.height)
                cards[indexPath.row].selected = true
            } else {
                cell.cardImage.frame = CGRect(x: cell.cardImage.frame.minX, y: 20, width: cell.cardImage.frame.width, height: cell.cardImage.frame.height)
                cell.isSelected = false
            }
        default:
            print("")
        }
    }
}
