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
import BaltoSDK

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
    
    var playerCardsImage = [String]()
    var playerCards = [Card]()
    var playerScore = 0
    var playerRole = ""
    var cpuCardsImage = [String]()
    var cpuCards = [Card]()
    var cpuRole = ""
    var cpuScore = 0
    
    var flag = false
    var turn = 6
    let stock = Deck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // FeedBackツールです
        Balto.show()
        
        self.cardCollectionView.allowsMultipleSelection = true
        let hand = self.stock.getRandom(count: 5)
        let cpuHand = self.stock.getRandom(count: 5)
        
        for card in hand {
            let cardImage = Card.toImageName(card)()
            playerCards.append(card)
            playerCardsImage.append(cardImage)
        }
        
        for cpuCard in cpuHand {
            
            let eCardImage = Card.toImageName(cpuCard)()
            cpuCards.append(cpuCard)
            cpuCardsImage.append(eCardImage)
        }
        self.getRole()
        
        countTurn()
        
        self.changeButton.isEnabled = false
        self.changeButton.setTitleColor(UIColor.gray, for: .disabled)
        
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
            self.result.text = "ターン終了です。"
            self.changeButton.isEnabled = false
            self.changeButton.setTitleColor(UIColor.gray, for: .disabled)
        }
    }
    
    func getRole() {
        
        let playerData = judge.role(cards: playerCards)
        self.playerRole = playerData.0
        self.playerScore = playerData.1
        self.label.text =  "playerの手役は\(playerData.0)です。"
        
        let cpuHand = judge.role(cards: cpuCards)
        self.cpuRole = cpuHand.0
        self.cpuScore = cpuHand.1
    }
    
    func cpuChange(cards: [Card]) {
        
        var cards = cards
        let arrowCards = self.cpuArrow(cards: cards)
        var count = 0
        
        for number in arrowCards {
            let index = cards.index(where: {return $0.number == number})
            cards.remove(at: Int(index!))
            count += 1
        }
        
        if count != 0 {
            let drawCards = self.stock.getRandom(count: count)
            for card in drawCards {
                cards.append(card)
            }
        }
        cpuCards = cards
    }
    
    func cpuArrow(cards: [Card]) -> [Int] {
        
        var numOfRanks = [0,0,0,0,0,0,0,0,0,0,0,0,0]
        for card in cards {
            numOfRanks[card.number - 1] += 1
        }
        
        var num = [Int]()
        
        if self.cpuScore <= 3 {
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
        for card in playerCards {
            if card.selected == true {
                let changeCard = Deck().changeCard()
                playerCards[count] = changeCard
            }
            count += 1
        }
        self.cardCollectionView.reloadData()
        countTurn()
        cpuChange(cards: cpuCards)
        self.getRole()
        SVProgressHUD.show(withStatus: "CPU思考中...")
            SVProgressHUD.dismiss()
        
    }
    
    @IBAction func battle(_ sender: UIButton) {
        
        self.flag = true
        self.cardCollectionView.reloadData()
        
        self.eLabel.text = "相手の手役は\(self.cpuRole)です。"
        
        if self.playerScore > self.cpuScore {
            self.result.text = "player Win"
        } else if self.playerScore < self.cpuScore {
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
                let name = cpuCards[indexPath.row].toImageName()
                cell.setImage(card: name)
            } else {
                let card = "r.png"
                cell.setImage(card: card)
            }
        case .Player:
            cell.frame = CGRect(x: cell.frame.minX, y: 390, width: cell.frame.width, height: cell.frame.height)
            let name = playerCards[indexPath.row].toImageName()
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
                playerCards[indexPath.row].selected = true
                
                self.changeButton.isEnabled = true
                self.changeButton.setTitleColor(UIColor.white, for: .disabled)
            } else {
                cell.cardImage.frame = CGRect(x: cell.cardImage.frame.minX, y: 20, width: cell.cardImage.frame.width, height: cell.cardImage.frame.height)
                playerCards[indexPath.row].selected = false
            }
        }
    }
}
