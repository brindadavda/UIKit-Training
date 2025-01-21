//
//  ViewController.swift
//  demoVideoPlayer
//
//  Created by apple on 05/01/24.
//

import UIKit
//importing avkit
import AVKit
//importing avfoundation kit
import AVFoundation

class ViewController: UIViewController {
    
    //declare two variable
    var playerController = AVPlayerViewController()
    var player : AVPlayer?
    
    //add video name user define function
    func getVideoName(name: String) -> String{
        return name;
    }

    @IBAction func ActionEventPlayer(_ sender: UIButton) {
        self.present(self.playerController, animated: true )
    }
    
    //Audio Player working
    
    @IBAction func ActionNavToAudioPlayer(_ sender: UIButton) {
        let playerVC : UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "AudioViewController") as! AudioViewController
        
        navigationController?.pushViewController(playerVC, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set path of video
        let videoResource = getVideoName(name: "video (1080p)");
        let videoPath : String? = Bundle.main.path(forResource: videoResource, ofType: ".mp4")!
        
        if let url = videoPath{
            let videoURL  =  NSURL(fileURLWithPath: url)
            self.player = AVPlayer(url: videoURL as URL)
            self.playerController.player = self.player
        }
    }


}

