//
//  alertDispalyCell.swift
//  demoAlertView
//
//  Created by apple on 16/04/24.
//

import UIKit

class AlertDispalyCell: UITableViewCell {
    
    static let reuableIdentifier = "cell"

    @IBOutlet weak var alertlabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
