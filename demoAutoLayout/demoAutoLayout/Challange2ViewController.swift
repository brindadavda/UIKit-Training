//
//  Challange2ViewController.swift
//  demoAutoLayout
//
//  Created by apple on 20/01/24.
//

import UIKit

class Challange2ViewController: UIViewController {

    @IBOutlet weak var bookIV : UIImageView!
    
    @IBOutlet weak var bookTitleLabel : UILabel!
    
    @IBOutlet weak var publicationDateLabel : UILabel!
    
    @IBOutlet weak var pagesLabel : UILabel!
    
    @IBOutlet weak var leadAuthorLabel : UILabel!
    
    @IBOutlet weak var finalPassEditorLabel : UILabel!
    
    
    @IBAction func actionEnglish(_ sender : UIButton){
        //change the language of all label in English
        print(#function)
    }
    
    @IBAction func actionSpenish(_ sender : UIButton){
        //change the language of all label in Spanish
        print(#function)
    }
    
    @IBAction func actionGermen(_ sender : UIButton){
        //change the language of all label in Gereman
        print(#function)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Create Date
        let date = Date()

        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date/Time Style
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short

        // Convert Date to String
        

        bookTitleLabel.text =  "Think before speak"
        publicationDateLabel.text = dateFormatter.string(from: date)
        pagesLabel.text = "112"
        leadAuthorLabel.text  = "jorge arthi"
        finalPassEditorLabel.text = "arben boos"
        
        
        
    }
    


}
