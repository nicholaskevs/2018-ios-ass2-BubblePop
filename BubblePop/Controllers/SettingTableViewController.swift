//
//  SettingTableViewController.swift
//  BubblePop
//
//  Created by Nicholas on 6/5/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    @IBOutlet weak var GameTimeLabel: UILabel!
    @IBOutlet weak var RefreshTimeLabel: UILabel!
    @IBOutlet weak var BubbleSizeLabel: UILabel!
    @IBOutlet weak var MaxBubbleLabel: UILabel!
    @IBOutlet weak var GameTimeSlider: UISlider!
    @IBOutlet weak var RefreshTimeSlider: UISlider!
    @IBOutlet weak var BubbleSizeSlider: UISlider!
    @IBOutlet weak var MaxBubbleSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // load settings value
        let gameTime = UserDefaults.standard.integer(forKey: GameTimeSettingKey)
        let refreshTime = UserDefaults.standard.integer(forKey: RefreshTimeSettingKey)
        let bubbleSize = UserDefaults.standard.integer(forKey: BubbleSizeSettingKey)
        let maxBubble = UserDefaults.standard.integer(forKey: MaxBubbleSettingKey)
        
        GameTimeLabel.text = "\(gameTime)"
        GameTimeLabel.sizeToFit()
        GameTimeSlider.value = Float(gameTime)
        
        RefreshTimeLabel.text = "\(refreshTime)"
        RefreshTimeLabel.sizeToFit()
        RefreshTimeSlider.value = Float(refreshTime)
        
        BubbleSizeLabel.text = "\(bubbleSize)"
        BubbleSizeLabel.sizeToFit()
        BubbleSizeSlider.value = Float(bubbleSize)
        
        MaxBubbleLabel.text = "\(maxBubble)"
        MaxBubbleLabel.sizeToFit()
        MaxBubbleSlider.value = Float(maxBubble)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // saving edited settings value
        if self.isMovingFromParentViewController {
            UserDefaults.standard.set(Int(GameTimeSlider.value), forKey: GameTimeSettingKey)
            UserDefaults.standard.set(Int(RefreshTimeSlider.value), forKey: RefreshTimeSettingKey)
            UserDefaults.standard.set(Int(BubbleSizeSlider.value), forKey: BubbleSizeSettingKey)
            UserDefaults.standard.set(Int(MaxBubbleSlider.value), forKey: MaxBubbleSettingKey)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gameTimeChanged(_ sender: UISlider) {
        sender.value = Float(Int(sender.value))
        GameTimeLabel.text = "\(Int(sender.value))"
        GameTimeLabel.sizeToFit()
    }
    
    @IBAction func refreshTimeChanged(_ sender: UISlider) {
        sender.value = Float(Int(sender.value))
        RefreshTimeLabel.text = "\(Int(sender.value))"
        RefreshTimeLabel.sizeToFit()
    }
    
    @IBAction func bubbleSizeChanged(_ sender: UISlider) {
        sender.value = Float(Int(sender.value))
        BubbleSizeLabel.text = "\(Int(sender.value))"
        BubbleSizeLabel.sizeToFit()
    }
    
    @IBAction func maxBubbleChanged(_ sender: UISlider) {
        sender.value = Float(Int(sender.value))
        MaxBubbleLabel.text = "\(Int(sender.value))"
        MaxBubbleLabel.sizeToFit()
    }
    
    @IBAction func defaultSettings(_ sender: UIButton) {
        GameTimeLabel.text = "60"
        GameTimeLabel.sizeToFit()
        GameTimeSlider.value = 60.0
        
        RefreshTimeLabel.text = "5"
        RefreshTimeLabel.sizeToFit()
        RefreshTimeSlider.value = 5.0
        
        BubbleSizeLabel.text = "50"
        BubbleSizeLabel.sizeToFit()
        BubbleSizeSlider.value = 50.0
        
        MaxBubbleLabel.text = "15"
        MaxBubbleLabel.sizeToFit()
        MaxBubbleSlider.value = 15.0
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
