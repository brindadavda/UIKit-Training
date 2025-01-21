//
//  ViewController.swift
//  RickAndMortyClonApp
//
//  Created by apple on 29/06/24.
//

import UIKit

class RMTabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

//MARK: - helper
extension RMTabVC {
    class func loadHeaderView(headerView: inout UIView, title: HeaderTitle) {
        let headerSubView = RMHeaderView.fromNib(nibName: NibName.headerView.rawValue)
        headerSubView.lblTitle.text = title.rawValue
        headerView.addSubview(headerSubView)
    }
}

