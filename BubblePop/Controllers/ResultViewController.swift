//
//  ResultViewController.swift
//  BubblePop
//
//  Created by Nicholas on 6/5/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var PlayerNameLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var HighScoreTableView: UITableView!
    
    var playerName = ""
    var score = 0
    let highScore: [String : Int] = UserDefaults.standard.dictionary(forKey: HighScoreTableKey) as! [String : Int]
    var sorted: [(key: String, value: Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.setHidesBackButton(true, animated: false)
        PlayerNameLabel.text = playerName
        PlayerNameLabel.sizeToFit()
        ScoreLabel.text = "\(score)"
        ScoreLabel.sizeToFit()
        
        sorted = highScore.sorted{ $0.1 > $1.1 }
        
//        for (key, val) in highScore {
//            keys.append(key)
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MiniHighScoreTable", for: indexPath)
        cell.textLabel!.text = sorted[indexPath.row].key
        cell.detailTextLabel!.text = "\(sorted[indexPath.row].value)"
        return cell
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
