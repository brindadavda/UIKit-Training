//
//  TodoViewController.swift
//  demoAutoLayout
//
//  Created by apple on 23/01/24.
//
import UIKit

class TodoViewController: UIViewController{
    
    @IBOutlet weak var tabelView: UITableView!
    
    var todos : [todo] = []
    
    let reusableIdentifier = "Cell"
    
    @IBOutlet weak var bottomCon: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // seting up the delegate and datasource to table view
        tabelView.delegate = self   
        tabelView.dataSource = self
        
        let view = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 45))
        
        //style the view
        view.text = "Todo App"
        view.textColor = .systemMint
        view.textAlignment = .center
        view.font = .monospacedSystemFont(ofSize: 35, weight: .bold)
        
        self.navigationController?.navigationBar.addSubview(view)
    
        
        //keyboard working
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let inset = view.safeAreaInsets.bottom + keyboardFrame.height

        bottomCon.constant = -inset
    
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        bottomCon.constant = 0
    }

    var images : [String]! = []
    
    func addTodoOnTableView(titleLabel : UITextField, descriptionLabel : UITextField){
        if titleLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && descriptionLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
            //creating structure instance
            var todo1 = todo()
            //passing the value in that instance
            todo1.title = titleLabel.text
            todo1.discription = descriptionLabel.text
            
            //add that instance in array
            todos.append(todo1)
            
            //get the image
            let img:String = getRandomeImage()
            
            //add the image to images arrya
            images.append(img)
            
            //clear the text field
            titleLabel.text = ""
            descriptionLabel.text = ""
            
            //reload the tableview
            tabelView.reloadData()
        }else{
            //creating alert controller
            let alertController = UIAlertController(title: "Empty Details", message: "Please provide the Title and Discription", preferredStyle: .alert)
            
            //creating ok alert option
            let okAlertOption = UIAlertAction(title: "Ok", style: .default)
            
            //set the ok alert option to alert controller
            alertController.addAction(okAlertOption)
            
            //presenting alert
            self.present(alertController, animated: true)
        }
    }


}

//generate randome images
fileprivate func getRandomeImage() -> String{
    
    let imgNameIndex = Int.random(in: 10...121)
    
    return String(imgNameIndex)
}


extension TodoViewController : CustomFooterViewDelegate {
    
    func didTapAddTodoBtn(title: UITextField, description: UITextField) {
        addTodoOnTableView(titleLabel: title, descriptionLabel: description)
    }
}



