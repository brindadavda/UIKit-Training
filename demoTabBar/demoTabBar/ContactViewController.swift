//
//  FavouriteViewController.swift
//  demoTabBar
//
//  Created by apple on 08/01/24.
//

import UIKit

class ContactViewController: UIViewController, UITableViewDelegate , UITableViewDataSource{
    
    
    //images array
    var images = ["img1","img2","img3"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell1",for: indexPath) as? MyViewCell else { return UITableViewCell() }
        
        //set data to cell1
        cell1.imgView.image = UIImage(named: images[indexPath.row]+".png")
        cell1.imgLabel.text = images[indexPath.row]
        
        return cell1
    }
    

    @IBOutlet var tabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tabelView.delegate = self
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
