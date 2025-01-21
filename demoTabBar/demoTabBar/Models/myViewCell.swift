//
//  myViewCell.swift
//  demoTabBar
//
//  Created by apple on 09/01/24.
//

import UIKit

class MyViewCell: UITableViewCell {

    //initalizing variable
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
