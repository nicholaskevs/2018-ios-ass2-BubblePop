//
//  ViewController.swift
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let game = segue.destination as? GameViewController {
            game.playerName = playerName.text!
        }
        
    }
    
}

