//
//  AudioViewController.swift
//  demoVideoPlayer
//
//  Created by apple on 06/01/24.
//

import UIKit
import AVFAudio

class AudioViewController: UIViewController {

    @IBOutlet weak var PlayPauseBtn: UIButton!
    
    @IBOutlet weak var RestartBtn: UIButton!
    
    //get and set the audio path value
    var audioFileName : String?
    var player = AVAudioPlayer()
    
    //audio player play button work
    @IBAction func ActionPlay(_ sender: UIButton) {
        //put your logic here
        if(PlayPauseBtn.isSelected){
            player.pause()
            PlayPauseBtn.isSelected = false
        }else{
            player.play()
            PlayPauseBtn.isSelected = true
        }
    }
    
    //audio player restart button work
    @IBAction func Restart(_ sender: UIButton) {
        //put your restart logic here
        player.currentTime = 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        audioFileName = "sample_audio"
        
        do{
            let audioPath = Bundle.main.path(forResource: audioFileName, ofType: ".mp3")
            
            let audioNSURL : URL = NSURL(fileURLWithPath: audioPath!) as URL
            
            //creating AVplayer variable
            try player = AVAudioPlayer(contentsOf: audioNSURL)
        }catch{
            //handle error
        }
    }
    
}
