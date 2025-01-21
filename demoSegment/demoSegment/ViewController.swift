//
//  ViewController.swift
//  demoSegment
//
//  Created by apple on 03/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    //creating bgcolor variable
    var bgColor : UIColor? = .white
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        //set the color get from SrcondViewController
        view.backgroundColor = bgColor
            
        // Do any additional setup after loading the view.
        progressView.progress = 0.0
        
        //changing style of progressView
        //increase width
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 5)
        
        //add corner radius in progress bar
        progressView.layer.cornerRadius = 30
        progressView.clipsToBounds = true
        
        //action sheet btn visibility
        ActionsheetBtn.isHidden = true
        ActionSheetCancleBtn.isHidden = true
        
        //alert btn visibility
        AlertBtn.isHidden = true
        AlertShowBtn.isHidden = true
        AlertInputBtn.isHidden = true
        AlertShowImageBtn.isHidden = true
        AlertShowMessageBtn.isHidden = true
        
        checkorderofDipatchQueue()
    }
    
    func checkorderofDipatchQueue(){
        print("print 1")
        DispatchQueue.main.async {
            print("print 3")
            DispatchQueue.global(qos: .background).async {
                print("print 4")
            }
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            print("print 5")
            DispatchQueue.global(qos: .background).async {
                print("print 8")
            }
        }
        
        DispatchQueue.global(qos: .default).async {
            DispatchQueue.global(qos: .background).async {
                print("print 7")
            }
            print("print 6")
        }
        
        DispatchQueue.global(qos: .background).async {
            print("print 9")
        }
        
        print("print 2")
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
    
       if(sender.selectedSegmentIndex == 0){
            view.backgroundColor = UIColor.white
            label.text = "first page"
            ActionsheetBtn.isHidden = true
           ActionSheetCancleBtn.isHidden = true
           //alert btn
           AlertBtn.isHidden = true
           AlertShowBtn.isHidden = true
           AlertInputBtn.isHidden = true
           AlertShowImageBtn.isHidden = true
           AlertShowMessageBtn.isHidden = true
        }
        
        if(sender.selectedSegmentIndex == 1){
            view.backgroundColor = UIColor.yellow
            label.text = "second page"
            label.textColor = UIColor.blue
            
            //action sheet btn
            ActionsheetBtn.isHidden = false
            ActionSheetCancleBtn.isHidden = false
            
            //alert btn
            AlertBtn.isHidden = true
            AlertShowBtn.isHidden = true
            AlertInputBtn.isHidden = true
            AlertShowImageBtn.isHidden = true
            AlertShowMessageBtn.isHidden = true
        }
        
        
        if(sender.selectedSegmentIndex == 2){
            view.backgroundColor = UIColor.green
            label.text = "third page"
            ActionsheetBtn.isHidden = true
            ActionSheetCancleBtn.isHidden = true
            //alert btn
            AlertBtn.isHidden = false
            AlertShowBtn.isHidden = false
            AlertInputBtn.isHidden = false
            AlertShowImageBtn.isHidden = false
            AlertShowMessageBtn.isHidden = false
            
        }
        
        if(sender.selectedSegmentIndex == 3){
            view.backgroundColor = UIColor.purple
            label.text = "forth page"
            ActionsheetBtn.isHidden = true
            ActionSheetCancleBtn.isHidden = true
            //alert btn
            AlertBtn.isHidden = true
            AlertShowBtn.isHidden = true
            AlertInputBtn.isHidden = true
            AlertShowImageBtn.isHidden = true
            AlertShowMessageBtn.isHidden = true
        }
    }
    
    var isRed = false
    var progressBarTimer : Timer!
    var isRunning = false
    
    /* ------- second sagment action sheetwork start ------ */
    
    //action sheet normal work
    @IBOutlet weak var ActionsheetBtn: UIButton!
    //action sheet normal button click
    @IBAction func ActionSheetNormalBtn(_ sender: UIButton){
        
        //create alertController varible
        let alertController = UIAlertController(title: "Alert Demo", message: "Action sheet normal", preferredStyle: .actionSheet)
        
        //generate action options
        let action1 = UIAlertAction(title: "option1", style: .default , handler: {
            (alert : UIAlertAction) -> Void in
            self.label.text = "option 1 selected"
        })
        
        let action2 = UIAlertAction(title: "option2", style: .default , handler: {
            (alert : UIAlertAction) -> Void in
            self.label.text = "option 2 selected"
        })
        
        //add some design of action options
        action1.setValue(UIColor.purple, forKey: "titleTextColor")
        action2.setValue(UIColor.red, forKey: "titleTextColor")
        
        
        //set this option to alertController
        alertController.addAction(action1)
        alertController.addAction(action2)
        
        self.present(alertController, animated: true)
    }
    
    //action sheet cancle work
    @IBOutlet weak var ActionSheetCancleBtn: UIButton!
    //action sheet cancle button click
    @IBAction func ActionSheetCancle(_ sender: UIButton) {
        
        //create alertController varible
        let alertController = UIAlertController(title: "Alert Demo", message: "Action sheet normal", preferredStyle: .actionSheet)
        
        //generate action options
        let action1 = UIAlertAction(title: "destructive option ", style: .destructive , handler: {
            (alert : UIAlertAction) -> Void in
            self.label.text = "destructive selected"
        })
        
        let action2 = UIAlertAction(title: "cancle option", style: .cancel , handler: {
            (alert : UIAlertAction) -> Void in
            self.label.text = "cancle selected"
        })
        
        let action3 = UIAlertAction(title: "default option", style: .destructive , handler: {
            (alert : UIAlertAction) -> Void in
            self.label.text = "default selected"
        })
        //add some design of action options
        action1.setValue(UIColor.purple, forKey: "titleTextColor")
        action2.setValue(UIColor.red, forKey: "titleTextColor")
        action3.setValue(UIColor.lightGray, forKey: "titleTextColor")
        
        //set this option to alertController
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        
        self.present(alertController, animated: true)    }
    
    /* ------- second sagment action sheetwork end ------ */
    
    
    /* ------- third sagment alert work start ------ */
    
    //alert action button work
    @IBOutlet weak var AlertBtn: UIButton!
    //alert action button click
    @IBAction func ActionAlert1(_ sender: UIButton) {
        //do some work
        let alertController = UIAlertController(title: "Title", message: "Simple alert demo", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "Ok", style: .default)
        
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true)
    }
    
    //alert action show button work
    @IBOutlet weak var AlertShowBtn: UIButton!
    //alert action show button click
    @IBAction func ActionAlertShow(_ sender: UIButton) {
        //do something
        let alertController = UIAlertController(title: "Title", message: "Simple alert show demo", preferredStyle: .alert)
        
        let okOptionAction = UIAlertAction(title: "Ok", style: .default){(action : UIAlertAction)->Void in
            //alertController.dismiss(animated: true)
        }
        
        let cancleOptionAction = UIAlertAction(title: "Cancle", style: .cancel){(action : UIAlertAction)->Void in
            //alertController.dismiss(animated: true)
        }
        
        let deleteOptionAction = UIAlertAction(title: "Delete", style: .destructive){(action : UIAlertAction)->Void in
            //alertController.dismiss(animated: true)
        }
        
        alertController.addAction(okOptionAction)
        alertController.addAction(cancleOptionAction)
        alertController.addAction(deleteOptionAction)
        
        self.present(alertController, animated: true)
    }
    
    //alert action input button work
    @IBOutlet weak var AlertInputBtn: UIButton!
    //alert action inout button click
    @IBAction func ActionAlertInput(_ sender: UIButton) {
        //creating alert controller
        let alertController = UIAlertController(title: nil, message: "Login", preferredStyle: .alert)
        
        //adding some textfiled in alert controller
        alertController.addTextField{
            textField -> Void in
            textField.placeholder = "UserName"
            textField.textColor = .darkGray
        }
        
        alertController.addTextField{
            textField -> Void in
            textField.placeholder = "Password"
            textField.textColor = .blue
            textField.isSecureTextEntry = true
        }
        
        //create cancle action
        let action1 = UIAlertAction(title: "Cancle", style: .cancel)
        
        //set the action to alert controller
        alertController.addAction(action1)
        
        self.present(alertController, animated : true)
    }
    
    //alert action show message work
    @IBOutlet weak var AlertShowMessageBtn: UIButton!
    //alert action for show message btn click
    @IBAction func ActionAlertMessageShow(_ sender: UIButton) {
        let application : UIApplication = UIApplication.shared
        
        let alertContoller = UIAlertController(title: nil, message: "Alert Demo For Message show", preferredStyle: .alert)
        
        let callAction = UIAlertAction(title: "Call", style: .default , handler:{ (action)->Void in
            let PhoneNumber : String = "tel:/1234567891";
            application.open(URL(string: PhoneNumber)!)
        })
        
        let messageAction = UIAlertAction(title: "Message", style: .default , handler:{ (action)->Void in
            let Message : String = "sms:1234567891";
            application.open(URL(string: Message)!)
        })
        
        let mapAction = UIAlertAction(title: "Map", style: .destructive , handler: {(action)-> Void in
            let targetURL = URL(string: "https://www.youtube.com/watch?v=QlwKcn1kOpE&list=PLtCBuHKmdxOcmrDx2pM4qNvzWF2NI_Qlo&index=14")!
            application.open(targetURL)
        })
        
        alertContoller.addAction(callAction)
        alertContoller.addAction(messageAction)
        alertContoller.addAction(mapAction)
        
        self.present(alertContoller, animated: true)
    }
    
    //alert show image btn work
    @IBOutlet weak var AlertShowImageBtn: UIButton!
    //alert show image btn click
    @IBAction func ActionAlertShowImage(_ sender: UIButton) {
        let alertContoller = UIAlertController(title: nil, message: "Alert Demo For Image show", preferredStyle: .alert)
        
        let imageAction = UIAlertAction(title: "Image", style: .default , handler: {(action)->Void in
            UIApplication.shared.open(URL(string: "https://en.wikipedia.org/wiki/Image")!)
        })
        
        imageAction.setValue(UIImage(named: "logo")?.withRenderingMode(.alwaysOriginal), forKey: "Image")
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alertContoller.addAction(imageAction)
        alertContoller.addAction(okAction)
        
        self.present(alertContoller, animated: true)
    }
    
    /* ------- third segment alert  work end ------- */
    
    
    //adding progress action
    @IBAction func progressAction(_ sender: UIButton) {
        if(isRunning){
            progressBarTimer.invalidate();
            button.setTitle("start", for: .normal)
        }else{
            button.setTitle("stop", for: .normal)
            progressView.progress = 0.0
            self.progressBarTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
            
            if(isRed){
                progressView.progressTintColor = .blue
                progressView.progressViewStyle = .default
                
                //when progressbar move in round shape
                progressView.layer.sublayers![1].cornerRadius = 10
                progressView.subviews[1].clipsToBounds = true
                
            }else{
                progressView.progressTintColor = .red
                progressView.progressViewStyle = .bar
                
                //when progressbar move in not round shape
                progressView.layer.sublayers![1].cornerRadius = 0
                progressView.subviews[1].clipsToBounds = false
                
            }
            
            isRed = !isRed
        }
        isRunning = !isRunning
    }
    
    //update progress view
    @objc func updateProgressView(){
        //do something in this function
        progressView.progress += 0.2;        progressView.setProgress(progressView.progress, animated: true)
        
        //condition for invalid timer
        if(progressView.progress == 1){
            progressBarTimer.invalidate()
            isRunning = false
            button.setTitle("Start", for: .normal)
        }
        
    }
    
    //indicator work
    var isIndRunning = true;
    
    @IBOutlet weak var ActionIndicatorBtn: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    //start indicatore button
    @IBAction func ActionIndicatore(_ sender: UIButton) {
        if(isIndRunning){
            indicator.stopAnimating()
            ActionIndicatorBtn.setTitle("Start Indicator", for: .normal)
            
            isIndRunning = false
            
        }else{
            indicator.startAnimating()
            ActionIndicatorBtn.setTitle("Stop Indicator", for: .normal)
            
            isIndRunning = true
            
        }
        
    }
    
  
    
    //Navigation working
    @IBAction func ActionNavigateSecondVIew(_ sender: UIButton) {
        
        let secondViewCOntroller : UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController)!
        
        self.navigationController?.pushViewController(secondViewCOntroller, animated: true)
        
        //performSegue(withIdentifier: "SecondViewController", sender: self)
    }
    
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SecondViewController"{
            let vc = segue.destination as! SecondViewController
            
        }
    }*/
}

