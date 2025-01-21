//
//  ViewController.swift
//  demoPushNotification
//
//  Created by apple on 17/02/24.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude:21.9612, longitude: 70.7939)
        annotation1.title = "Gondal" // Optional
        annotation1.subtitle = "This is Gondal City" // Optional
        
        self.mapView.addAnnotation(annotation1)

    }
    
    @IBAction func sendNotification(_ sender: UIButton) {
        setInternalMockNotification()
    }
    func setInternalMockNotification(){
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Demo Notification"
        content.sound = .default
        content.userInfo = ["value" : "Data send with localnotifiaction"]
        
        let request = UNNotificationRequest(identifier: "demoNotification", content: content, trigger: nil)
        
        center.add(request){ (error) in
            if error != nil{
                debugPrint(error)
            }
                            
        }
    }


}

