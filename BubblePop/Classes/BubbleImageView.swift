//
//  BubbleImageView.swift
//  BubblePop
//
//  Created by Nicholas on 3/5/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

class BubbleImageView: UIImageView {
    
    var color: Bubbles = Bubbles.red

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // to tap in bubble not outside it
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let center = CGPoint(x: bounds.size.width/2, y: bounds.size.height/2)
        return pow(center.x-point.x, 2) + pow(center.y - point.y, 2) <= pow(bounds.size.width/2, 2)
    }

}
