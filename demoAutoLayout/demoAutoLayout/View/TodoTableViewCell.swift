//
//  TodoTableViewCell.swift
//  demoAutoLayout
//
//  Created by apple on 23/01/24.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    @IBOutlet weak var iv: UIImageView!
    
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var discription: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

    }

}
