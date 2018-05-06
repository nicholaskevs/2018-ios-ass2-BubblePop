//
//  HomeViewController.swift
//  BubblePop
//
//  Created by Nicholas on 14/4/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var playerName: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        gameSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gameSetup() {
        if UserDefaults.standard.dictionary(forKey: HighScoreTableKey) == nil {
            let highScoreTable: [String : Int] = [:]
            UserDefaults.standard.set(highScoreTable, forKey: HighScoreTableKey)
        }
        
//        print(Array(UserDefaults.standard.dictionaryRepresentation()))
//        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // passing player name to game view controller
        if let game = segue.destination as? GameViewController {
            game.playerName = playerName.text!
        }
    }

    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        
    }

}

