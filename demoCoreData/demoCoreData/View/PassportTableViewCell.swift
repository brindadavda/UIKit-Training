//
//  PassportTableViewCell.swift
//  demoCoreData
//
//  Created by apple on 14/02/24.
//

import UIKit

class PassportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var passportIdLabel: UILabel!
    
    @IBOutlet weak var employeeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
