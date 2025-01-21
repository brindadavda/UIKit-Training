//
//  AnimalTBVCell.swift
//  demoCoreDataAndAPI
//
//  Created by apple on 16/02/24.
//

import Foundation
import UIKit

class AnimalViewCell: UITableViewCell {

    @IBOutlet weak var lblAnimalName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
