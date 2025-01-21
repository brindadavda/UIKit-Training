import UIKit
import AVKit
import AVFoundation
import SystemConfiguration.CaptiveNetwork

class ViewController: UIViewController {

    @IBOutlet weak var airPlayButton: UIButton!
    var player: AVPlayer?
    var playerViewController: AVPlayerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAirPlayButton()
       //setupVideoPlayer()
        observeAirPlayStatus()
        print( getWiFiSsid())
    }

    func setupAirPlayButton() {
        let airPlayButton = AVRoutePickerView()
        airPlayButton.activeTintColor = .blue
        airPlayButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(airPlayButton)

        NSLayoutConstraint.activate([
            airPlayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            airPlayButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            airPlayButton.widthAnchor.constraint(equalToConstant: 40),
            airPlayButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setupVideoPlayer() {
        guard let url = URL(string: "https://www.w3schools.com/html/mov_bbb.mp4") else { return }
        player = AVPlayer(url: url)
        playerViewController = AVPlayerViewController()
        playerViewController?.player = player

        // Present the player view controller
        if let playerViewController = playerViewController {
            playerViewController.view.frame = view.bounds
            view.addSubview(playerViewController.view)
            //addChild(playerViewController)
        }

        // Start playing the video
        player?.play()
    }

    func observeAirPlayStatus() {
        NotificationCenter.default.addObserver(self, selector: #selector(routeChanged), name: AVAudioSession.routeChangeNotification, object: nil)
    }

    @objc func routeChanged(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
              let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue) else { return }

        switch reason {
        case .oldDeviceUnavailable:
            print("AirPlay device disconnected.")
        case .newDeviceAvailable:
            print("AirPlay device connected.")
        default:
            break
        }
    }
    

}
