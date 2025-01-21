//
//  SecondViewController.swift
//  demoSegment
//
//  Created by apple on 04/01/24.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var ColorWell: UIColorWell!
    
    //nevigate to first activity
    @IBAction func ActionNavigateToSecoundView(_ sender: UIButton) {
        let ViewControllerActivity  = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
    
        ViewControllerActivity.bgColor = ColorWell.selectedColor ?? UIColor.white
        //set the data
        //ViewControllerActivity.bgColor = ColorWell.selectedColor ?? UIColor.white
        
        self.navigationController?.pushViewController(ViewControllerActivity, animated: true)
        
        //performSegue(withIdentifier: "ViewController", sender: self)
    }
    
    //nevigate to fist view by segue
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewController"{
            //let vc = segue.destination as! ViewController
            //vc.label.backgroundColor =
        }
    }*/
    
    /* ------ Radio button working start ------ */
    
    @IBOutlet weak var ResultLabel: UILabel!
    
    @IBOutlet weak var MaleRadioBtn: UIButton!
    
    @IBOutlet weak var FemaleRadioBtn: UIButton!
    
    @IBAction func ActionRadioBtn1Male(_ sender: UIButton) {
        if sender.tag == 1{
            
            //UIView animation
            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: {
                sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }){(success) in
                sender.isSelected = !sender.isSelected
                UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseInOut, animations: {
                    sender.transform = .identity
                })
            }
            
            MaleRadioBtn.isSelected = true
            FemaleRadioBtn.isSelected = false
            
            ResultLabel.text = "Male Selected!"
        }else if sender.tag == 2{
            MaleRadioBtn.isSelected = false
            FemaleRadioBtn.isSelected = true
            
            ResultLabel.text = "Female Selected!"
            
        }else{
            
            MaleRadioBtn.isSelected = false
            FemaleRadioBtn.isSelected = false
            
            ResultLabel.text = "Not Selected!"
            
        }
    }
    
    /* ------ Radio button working end ------ */
    
    /* ------- Checkbox working start ------ */
    
    
    @IBOutlet weak var RajkotCheckbox: UIButton!
    
    @IBOutlet weak var MorbiCheckbox: UIButton!
    
    @IBAction func ActionCheckboxRajkot(_ sender: UIButton)
    {
        //do something when rajkot selected
        if !RajkotCheckbox.isSelected {
            RajkotCheckbox.isSelected = true
            ResultLabel.text = ResultLabel.text! + "Rajkot "
        }
        else{
            RajkotCheckbox.isSelected = false
            ResultLabel.text = ResultLabel.text?.replacingOccurrences(of: "Rajkot ", with: "")
        }
    }
    
    @IBAction func ActionCheckboxMorbi(_ sender: UIButton) {
        //do something when morbi selected
        if !MorbiCheckbox.isSelected {
            MorbiCheckbox.isSelected = true
            ResultLabel.text = ResultLabel.text! + "Morbi "
        }else{
            MorbiCheckbox.isSelected = false
            ResultLabel.text = ResultLabel.text?.replacingOccurrences(of: "Morbi ", with: "")
        }
    }
    
    
    
    /* ------- Checkbox working end ------ */
    
    //init imageview
    @IBOutlet weak var ImageView: UIImageView!
    
    var img : UIImage = UIImage(named: "backgroundImg") ?? UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ImageView.image = img
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
