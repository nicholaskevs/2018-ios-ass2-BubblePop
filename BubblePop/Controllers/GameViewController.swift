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
    var refreshTime = 5
    var score = 0
    var highestScore = 0
    var playerName = ""
    var bubbleRadius = 50
    var maxBubble = 15
    var currentBubble: [BubbleImageView] = []
    var safeAreaTop = 0

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
        // get save area top edge
        safeAreaTop = Int(TimerLabel.frame.maxY)
        
        // start timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        
        spawnBubbles()
    }
    
    func gameOver() {
        timer.invalidate()
    }
    
    // countdown timer
    @objc func countdown() {
        if gameTime > 0 {
            gameTime -= 1
            TimerLabel.text = "\(gameTime)"
            TimerLabel.sizeToFit()
            
            // remove and spawn bubbles every refreshTime second
            if gameTime > 0 && gameTime % refreshTime == 0 {
                spawnBubbles()
            }
        } else {
            gameOver()
        }
    }
    
    // refresh and get current showing bubbles into array
    func getBubbles() {
        currentBubble.removeAll()
        for subview in view.subviews {
            if let bubble = subview as? BubbleImageView {
                currentBubble.append(bubble)
            }
        }
    }
    
    // remove random bubbles and spawn new bubbles
    func spawnBubbles() {
        if currentBubble.count > 0 {
            // get random number of bubble that will be removed
            let randomRemove = Int(arc4random_uniform(UInt32(currentBubble.count + 1)))
            
            for _ in 0..<randomRemove {
                removeRandomBubble()
            }
        }
        
        // get random number of bubble that can be spawned
        let canSpawn = maxBubble - currentBubble.count
        let randomSpawn = Int(arc4random_uniform(UInt32(canSpawn + 1)))
        
        for _ in 0..<randomSpawn {
            makeRandomBubble()
        }
        
    }
    
    func makeBubble(_ color: Bubble, x: Int, y: Int) {
        let newBubble = BubbleImageView(image: UIImage(named: color.image))
        newBubble.color = color
        newBubble.frame = CGRect(x: x, y: y, width: bubbleRadius, height: bubbleRadius)
        newBubble.isUserInteractionEnabled = true
        newBubble.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBubble)))
        
        view.addSubview(newBubble)
        currentBubble.append(newBubble)
    }
    
    func makeRandomBubble() {
        let randomColor = Int(arc4random_uniform(101))
        var color: Bubble
        
        // random bubble colour with probability
        if randomColor <= 40 {
            color = .blue
        } else if randomColor <= 70 {
            color = .blue
        } else if randomColor <= 85 {
            color = .pink
        } else if randomColor <= 95 {
            color = .pink
        } else {
            color = .pink
        }
        
        // get random position to spawn
        let x = Int(view.bounds.width) - bubbleRadius
        let y = Int(view.bounds.height) - safeAreaTop - bubbleRadius
        let randomX = Int(arc4random_uniform(UInt32(x)))
        let randomY = Int(arc4random_uniform(UInt32(y))) + safeAreaTop
        
//        makeBubble(color, x: 128, y: 278)
        makeBubble(color, x: randomX, y: randomY)
    }
    
    func removeRandomBubble() {
        let randomIndex = Int(arc4random_uniform(UInt32(currentBubble.count)))
        
        currentBubble[randomIndex].removeFromSuperview()
        currentBubble.remove(at: randomIndex)
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
