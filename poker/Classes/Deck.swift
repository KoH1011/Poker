//
//  Deck.swift
//  poker
//
//  Created by 高橋洸介 on 2016/07/02.
//  Copyright © 2016年 高橋洸介. All rights reserved.
//

import UIKit

class Deck {
    
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
        var tehuda = [Card]()
        for _ in 1...count {
            let cardNum = arc4random_uniform(UInt32(self.cards.count))
            tehuda.append(self.cards[Int(cardNum)])
        }
        return tehuda
    }
    
    func changeCard() -> Card {
        let cardNum = arc4random_uniform(UInt32(self.cards.count))
        return self.cards[Int(cardNum)]
    }
}
