//
//  TodoVCTableView.swift
//  demoAutoLayout
//
//  Created by apple on 23/01/24.
//

import UIKit

//identifier for navigate of storyboard for previewTodoVC
let storyBoardIdentifier  = "previewTodoVC"

//adding the table view logic
extension TodoViewController : UITableViewDelegate , UITableViewDataSource {
    
    //return total number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos.count
    }
    
    //return each row in text view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier) as! TodoTableViewCell
        //from the view controller
        let todo1 : todo = self.todos[indexPath.row]
        cell.title.text = todo1.title
        cell.discription.text = todo1.discription
        cell.iv.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    
    //set the height of table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    //adding the swipe gesture from right side or trailling
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //*********** Start DELETE (.destructive = red color) ***********
         let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
             (action, sourceView, completionHandler) in
             // Delete the book and associated records
             self.todos.remove(at: indexPath.row)
             self.images.remove(at: indexPath.row)
             //reload the tableview
             tableView.reloadData()
             // Remove the menu option from the screen
             completionHandler(true)
         }
        //*********** End DELETE (.destructive = red color) ***********
         
         // *********** Start EDIT ***********
         let editAction = UIContextualAction(style: .normal, title: "Edit") {
             (action, sourceView, completionHandler) in
            self.swipeEditAction(indexPath: indexPath)
            completionHandler(true)
             
         }
         editAction.backgroundColor = UIColor(red: 255/255.0, green: 128.0/255.0, blue: 0.0, alpha: 1.0)
        // *********** End EDIT ***********
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction , editAction])
    
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //while tap on todo item navigate to PreviewTodoDataVC
        let previewTodoVC = storyboard?.instantiateViewController(identifier: storyBoardIdentifier) as! PreviewTodoDataVC
        previewTodoVC.img = UIImage(named: images[indexPath.row])!
        previewTodoVC.todoTitle = todos[indexPath.row].title
        previewTodoVC.todoDescription = todos[indexPath.row].discription
        self.navigationController?.pushViewController( previewTodoVC, animated: true)
    }
    
    
    //set the footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerNib = UINib(nibName: "CustomFooterView", bundle: nil)
        let footerView = footerNib.instantiate(withOwner: tabelView, options: nil).first as! CustomFooterView

        CustomFooterView.delegate = self

        return footerView
    }
    
    //edit the todo
    fileprivate func swipeEditAction( indexPath: IndexPath) {
        //1. Create the alert controller.
        let alertController = UIAlertController(title: "Edit Title and Description", message: nil, preferredStyle: .alert)
        //2. Add the text field. set the title to text filed
        alertController.addTextField { (titleTF) in
            titleTF.text = self.todos[indexPath.row].title
        }
        //2. Add the text field. You can configure it however you need.
        alertController.addTextField { (descriptionTF) in
            descriptionTF.text = self.todos[indexPath.row].discription
        }
        // 3. Grab the value from the text field, and edit it and reload textView when the user clicks OK.
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {  (_) in
            let titleTF = alertController.textFields![0] // Force unwrapping because we know it exists.
            let descriptionTF = alertController.textFields![1]
            
            if titleTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && descriptionTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
                self.todos[indexPath.row] = todo(title: titleTF.text , discription: descriptionTF.text)
            }else if titleTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
                self.todos[indexPath.row] = todo(title: titleTF.text , discription: self.todos[indexPath.row].discription)
            }else if descriptionTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
                self.todos[indexPath.row] = todo(title: self.todos[indexPath.row].title , discription: descriptionTF.text)
            }
            
            //
            DispatchQueue.main.async {
                //reload the tableview
                self.tabelView.reloadData()
            }
        }))

        self.present(alertController, animated: true)
    }
    
    //prepare for transfer data from TodoVC to PreviewTodoVC
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let previewTodoVC = segue.destination as! PreviewTodoDataVC
       let selectedRow = tabelView.indexPathForSelectedRow!.row
       previewTodoVC.todoIV.image = UIImage(named: images[selectedRow])
    }
}
