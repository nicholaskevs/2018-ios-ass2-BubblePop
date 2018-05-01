//
//  GameViewController.swift
//  BubblePop
//
//  Created by Nicholas on 1/5/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var HighestScoreLabel: UILabel!
    @IBOutlet weak var bubble: UIImageView!
    
    var timer = Timer()
    var gameTime = 60
    var score = 0
    var highestScore = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gameStart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gameStart() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapBubble))
        bubble.isUserInteractionEnabled = true
        bubble.addGestureRecognizer(singleTap)
        
    }
    
    func gameOver() {
        timer.invalidate()
    }
    
    @objc func countdown() {
        gameTime -= 1
        TimerLabel.text = "\(gameTime)"
        TimerLabel.sizeToFit()
        
        if gameTime == 0 {
            gameOver()
        }
    }
    
    @objc func tapBubble() {
        score += 5
        ScoreLabel.text = "\(score)"
        ScoreLabel.sizeToFit()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
