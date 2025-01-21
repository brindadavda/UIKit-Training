//
//  SearchbarViewController.swift
//  instagramClone
//
//  Created by apple on 15/01/24.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchbar : UISearchBar!
    
    @IBOutlet weak var tableView : UITableView!
    
    var dataSourceArr = ["John", "David" ,"Mike", "Smith", "Josh", "Michhel", "Barac", "Donald"]
      var filteredArr = Array<String>()
      var searching:Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        searchbar.delegate = self
    }

}

extension SearchViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searching ?? false){
            return filteredArr.count
        }else{
            return dataSourceArr.count
        }
          
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        if(!(searching ?? false)){
            cell.textLabel?.text = dataSourceArr[indexPath.row]
        }else{
            cell.textLabel?.text = filteredArr[indexPath.row]
        }
         
        return cell
    }
}
  
  
extension SearchViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          
        if(searchText.isEmpty){
            filteredArr = dataSourceArr
        }else{
            filteredArr = dataSourceArr.filter{$0.contains(searchText)}
        }
        searching = true
        tableView.reloadData()
    }
     
}
