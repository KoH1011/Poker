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
    var hand = ""
    
    var eCardsImage = [String]()
    var eCards = [Card]()
    var eHand = ""
    var enemyScore = 0
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cardCollectionView.allowsMultipleSelection = true
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
        self.getHand()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getHand() {
        let playerHand = judge.role(cards: cards)
        self.hand = playerHand.0
        self.youScore = playerHand.1
        self.label.text =  "playerの手役は\(playerHand.0)です。"
        
        let eHand = judge.role(cards: eCards)
        self.eHand = eHand.0
        self.enemyScore = eHand.1
    }
    
    func comChange(cards: [Card]) {
        var cards = cards
        let arrowCards = self.comArrow(cards: cards)
        var count = 0
        
        for number in arrowCards {
        
            
            // スリーカードの場合落ちる
            
            print(cards)
            let index = cards.index(where: {return $0.number == number})
            print(index)
            cards.remove(at: Int(index!))
            count += 1
        }
        
        if count != 0 {
            let drawCards = Deck().getRandom(count: count)
            for card in drawCards {
                cards.append(card)
            }
        }
        eCards = cards
    }
    
    func comArrow(cards: [Card]) -> [Int] {
           // 各ランクがそれぞれ何枚あるかをnumOfRanksに保存
        var numOfRanks = [0,0,0,0,0,0,0,0,0,0,0,0,0]
        for card in cards {
            numOfRanks[card.number - 1] += 1
        }
        print(numOfRanks)
        var num = [Int]()
        
        if self.enemyScore > 3 {
            print("何もしない")
        } else if self.enemyScore == 3 {
            
            // 配列から"1"という要素を複数見つけるためにはどうするか。
            
            num = [numOfRanks.index(of: 1)!]
        } else if self.enemyScore < 3 {
            num = self.test(numOfRanks: numOfRanks)
        }
        
        print(num)
        return num
    }
    
    private func test(numOfRanks: [Int]) -> [Int] {
        var num = [Int]()
        var count = 0
        for a in numOfRanks {
            count += 1
            if a == 1 {
                num.append(count)
            }
        }
        return num
    }
    
    @IBAction func reload(_ sender: UIButton) {
        
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
        self.getHand()
//        let a = ExpectedValue().bestThrow(cards: self.eCards)
        comChange(cards: eCards)
    }
    
    @IBAction func battle(_ sender: UIButton) {
        
        self.flag = true
        self.cardCollectionView.reloadData()
        
        self.eLabel.text = "相手の手役は\(self.eHand)です。"
        
        if self.youScore > self.enemyScore {
            self.result.text = "player Win"
        } else if self.youScore < self.enemyScore {
            self.result.text = "player Lose.."
        } else {
            self.result.text = "Draw"
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
                print(eCards)
                print(eCards.count)
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
