//
//  AnimalVCExtention.swift
//  demoCoreDataAndAPI
//
//  Created by apple on 16/02/24.
//

import Foundation
import UIKit

extension AnimalsVC : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return animals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UILabel()
        headerView.text = "Animal Data"
        headerView.sizeToFit()
        headerView.font = UIFont.systemFont(ofSize: 36)
        headerView.textAlignment = .left
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "animalViewCell") as! AnimalViewCell

        let animal = self.animals![indexPath.row]
        cell.lblAnimalName.text = animal.name

        return cell
    }
}
