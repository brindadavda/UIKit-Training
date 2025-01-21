//
//  EmployeeTableViewCell.swift
//  demoCoreData
//
//  Created by apple on 13/02/24.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileIV: UIImageView!
    
    @IBOutlet weak var eNameLabel: UILabel!
    
    @IBOutlet weak var eEmailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
