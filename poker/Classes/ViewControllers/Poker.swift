//
//  Poker.swift
//  poker
//
//  Created by 高橋洸介 on 2016/07/03.
//  Copyright © 2016年 高橋洸介. All rights reserved.
//
import UIKit

enum Role: String {
    case buta
    case onePair
    case twoPair
    case threeCard
    case straight
    case flash
    case fullHouse
    case fourCard
    case straightFlash
    case royalStraightFlash
    
    var name : String {
        switch self {
        case .buta:
            return "ぶた"
        case .onePair:
            return "ワンペア"
        case .twoPair:
            return "ツーペア"
        case .threeCard:
            return "スリーカード"
        case .straight:
            return "ストレート"
        case .flash:
            return "フラッシュ"
        case .fullHouse:
            return "フルハウス"
        case .fourCard:
            return "フォーカード"
        case .straightFlash:
            return "ストレートフラッシュ"
        case .royalStraightFlash:
            return "ロイヤルストレートフラッシュ"
        }
    }
    
    var score : Int {
        switch self {
        case .buta:
            return 0
        case .onePair:
            return 1
        case .twoPair:
            return 2
        case .threeCard:
            return 3
        case .straight:
            return 4
        case .flash:
            return 5
        case .fullHouse:
            return 6
        case .fourCard:
            return 7
        case .straightFlash:
            return 8
        case .royalStraightFlash:
            return 9
        }
    }
}

class judge {
    class func role(cards: [Card]) -> (String, Int) {
        // 各ランクがそれぞれ何枚あるかをnumOfRanksに保存
        var numOfRanks = [0,0,0,0,0,0,0,0,0,0,0,0,0]
        for card in cards {
            numOfRanks[card.number - 1] += 1
        }
        // ROYAL_STRAIGHT_FLUSH
        if isStraight(cards: cards, numOfRanks: numOfRanks) && isFlush(cards: cards) && numOfRanks[10] == 1 && numOfRanks[1] == 1 {
            return (Role.royalStraightFlash.name, Role.royalStraightFlash.score)
            
        }
        // STRAIGHT_FLUSH
        if isStraight(cards: cards, numOfRanks: numOfRanks) && isFlush(cards: cards) {
            return (Role.straightFlash.name, Role.straightFlash.score)
        }
        // FOUR_OF_A_KIND
        if numOfRanks.index(of: 4) != nil {
            return (Role.fourCard.name, Role.fourCard.score)
        }
        // FULL_HOUSE
        if numOfRanks.index(of: 3) != nil && numOfRanks.index(of: 2) != nil {
            return (Role.fullHouse.name, Role.fullHouse.score)
        }
        // FLUSH
        if isFlush(cards: cards) {
            return (Role.flash.name, Role.flash.score)
        }
        // STRAIGHT
        if isStraight(cards: cards, numOfRanks: numOfRanks) {
            return (Role.straight.name, Role.straight.score)
        }
        // THREE_OF_A_KIND
        if numOfRanks.index(of: 3) != nil {
            return (Role.threeCard.name, Role.threeCard.score)
        }
        // TWO_PAIR
        if numOfRanks.filter({$0 == 2}).count == 2 {
            return (Role.twoPair.name, Role.twoPair.score)
        }
        // ONE_PAIR
        if numOfRanks.index(of: 2) != nil {
            return (Role.onePair.name, Role.onePair.score)
        } else {
        // BUTA
            return (Role.buta.name, Role.buta.score)
        }
    }
    
    private class func isStraight(cards: [Card], numOfRanks: [Int]) -> Bool {
        var isStraight = false
        for i in 1 ..< 13 {
            if (numOfRanks + numOfRanks[1 ... 5-1])[i ..< i+5].reduce(true, combine: { $0 && $1 == 1 }) {
                isStraight = true
                break
            }
        }
        return isStraight
    }
    
    // FLUSHの判定
    private class func isFlush(cards: [Card]) -> Bool {
        var isFlush = true
        for i in 1 ..< 13 {
            isFlush = isFlush && cards[i-1].mark == cards[i].mark
        }
        return isFlush
    }
}
