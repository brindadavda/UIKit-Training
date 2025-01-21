//
//  ViewController.swift
//  demoHeaderFooterTableView
//
//  Created by apple on 25/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set the delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //set the footer view
        
        let footerView = UIView()
        footerView.backgroundColor = .systemBlue
        footerView.frame.size.height = 100
        self.tableView.tableFooterView = footerView
        
    }
}


extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        
        view.backgroundColor = .cyan
        
        return view
    }
    
}

