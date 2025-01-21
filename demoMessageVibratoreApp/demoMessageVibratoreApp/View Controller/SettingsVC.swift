//
//  SettingsVC.swift
//  demoMessageVibratoreApp
//
//  Created by apple on 09/02/24.
//

import UIKit

class SettingsVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "feedbackVC") as! feedbackVC
       navigationController?.pushViewController(vc, animated: true)
    }

    @IBOutlet weak var tv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("SettingsVc : -->\(#function)")
    }

}
