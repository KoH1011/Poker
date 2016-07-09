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
    
    var name : String {
        switch self {
        case .buta:
            return "ぶた"
        default:
            <#code#>
        }
    }
    
    var score : Int {
        switch self {
        case .buta:
            return 0
            
        default:
            <#code#>
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
        let role = ""
        var roleScore = 0
//         ROYAL_STRAIGHT_FLUSH
        if isStraight(cards: cards, numOfRanks: numOfRanks) && isFlush(cards: cards) && numOfRanks[10] == 1 && numOfRanks[1] == 1 {
            roleScore = 10
            return (Role.royalStraightFlash.rawValue, roleScore)
        }
        // STRAIGHT_FLUSH
        if isStraight(cards: cards, numOfRanks: numOfRanks) && isFlush(cards: cards) {
            roleScore = 9
            return (Role.straightFlash.rawValue, roleScore)
        }
        // FOUR_OF_A_KIND
        if numOfRanks.index(of: 4) != nil {
            roleScore = 8
            return (Role.fourCard.rawValue, roleScore)
        }
        // FULL_HOUSE
        if numOfRanks.index(of: 3) != nil && numOfRanks.index(of: 2) != nil {
            roleScore = 7
            return (Role.fullHouse.rawValue, roleScore)
        }
        // FLUSH
        if isFlush(cards: cards) {
            roleScore = 6
            return (Role.flash.rawValue, roleScore)
        }
        // STRAIGHT
        if isStraight(cards: cards, numOfRanks: numOfRanks) {
            roleScore = 5
            return (Role.straight.rawValue, roleScore)
        }
        // THREE_OF_A_KIND
        if numOfRanks.index(of: 3) != nil {
            roleScore = 4
            return (Role.threeCard.rawValue, roleScore)
        }
        // TWO_PAIR
        if numOfRanks.filter({$0 == 2}).count == 2 {
            roleScore = 3
            return (Role.twoPair.rawValue, roleScore)
        }
        // ONE_PAIR
        if numOfRanks.index(of: 2) != nil {
            roleScore = 2
            return (Role.onePair.rawValue, roleScore)
        }
        
        if role == "" {
            roleScore = 1
            return ("ブタ", roleScore)
        }
        return (role, roleScore)
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
