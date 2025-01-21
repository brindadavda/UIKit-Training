//
//  CustomFooterView.swift
//  demoAutoLayout
//
//  Created by apple on 23/01/24.
//

import UIKit

class CustomFooterView: UIView {
    
    @IBOutlet weak var todoTitleTF: UITextField!
    @IBOutlet weak var todoDescriptionTF: UITextField!
    
    //creating variable
    static var delegate : CustomFooterViewDelegate!
    
    @IBAction func addTodo(_ sender: UIButton) {
        CustomFooterView.delegate?.didTapAddTodoBtn(title: todoTitleTF, description: todoDescriptionTF)
    }
    
}

//generate randome images
fileprivate func getRandomeImage() -> String{
    
    let imgNameIndex = Int.random(in: 10...121)
    
    return String(imgNameIndex)
}


//creating delegate
protocol CustomFooterViewDelegate: AnyObject {
    func didTapAddTodoBtn(title : UITextField , description : UITextField)
}
