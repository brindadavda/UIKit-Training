//
//  ProductDetailsVC.swift
//  demoAPICalling
//
//  Created by apple on 03/02/24.
//

import UIKit

class ProductVC: UIViewController {
    
    //cell identifier
    let cellIdentifier = "ProductDetailsCell"
    
    //variable for get product data
    var products = [ProductDetails]()
    var images = [UIImage]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Products"

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension ProductVC : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ProductTVCell
        
        let product = products[indexPath.row]
        
       // cell.productIV.image = UIIm
        cell.productIDLabel.text = String(product.id)
        cell.productTitleLabel.text = product.title
        cell.productDescriptionLabel.text = product.description
        cell.productPriceLabel.text = "\(product.price) $"
        cell.stockLabel.text = String(product.stock)
        cell.brandLabel.text = product.brand
        cell.categoryLabel.text = product.category
        
        if let url = URL(string: product.images[0]) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async { /// execute on main thread
                    guard let image = UIImage(data: data) else{return}
                    cell.productIV.image = image
                    self.images.append(image)
                }
            }
            
            task.resume()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ProductDetailsVC :--> \(#function) : \(indexPath)")
        
        let vc = storyboard?.instantiateViewController(identifier: "productDetails") as! ProductDetailsVC
        print("ProductCV : ----> \(indexPath.row) : image =  \(images[indexPath.row])")
        
        let product = products[indexPath.row]
        
        vc.img = images[indexPath.row]
        vc.name = product.title
        vc.desc = product.description
        vc.brand = product.brand
        vc.category = product.category
        vc.price = "\(product.price)$"
        vc.discount = "\(product.discountPercentage)%"
        
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
