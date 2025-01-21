//
//  ListExamplesViewController.swift
//  demoAlertView
//
//  Created by apple on 16/04/24.
//

import UIKit

struct Example {
    var title: String
    var malert: Malert
}

class MalertViewController: BaseViewController {
    
    var examples: [Example] = []
    
    override func loadView() {
        super.loadView()
        addTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackBarItem()
        addExamples()
        configureTableView()
    }
    
    func addBackBarItem(){
        let backBarItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(backBtnAction))
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationItem.leftBarButtonItem = backBarItem
    }
    
    @objc func backBtnAction(_ sender : UIBarButtonItem){
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Examples"
        navigationController?.navigationBar.barTintColor = .primary
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }
    
    override func configureTableView() {
        super.configureTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        
        tableView.register(UINib(nibName: "ExampleTableViewCell", bundle: nil), forCellReuseIdentifier: "ExampleTableViewCell")
    }
}

extension MalertViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleTableViewCell", for: indexPath) as! ExampleTableViewCell
        cell.populateWith(title: examples[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let example = examples[indexPath.row]
        present(example.malert, animated: true)
    }
}
