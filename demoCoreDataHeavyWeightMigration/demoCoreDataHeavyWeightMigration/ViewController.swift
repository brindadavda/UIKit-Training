//
//  ViewController.swift
//  demoCoreDataHeavyWeightMigration
//
//  Created by apple on 16/02/24.
//

import UIKit

class ViewController: UIViewController {

    private let productViewModel: ProductViewModel = ProductViewModelImplementation()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            productViewModel.populateTestRecordsForDemo() // comment this once the app runs
            String.printDocumentDirectoryPath()
           let products = productViewModel.fetchProducts()
            if products != nil {
                products?.forEach({ product in
                    dump(product)
                })
            }
        }

}

