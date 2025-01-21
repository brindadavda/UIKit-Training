//
//  ViewController.swift
//  TestGraphQL
//
//  Created by Brinda Davda on 11/09/24.
//

import UIKit

typealias tableviewProperty = UITableViewDelegate & UITableViewDataSource

struct ContriesNameViewModel {
//
    let continent: GetAllCountriesNameQuery.Data.Country
    
    var name: String {
        continent.name
    }
   
}

struct ContriesNameAndCodeViewModel {
//
    let continent: GetAllCountriesWithNameAndCodeQuery.Data.Country
    
    var name: String {
        continent.name
    }
    
    var code : String{
        continent.code
    }
   
}


class ViewController: UIViewController {
    
    @IBOutlet weak var tv : UITableView!
    
    var getData : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tv.delegate = self
        tv.dataSource = self
        
//        populateAllContinentsName()
        populateAllContriesNameAndCode()
        
        
    }
    
    
    func populateAllContinentsName(){
        
        var contries : [ContriesNameViewModel] = []
        
        // Get all continents
        Network.shared.apollo.fetch(query: GetAllCountriesNameQuery()){ [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let containents = graphQLResult.data?.countries{
                    DispatchQueue.main.async{
                        contries = containents.map(ContriesNameViewModel.init)
                        self?.getData = contries.map { $0.name }
                        self?.tv.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func populateAllContriesNameAndCode(){
        
        var contries : [ContriesNameAndCodeViewModel] = []
        
        // Get all continents
        Network.shared.apollo.fetch(query: GetAllCountriesWithNameAndCodeQuery()){ [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let containents = graphQLResult.data?.countries{
                    DispatchQueue.main.async{
                        contries = containents.map(ContriesNameAndCodeViewModel.init)
                        contries.forEach({ contry in
                            self?.getData.append(
                                "Name : \(contry.name) Code : \(contry.code)")
                            })
                        self?.tv.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
        Network.shared.apollo.perform(mutation: )
        
    }


}

extension ViewController : tableviewProperty{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = getData[indexPath.row]
        return cell
    }
    
    
}
