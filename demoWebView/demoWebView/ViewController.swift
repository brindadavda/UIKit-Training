//
//  ViewController.swift
//  demoWebView
//
//  Created by apple on 05/01/24.
//

import UIKit

//importing map kit
import MapKit

class ViewController: UIViewController {

    //@IBOutlet weak var WebView: UIWebView!
    
    @IBOutlet weak var MapView: MKMapView!
    
    @IBOutlet weak var NextScreenBtn: UIButton!
    
    
    //button action
    @IBAction func ActionToMoveNextScreen(_ sender: UIButton) {
        
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
   
    
    //view load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /* WebView.loadRequest(URLRequest(url: URL(string: "https://stackoverflow.com/questions/42462202/deleting-specific-substrings-in-strings-swift")!)) */
        
        let lattitude : CLLocationDegrees = 22.303894
        let longitude : CLLocationDegrees = 70.802162
        let latDelta : CLLocationDegrees = 0.01
        let lonDelta : CLLocationDegrees = 0.01
        
        //location variable
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(lattitude, longitude)
        
        //delta set in span variable
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        //set both location and span in regin variable
        let region : MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        
        self.MapView.setRegion(region, animated: true)
        
        //set annotation in mapview
        let annotation : MKPointAnnotation = MKPointAnnotation()
        
        annotation.coordinate = location
        annotation.title = "Me"
        annotation.subtitle = "My Location"
        
        //set annoatation
        self.MapView.addAnnotation(annotation)
        
    }


}

