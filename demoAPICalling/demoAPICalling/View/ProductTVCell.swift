//
//  ProductDetailsTVCell.swift
//  demoAPICalling
//
//  Created by apple on 05/02/24.
//

import UIKit

class ProductTVCell: UITableViewCell {
    
    @IBOutlet weak var productIV: UIImageView!
    
    @IBOutlet weak var productIDLabel: UILabel!
    
    @IBOutlet weak var productTitleLabel: UILabel!
    
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var discountPercentageLabel: UILabel!
    
    @IBOutlet weak var stockLabel: UILabel!
    
    @IBOutlet weak var brandLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
