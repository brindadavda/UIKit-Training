//
//  ViewController.swift
//  demoDate&Time
//
//  Created by apple on 19/03/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        for _ in 0...30{
            getDate()
        }
        }
        

    
    
   
    func getDate(){
        //let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "DD/MM/YYYY"
        
        //let currentDateString = "yyyy-MM-dd HH:mm:ss"
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: "2016-02-29 12:24:26") {
            print(dateFormatterGet.string(from: date))
        } else {
           print("There was an error decoding the string")
        }
    
    
        
        print("\n")
    }


}

