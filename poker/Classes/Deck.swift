//
//  Deck.swift
//  poker
//
//  Created by 高橋洸介 on 2016/07/02.
//  Copyright © 2016年 高橋洸介. All rights reserved.
//

import UIKit

class Deck {

    static var stock = [Card]()
    
    var cards = [Card]()
    init() {
        for mark in Mark.list() {
            for i in 1...13 {
                self.cards.append(Card(mark: mark, number: i, selected: false))
            }
        }
    }
    
    func getRandom(count: Int) -> [Card] {
        // ランダムで取得
        var hand = [Card]()
        for _ in 1...count {
            // ランダムで取得するときにデッキからではなくて、枚数から取得してるから被ることがある。
            let cardNum = arc4random_uniform(UInt32(self.cards.count))
            hand.append(self.cards[Int(cardNum)])
            
            self.cards.remove(at: Int(cardNum))
        }
        
        Deck.stock = self.cards
        return hand
    }
    
    func changeCard() -> Card {
        let cardNum = arc4random_uniform(UInt32(Deck.stock.count))
        let selectedCard = Deck.stock[Int(cardNum)]
        Deck.stock.remove(at: Int(cardNum))
        
        return selectedCard
    }
}
