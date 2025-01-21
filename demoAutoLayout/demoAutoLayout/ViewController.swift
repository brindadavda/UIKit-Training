//
//  ViewController.swift
//  demoAutoLayout
//
//  Created by apple on 18/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var tv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tv.delegate = self
        tv.dataSource = self
    }


}


class tableViewCell : UITableViewCell{
    
    @IBOutlet weak var iv: UIImageView!
    
    @IBOutlet weak var deleteLabel: UILabel!
    
    @IBOutlet weak var keepLabel: UILabel!
    
}


let reusableIdentifier = "Cell"
private let images = Array(repeating: "trash", count: 20)

extension ViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier) as! tableViewCell
        
        //tableViewCell.iv.image = UIImage(systemName: images[indexPath.row])
        
        return tableViewCell
    }

    
    
    
    
    
    
    
}

