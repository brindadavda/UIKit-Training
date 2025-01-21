//
//  ViewController.swift
//  revise_training
//
//  Created by apple on 18/07/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let label = UILabel()
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.text = "This is revising work!"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 64)
        label.textColor = .yellow
        label.numberOfLines = 0
        label.layer.cornerRadius = 20
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler(_ : )))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
        label.contentMode = .scaleAspectFit
        
        //label.lineBreakMode = .byWordWrapping
        
        label.layer.shadowOffset = CGSize(width: 10, height: 3)
        label.layer.shadowOpacity = 1
        label.layer.shadowRadius = 5
        
        view.addSubview(label)
        
        view.backgroundColor = .systemBlue
        
        NSLayoutConstraint.activate([
//            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
//            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            //label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: 0),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: 0)
        ])
        
        
        
        let dp = UIDatePicker(frame:  CGRect(x: 0, y: 0, width: 320, height: 200))
        dp.datePickerMode
    }
    
    
    @objc func tapGestureHandler(_ sender : UITapGestureRecognizer){
        print(#function)
    }


}

