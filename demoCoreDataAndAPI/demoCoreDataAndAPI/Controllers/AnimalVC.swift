//
//  ViewController.swift
//  demoCoreDataAndAPI
//
//  Created by apple on 16/02/24.
//

import UIKit

class AnimalsVC: UIViewController {

    var animals : Array<Animal>? = nil
    private let animalViewModel = AnimalManager()

    @IBOutlet weak var tblAnimal: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black

        // Do any additional setup after loading the view.
        animalViewModel.getAnimalRecord {[weak self] animalRecords in
            DispatchQueue.main.async {
                if(animalRecords != nil && animalRecords?.count != 0){
                    self?.animals = animalRecords
                    self?.tblAnimal.reloadData()
                }
            }
        }
    }
}
