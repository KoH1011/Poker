//
//  ViewController.swift
//  poker
//
//  Created by 高橋洸介 on 2016/07/02.
//  Copyright © 2016年 高橋洸介. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

enum FieldType: Int {
    case CPU
    case Player
}

class ViewController: UIViewController {
    
    struct Const {
        static let cardMax = 5
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var eLabel: UILabel!
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var changeButton: UIButton!
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
    
    var turn = 6
    
    let yamahuda = Deck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cardCollectionView.allowsMultipleSelection = true
        let tehuda = self.yamahuda.getRandom(count: 5)
        let eTehuda = self.yamahuda.getRandom(count: 5)
        
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
        
        countTurn()
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func countTurn() {
        self.turn -= 1
        self.result.text = "あと、\(self.turn)ターンです。"
        
        if self.turn == 0 {
            self.result.text = "交換できません。"
            self.changeButton.isEnabled = false
            self.changeButton.setTitleColor(UIColor.gray(), for: .disabled)
        }
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
            let index = cards.index(where: {return $0.number == number})
            cards.remove(at: Int(index!))
            count += 1
        }
        
        if count != 0 {
            let drawCards = self.yamahuda.getRandom(count: count)
            for card in drawCards {
                cards.append(card)
            }
        }
        eCards = cards
    }
    
    func comArrow(cards: [Card]) -> [Int] {
        var numOfRanks = [0,0,0,0,0,0,0,0,0,0,0,0,0]
        for card in cards {
            numOfRanks[card.number - 1] += 1
        }
        var num = [Int]()
        if self.enemyScore > 3 {
            print("何もしない")
        } else if self.enemyScore <= 3 {
            num = self.arrowCard(numOfRanks: numOfRanks)
        }
        return num
    }
    
    private func arrowCard(numOfRanks: [Int]) -> [Int] {
        var num = [Int]()
        var count = 0
        for card in numOfRanks {
            count += 1
            if card == 1 {
                num.append(count)
            }
        }
        return num
    }
    
    @IBAction func reload(_ sender: UIButton) {
        self.view = nil
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ViewController")
        navigationController?.pushViewController(controller, animated: false)
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
        self.cardCollectionView.reloadData()
        countTurn()
        comChange(cards: eCards)
        self.getHand()
        SVProgressHUD.show(withStatus: "CPU思考中...")
        DispatchQueue.main.after(when: .now() + 3) {
            SVProgressHUD.dismiss()
        }
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

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Const.cardMax
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
        guard let type = FieldType(rawValue: indexPath.section) else {
            return cell
        }
        
        cell.cardImage.frame = CGRect(x: 0.0, y: 20.0, width: 50.0, height: 100.0)

        switch type {
        case .CPU:
            
            if flag {
                let name = eCards[indexPath.row].toImageName()
                cell.setImage(card: name)
            } else {
                let card = "r.png"
                cell.setImage(card: card)
            }
        case .Player:
            cell.frame = CGRect(x: cell.frame.minX, y: 390, width: cell.frame.width, height: cell.frame.height)
            let name = cards[indexPath.row].toImageName()
            cell.setImage(card: name)
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if FieldType(rawValue: indexPath.section) == .Player {
            let cell = cardCollectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
            if cell.cardImage.frame.minY == 20.0 {
                cell.cardImage.frame = CGRect(x: cell.cardImage.frame.minX, y: 0, width: cell.cardImage.frame.width, height: cell.cardImage.frame.height)
                cards[indexPath.row].selected = true
            } else {
                cell.cardImage.frame = CGRect(x: cell.cardImage.frame.minX, y: 20, width: cell.cardImage.frame.width, height: cell.cardImage.frame.height)
                cards[indexPath.row].selected = false
            }
        }
    }
}
