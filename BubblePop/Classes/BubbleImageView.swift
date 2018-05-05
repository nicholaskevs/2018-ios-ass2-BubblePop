//
//  BubbleImageView.swift
//  BubblePop
//
//  Created by Nicholas on 3/5/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

class BubbleImageView: UIImageView {
    
    var color: Bubble = .red
    var popTime = 5
    var timer = Timer()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(image: UIImage?) {
        super.init(image: image)
        
        // remove bubble after a certain time
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // countdown timer
    @objc func countdown() {
        popTime -= 1
        
        if popTime == 0 {
            timer.invalidate()
            self.removeFromSuperview()
        }
    }
    
    // to not trigger tap outside bubble
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let center = CGPoint(x: bounds.size.width/2, y: bounds.size.height/2)
        return pow(center.x-point.x, 2) + pow(center.y - point.y, 2) <= pow(bounds.size.width/2, 2)
    }

}
