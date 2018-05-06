//
//  BubbleData.swift
//  BubblePop
//
//  Created by Nicholas on 5/5/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

let HighScoreTableKey = "highScoreTable"
let GameTimeSettingKey = "gameTimeSetting"
let MaxBubbleSettingKey = "maxBubbleSetting"

enum Bubble: Int {
    case red = 1
    case pink = 2
    case green = 5
    case blue = 8
    case black = 10
    
    var image: String {
        switch self {
        case .red:
            return "redBubble.png"
        case .pink:
            return "pinkBubble.png"
        case .green:
            return "greenBubble.png"
        case .blue:
            return "blueBubble.png"
        case .black:
            return "blackBubble.png"
        }
    }
}
