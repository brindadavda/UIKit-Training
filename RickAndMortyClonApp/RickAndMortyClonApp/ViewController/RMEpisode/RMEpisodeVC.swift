//
//  RMEpisodeVC.swift
//  RickAndMortyClonApp
//
//  Created by apple on 29/06/24.
//

import UIKit

///Controller to show and serch Episods
class RMEpisodeVC: UIViewController {
    
    @IBOutlet weak var headerView : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        RMTabVC.loadHeaderView(headerView: &headerView, title: .episods)
    }


}

