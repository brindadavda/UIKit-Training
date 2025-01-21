//
//  MasterViewController.swift
//  demoSplitVC
//
//  Created by apple on 02/03/24.
//

import UIKit

struct Model{
    let name: String
    let color: UIColor
}


protocol ColorSelectionDelegate{
    func colorSelected(selectedColor: UIColor)
}

class MasterViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var Colors = [Model(name: "Red", color: UIColor.red),Model(name: "Blue", color: UIColor.blue),Model(name: "Green", color: .green),Model(name: "Yellow", color: .yellow),Model(name: "Pink", color: .systemPink)]


    static var delegate: ColorSelectionDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Colors.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = Colors[indexPath.row].name
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let destinationVC = MasterViewController.delegate as? DetailViewController{
            splitViewController?.showDetailViewController(destinationVC, sender: self)
            MasterViewController.delegate?.colorSelected(selectedColor: Colors[indexPath.row].color)
        }
    }

}
