//
//  ViewController.swift
//  demoTimerProject
//
//  Created by apple on 06/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    //declare timer variable
    var timeCount = 0
    var timer  = Timer()
    
    //timer start working handling
    @IBAction func ActionStartTimer(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.action), userInfo: nil, repeats: true)
    }
    
    
    //timer stop working handling
    @IBAction func ActionStopTimer(_ sender: UIButton) {
        timer.invalidate()
    }
    
    //timer reset working handling
    @IBAction func ActionResetTimer(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you would like to reset the Timer?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (_) in
                    //do nothing
                }))
                
                alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
                    self.timeCount = 0
                    self.timer.invalidate()
                    self.timeLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
                }))
                
                self.present(alert, animated: true, completion: nil)    }
    
    
    //creating action function working
    @objc func action(){
        timeCount += 1
        let time = secondsToHoursMinutesSeconds(seconds: timeCount)
        let timeString = self.makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        
        timeLabel.text = timeString
    }
    
    //make timr to string
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String
        {
            var timeString = ""
            timeString += String(format: "%02d", hours)
            timeString += " : "
            timeString += String(format: "%02d", minutes)
            timeString += " : "
            timeString += String(format: "%02d", seconds)
            return timeString
        }
    
    //
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
        {
            return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

