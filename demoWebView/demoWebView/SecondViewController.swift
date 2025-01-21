//
//  SecondViewController.swift
//  demoWebView
//
//  Created by apple on 05/01/24.
//

import UIKit
//import webview kit
import WebKit

class SecondViewController: UIViewController , UISearchBarDelegate , WKNavigationDelegate {

    @IBOutlet weak var SearchView: UISearchBar!

    @IBOutlet weak var Webview: WKWebView!
    
    //webview action backword
    @IBAction func ActionBack(_ sender: UIBarButtonItem) {
        if Webview.canGoBack{
            Webview.goBack()
        }
    }
    
    //webview action referesh
    @IBAction func ActionRefresh(_ sender: UIBarButtonItem) {
        Webview.reload()
    }
    
    //webview action forward
    @IBAction func ActionForward(_ sender: UIBarButtonItem) {
        if Webview.canGoForward{
            Webview.goForward()
        }
    }
    
    //for searchbar add searchbarview dalegateor
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //set nevigation delegate to web view kit        Webview.navigationDelegate = self
        
        SearchView.resignFirstResponder()
        
        if let url = URL(string: SearchView.text!){
            Webview.load(URLRequest(url: url))
            
        }else{
            print("Error");
        }
    }
    
    
    //for refresh webview to add delegator

    
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
            
        //Webview.load(URLRequest(url: URL(string: "https://www.google.co.in/?client=safari&channel=iphone_bm")!))
        
        getVideo(videoCode: "-PzlpNaszp4")
    }
    
    func getVideo(videoCode : String){
        let url : URLRequest = URLRequest(url: URL(string: "https://www.youtube.com/embed/\(videoCode)")!)
        
        Webview.load(url)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
