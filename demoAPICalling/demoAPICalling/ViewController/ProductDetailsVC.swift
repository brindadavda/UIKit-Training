//
//  ProductDetailsVC.swift
//  demoAPICalling
//
//  Created by apple on 05/02/24.
//

import UIKit

class ProductDetailsVC: UIViewController {

    @IBOutlet weak var pIV: UIImageView!
    @IBOutlet weak var pTitle: UILabel!
    @IBOutlet weak var pDescription: UILabel!
    @IBOutlet weak var pBrand: UILabel!
    @IBOutlet weak var pCategory: UILabel!
    @IBOutlet weak var pPrice: UILabel!
    @IBOutlet weak var pDiscount: UILabel!
    
    
    //get data from productVc
    var img : UIImage!
    var name : String!
    var desc : String!
    var brand : String!
    var category : String!
    var price : String!
    var discount : String!
    
    @IBAction func addToCart(_ sender: Any) {
        print("ProductDetailsVC : ---> \(#function)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Product Details"
        
        //set the data
        pIV.image = img
        pTitle.text = name
        pDescription.text = desc
        pBrand.text = brand
        pCategory.text = category
        pPrice.text = price
        pDiscount.text = discount
    }

}
