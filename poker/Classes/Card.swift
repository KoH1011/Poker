//
//  Card.swift
//  poker
//
//  Created by 高橋洸介 on 2016/07/02.
//  Copyright © 2016年 高橋洸介. All rights reserved.
//

enum Mark {
    case heart, dia, clover, spade
    
    func toImageName() -> String {
        switch self {
        case heart:
            return "h"
        case dia:
            return "d"
        case clover:
            return "c"
        case spade:
            return "s"
        }
    }
    
    static func list() -> [Mark] {
        return [.heart, .dia, .clover, .spade]
    }
}

struct Card {
    let mark: Mark
    let number: Int
    
    func toImageName() -> String {
        return self.mark.toImageName() + "\(number).png"
    }
}
