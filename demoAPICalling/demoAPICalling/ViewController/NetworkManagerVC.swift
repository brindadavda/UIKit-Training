//
//  NetworkManagerVC.swift
//  demoAPICalling
//
//  Created by apple on 06/02/24.
//

import UIKit

class NetworkManagerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getUser()
        //getUserUsingAF()
    }
    
    //get method
    func getUser(){
        NetworkManager.shared.request("https://jsonplaceholder.typicode.com/users", method: .get) { (result: Result<[User], Error>) in
            switch result {
            case .success(let users):
                print(users)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    /*func getUserUsingAF(){
        NetworkManagerUsingAF.shared.request("https://jsonplaceholder.typicode.com/users", method: .get) { (result: Result<[User], Error>) in
            switch result {
            case .success(let users):
                print(users)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }*/
}
