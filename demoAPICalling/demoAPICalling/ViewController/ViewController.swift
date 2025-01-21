//
//  ViewController.swift
//  demoAPICalling
//
//  Created by apple on 03/02/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var responseLabel: UILabel!
    
    @IBOutlet weak var urlTF: UITextField!
    
    //product data array
    var productData = [ProductDetails]()
    
    @IBAction func goToProductDetails(_ sender: UIButton) {

        guard let url = urlTF.text else{return}
        
        if url.contains("products"){
           let vc = storyboard?.instantiateViewController(identifier: "products") as! ProductVC
            vc.products = productData
            navigationController?.pushViewController(vc, animated: true)
        }else{
           let vc = storyboard?.instantiateViewController(identifier: "login") as! LoginVC
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func getResponse(_ sender: UIButton) {
        Task { @MainActor in
            
            if !(urlTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? false){
                guard let url = urlTF.text else{return}
                
                //if it url related to post
                if url.contains("products"){
                    getProductDetailsResponseFromUrl(url: url)
                }
               
                //responseLabel.text = responseData
                if url.contains("post"){
                    /*let login = Login(email: "test@test.test", password: "testPassword")
                    postDataToUrl(url: url, params: login)*/
                    
                    
                }else if url.contains("login"){
                    getLoginResponseFromUrl(url: url)
                }
                
               getJSONResponse(url: url)
            }else{
                urlTF.text = "https://dummyjson.com/products"
            }
        }
    }
    
    func getJSONResponse(url : String){
        AF.request(url).responseJSON(completionHandler: {
            response in
            switch response.result {
            case .success(let data):
                debugPrint(data)
                self.responseLabel.text = "\(data)"
                break
            case .failure(let error) :
                self.responseLabel.text = "\(error)"
                break
            }
            
        })
    }
    
    
    
    func getLoginResponseFromUrl(url : String){
        let headers: HTTPHeaders = [
            .authorization(username: "kminchelle", password: "0lelplR"),
            .accept("application/json")
        ]
        
        AF.request(url).responseDecodable(of: Login.self, completionHandler: { [self] response in
            switch response.result {
            case . success(let loginData):
                self.responseLabel.text =  "Login Details : \n \(loginData)"
            case .failure(let productFetcherror):
                print(productFetcherror.localizedDescription)
        }
        })
    }
    
    
    func  getProductDetailsResponseFromUrl (url : String){
        // Automatic String to URL conversion, Swift concurrency support, and automatic retry.
        let params : Parameters? = nil
        if params == nil{
            AF.request(url ,  requestModifier: { $0.timeoutInterval = 0.9 }).responseDecodable(of: Product.self) { [self] response in
                switch response.result {
                case .success(let data):
                    responseLabel.text = "Product Details :\n \( data.products)"
                    
                    productData = data.products
                    
                case .failure(let productFetcherror):
                    print(productFetcherror.localizedDescription)
                }
            }
        }else{
            AF.request(url , parameters: params).response{
                (response) in
                self.responseLabel.text = "Product Details :\n \( response)"
            }
        }
    }
    
    func postDataToUrl(url : String , params : Login){
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder.default).response { response in
            debugPrint(response)
            self.responseLabel.text = response.description
        }
    }
    
    //Download file
    func downloadFile(){
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("image.png")
            
            print("VC :----> \(fileURL)")

            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        AF.download("https://picsum.photos/seed/picsum/200/300", to: destination).response { response in
            debugPrint(response)

            if response.error == nil, let imagePath = response.fileURL?.path {
                let image = UIImage(contentsOfFile: imagePath)
            }
        }
    }

    func downloadProgress(){
        AF.download("https://s3-us-west-2.amazonaws.com/s.cdpn.io/123941/Yodel_Sound_Effect.mp3")
            .downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseData { response in
                if let data = response.value {
                   // let image = UIImage(data: data)
                    debugPrint(data)
                }
            }
    }
    
    func downloadProgressUsingQueue(){
        let progressQueue = DispatchQueue(label: "com.alamofire.progressQueue", qos: .utility)

        AF.download("https://httpbin.org/image/png")
            .downloadProgress(queue: progressQueue) { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseData { response in
                if let data = response.value {
                    let image = UIImage(data: data)
                }
            }
    }
    
    func cancelAndResumeDownload(){
        var resumeData: Data!

        let download = AF.download("https://httpbin.org/image/png").responseData { response in
            if let data = response.value {
                let image = UIImage(data: data)
            }
        }

        // download.cancel(producingResumeData: true) // Makes resumeData available in response only.
        download.cancel { data in
            resumeData = data
        }

        /*AF.download(resumingWith: resumeData).responseData { response in
            if let data = response.value {
                let image = UIImage(data: data)
            }
        }*/
    }
    
    func uploadingToServer(){
        let data = Data("data".utf8)

        AF.upload(data, to: "https://httpbin.org/post").response() { response in
            debugPrint(response)
        }
    }
    
    
    
    func fromScrachURLSession(){
        let params = ["login": "correct_login@example.com",
                      "password": "C0rr3Ct_P@55w0rd"] as Dictionary<String, String>

        var request = URLRequest(url: URL(string: "https://recruitment-api.pyt1.stg.jmr.pl/login")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        //created task to start session
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
            } catch {
                print("error")
            }
        })

        task.resume()
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       // downloadFile()
       // downloadProgress()
        //downloadProgressUsingQueue()
       // cancelAndResumeDownload()
        fromScrachURLSession()
       
    }
}

