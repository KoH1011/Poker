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
    func pair(ints: [Int]) -> Bool {
        print(ints)
        let f = ints.sorted()
        var flag = false
        var number = 0
        for b in f {
            if b == number {
                flag = true
            }
            number = b
        }
        return flag
    }
}
