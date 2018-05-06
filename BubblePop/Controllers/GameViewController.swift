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
    var gameTime = UserDefaults.standard.integer(forKey: GameTimeSettingKey)
    let realGameTime = UserDefaults.standard.integer(forKey: GameTimeSettingKey)
    var refreshTime = UserDefaults.standard.integer(forKey: RefreshTimeSettingKey)
    let realRefreshTime = UserDefaults.standard.integer(forKey: RefreshTimeSettingKey)
    var reduceRefresh = true
    var playerName = ""
    var score = 0
    var bubbleRadius = UserDefaults.standard.integer(forKey: BubbleSizeSettingKey)
    var maxBubble = UserDefaults.standard.integer(forKey: MaxBubbleSettingKey)
    var currentBubbles: [BubbleImageView] = []
    var lastColor: Bubble = .red
    var safeAreaTop = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gameStart()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParentViewController {
            timer.invalidate()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gameStart() {
        // get save area top edge
        safeAreaTop = Int(TimerLabel.frame.maxY)
        
        HighestScoreLabel.text = "\(getHighestScore())"
        TimerLabel.text = "\(gameTime)"
        TimerLabel.sizeToFit()
        
        // start timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        
        spawnBubbles()
    }
    
    func gameOver() {
        timer.invalidate()
        var table = UserDefaults.standard.dictionary(forKey: HighScoreTableKey) as! [String : Int]
        
        if let oldScore = table[playerName] {
            if oldScore < score {
                table[playerName] = score
            }
        } else {
            table[playerName] = score
        }
        UserDefaults.standard.set(table, forKey: HighScoreTableKey)
        
        performSegue(withIdentifier: "ResultSegue", sender: nil)
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
                reduceRefreshTime()
            }
        } else {
            gameOver()
        }
    }
    
    // remove random bubbles and spawn new bubbles
    func spawnBubbles() {
        if currentBubbles.count > 0 {
            // get random number of bubble that will be removed
            let randomRemove = Int(arc4random_uniform(UInt32(currentBubbles.count + 1)))
            
            for _ in 0..<randomRemove {
                removeRandomBubble()
            }
        }
        
        // get random number of bubble that can be spawned
        let canSpawn = maxBubble - currentBubbles.count
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
        currentBubbles.append(newBubble)
    }
    
    func makeRandomBubble() {
        let randomColor = Int(arc4random_uniform(101))
        var color: Bubble
        var intersect = true
        var randomX = 0
        var randomY = 0
        
        // random bubble colour with probability
        if randomColor <= 40 {
            color = .red
        } else if randomColor <= 70 {
            color = .pink
        } else if randomColor <= 85 {
            color = .green
        } else if randomColor <= 95 {
            color = .blue
        } else {
            color = .black
        }
        
        // get random position to spawn
        while intersect {
            let x = Int(view.bounds.width) - bubbleRadius
            let y = Int(view.bounds.height) - safeAreaTop - bubbleRadius
            randomX = Int(arc4random_uniform(UInt32(x)))
            randomY = Int(arc4random_uniform(UInt32(y))) + safeAreaTop
            let frame = CGRect(x: randomX, y: randomY, width: bubbleRadius, height: bubbleRadius)
            intersect = false
            
            // check if it intersect with other bubbles
            for bubble in currentBubbles {
                if bubble.frame.intersects(frame) {
                    intersect = true
                }
            }
        }
        
        makeBubble(color, x: randomX, y: randomY)
    }
    
    @objc func removeBubble(_ sender: Timer) {
        let bubble = sender.userInfo as! BubbleImageView
        bubble.removeFromSuperview()
        
        // refresh current bubble list
        currentBubbles.removeAll()
        for subview in view.subviews {
            if let view = subview as? BubbleImageView {
                currentBubbles.append(view)
            }
        }
    }
    
    func removeRandomBubble() {
        let randomIndex = Int(arc4random_uniform(UInt32(currentBubbles.count)))
        
        currentBubbles[randomIndex].removeFromSuperview()
        currentBubbles.remove(at: randomIndex)
    }
    
    // tap bubble trigger
    @objc func tapBubble(_ tap: UITapGestureRecognizer) {
        let bubble = tap.view as! BubbleImageView
        
        // count score with combo multiplier
        if score != 0 && lastColor == bubble.color {
            var tempScore = Double(bubble.color.rawValue) * 1.5
            tempScore.round()
            score += Int(tempScore)
        } else {
            score += bubble.color.rawValue
        }
        
        lastColor = bubble.color
        ScoreLabel.text = "\(score)"
        ScoreLabel.sizeToFit()
        bubble.image = UIImage(named: "popBubble.png")
        
        // remove the bubble
        _ = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(removeBubble), userInfo: bubble, repeats: false)
    }
    
    func getHighestScore() -> Int {
        let highScore = UserDefaults.standard.dictionary(forKey: HighScoreTableKey) as? [String : Int]
        if highScore == nil || highScore?.count == 0 {
            return 0
        } else {
            return highScore!.sorted{ $0.1 > $1.1 }.first!.value
        }
    }
    
    // reduce refresh time with relatively to game time
    // the nearer game time to 0 will make it faster to remove and spawn bubble
    // the minimum refresh time is 1
    func reduceRefreshTime() {
        if refreshTime > 1 && reduceRefresh {
            let multiplier = Double(gameTime) / Double(realGameTime)
            var newRefreshTime = Double(realRefreshTime) * multiplier
            newRefreshTime.round()
            refreshTime = Int(newRefreshTime)
            reduceRefresh = false
        } else {
            reduceRefresh = true
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // passing player name to game view controller
        if let result = segue.destination as? ResultViewController {
            result.playerName = playerName
            result.score = score
        }
    }
    

}
