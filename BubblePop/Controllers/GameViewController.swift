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
    
    var timer = Timer()
    var gameTime = 60
    var score = 0
    var highestScore = 0
    var playerName = ""

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
        // start timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        
        makeBubble(.blue, image: "blueBubble.png", x: 128, y: 278)
    }
    
    func gameOver() {
        timer.invalidate()
    }
    
    // countdown timer
    @objc func countdown() {
        gameTime -= 1
        TimerLabel.text = "\(gameTime)"
        TimerLabel.sizeToFit()
        
        if gameTime == 0 {
            gameOver()
        }
    }
    
    func makeBubble(_ color: Bubble, image: String, x: Int, y: Int) {
        let newBubble = BubbleImageView(image: UIImage(named: image))
        newBubble.color = color
        newBubble.frame = CGRect(x: x, y: y, width: 50, height: 50)
        newBubble.isUserInteractionEnabled = true
        newBubble.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBubble)))
        view.addSubview(newBubble)
    }
    
    // tap bubble trigger
    @objc func tapBubble(_ tap: UITapGestureRecognizer) {
        let bubble = tap.view as! BubbleImageView
        score += bubble.color.rawValue
        ScoreLabel.text = "\(score)"
        ScoreLabel.sizeToFit()
        bubble.removeFromSuperview()
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
