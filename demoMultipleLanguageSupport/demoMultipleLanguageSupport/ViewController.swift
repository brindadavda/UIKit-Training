//
//  ViewController.swift
//  demoMultipleLanguageSupport
//
//  Created by apple on 02/03/24.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var languagePrefenrece = UserDefaults.standard.string(forKey: "myLanguageKey") ?? "en"
    
    var tableViewSource: [String] = []
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("View Controller : ---> \(#function)")
        languagePrefenrece = UserDefaults.standard.string(forKey: "myLanguageKey") ?? "en"
        
        setupData()
        
    }
    
    
    func setupData(){
        setupTableViewData()
        titleLabel.text = setLocalizationKey(languageKey.mainStoryBoard_hello.rawValue)
    }
    
    func setupTableViewData(){
        tableViewSource = []
            tableViewSource.append(setLocalizationKey(languageKey.tableViewCell_one.rawValue))
            tableViewSource.append(setLocalizationKey(languageKey.tableViewCell_two.rawValue))
            tableViewSource.append(setLocalizationKey(languageKey.tableViewCell_three.rawValue))
            tableViewSource.append(setLocalizationKey(languageKey.tableViewCell_four.rawValue))
            tableViewSource.append(setLocalizationKey(languageKey.tableViewCell_five.rawValue))

    }
    
    /* get the bundle from Localizable file */
    func setAppLanguage(_ language : String) -> Bundle?{
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj") else {
          return nil
        }
        
        guard let bundle = Bundle(path: path) else {
          return nil
        }
        
        return bundle
    }

    /* set that bundle to NSLocalizedString with respect to given key */
    func setLocalizationKey(_ key : String ) -> String{
        guard let bundle = setAppLanguage(languagePrefenrece) else {return ""}
        return NSLocalizedString(key , bundle: bundle, comment: "")
    }
    
   
    @IBAction func onOpenPreferenceButtonPressed(_ sender: UIButton) {
          
          guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {return}
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
    }
    
   /* class func setAppLangauge(_ langauge: language) {
           App.setUD(langauge, key: Keys.udUserSelectedAppLangauge)
       }

       class func getAppLangauge() -> Localizable.Language {
           let langaugeIdentifier =  App.getUD(Keys.udUserSelectedAppLangauge, type: String.self) ?? ""
           if let langauge = Localizable.arrLangauge().filter({ $0.identifier == langaugeIdentifier }).first {
               return langauge
           }
           return .english
       } */
    
    @IBAction func onSwitchButtonPressed(_ sender: UIButton) {
        languagePrefenrece = (languagePrefenrece == "hi") ? "en" : "hi"
        
        view.backgroundColor = languagePrefenrece == "hi" ?   .green : .blue
           UserDefaults.standard.set([languagePrefenrece], forKey: "myLanguageKey") // (Optional)
        
            setupData()
        
           tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("View Controller : ---> \(#function)")
    }
    
    

}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell")! as UITableViewCell
        cell.textLabel?.text = tableViewSource[indexPath.row]
        return cell
    }

}




