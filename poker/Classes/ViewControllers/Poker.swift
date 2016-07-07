//
//  Poker.swift
//  poker
//
//  Created by 高橋洸介 on 2016/07/03.
//  Copyright © 2016年 高橋洸介. All rights reserved.
//
import UIKit

enum Role: String {
    case buta = "ブタ"
    case onePair = "ワンペア"
    case twoPair = "ツーペア"
    case threeCard = "スリーカード"
    case straight = "ストレート"
    case flash = "フラッシュ"
    case fullHouse = "フルハウス"
    case fourCard = "フォーカード"
    case straightFlash = "ストレートフラッシュ"
    case royalStraightFlash = "ロイヤルストレートフラッシュ"
}

class hantei {
    class func getScore(cards: [Card]) -> String {
        // 各ランクがそれぞれ何枚あるかをnumOfRanksに保存
        var numOfRanks = [0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        for card in cards {
            numOfRanks[card.number] += 1
        }
        var yaku = ""
        print("-----------------------------------------")
        print(numOfRanks)
//         ROYAL_STRAIGHT_FLUSH
        if isStraight(cards: cards, numOfRanks: numOfRanks) && isFlush(cards: cards) && numOfRanks[10] == 1 && numOfRanks[1] == 1 {
            return Role.royalStraightFlash.rawValue
        }
        // STRAIGHT_FLUSH
        if isStraight(cards: cards, numOfRanks: numOfRanks) && isFlush(cards: cards) {
            return Role.straightFlash.rawValue
        }
        // FOUR_OF_A_KIND
        if numOfRanks.index(of: 4) != nil {
            return Role.fourCard.rawValue
        }
        // FULL_HOUSE
        if numOfRanks.index(of: 3) != nil && numOfRanks.index(of: 2) != nil {
            return Role.fullHouse.rawValue
        }
        // FLUSH
        if isFlush(cards: cards) {
            return Role.flash.rawValue
        }
        // STRAIGHT
        if isStraight(cards: cards, numOfRanks: numOfRanks) {
            return Role.straight.rawValue
        }
        // THREE_OF_A_KIND
        if numOfRanks.index(of: 3) != nil {
            return Role.threeCard.rawValue
        }
        // TWO_PAIR
        if numOfRanks.filter({$0 == 2}).count == 2 {
            yaku = Role.twoPair.rawValue
            return yaku
        }
        // ONE_PAIR
        if numOfRanks.index(of: 2) != nil {
            return Role.onePair.rawValue
        }
        
        if yaku == "" {
            return "ブタ"
        }
        return yaku
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
