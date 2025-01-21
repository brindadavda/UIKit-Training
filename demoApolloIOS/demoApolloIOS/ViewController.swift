//
//  ViewController.swift
//  demoApolloIOS
//
//  Created by Brinda Davda on 19/09/24.
//

import UIKit
import CountrySchema
import GithubXAPI

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTF : UITextField!
    @IBOutlet weak var descriptionTF : UITextField!
    @IBOutlet weak var idTF : UITextField!
    @IBOutlet weak var lblResult : UILabel!
    
    
    var visibility: GraphQLEnum<RepositoryVisibility> = GraphQLEnum(RepositoryVisibility.public)
    
    var errors: [ErrorViewModel] = []
    
    var rockets: [RocketsQuery.Data.Rocket] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //fetchRockets()
//        featchGithubName()
        
        getUrlEncodedAndDecoded()
        
    }
    
    @IBAction func getResult(_ sender : UIButton){
        saveRepository(){
            print("comepletion calling.")
            if self.errors.count > 0{
                self.errors.forEach({
                    print("\($0)")
                })
            }
            
//            self.featchGithubRepo()
        }
    }
    
    struct ErrorViewModel: Identifiable {
        let id = UUID()
        let message: String?
    }
    
    func saveRepository(completion: @escaping () -> Void) {
        
        let input = CreateRepositoryInput(
            clientMutationId: idTF.text ?? "", name: nameTF.text ?? "",
            description: descriptionTF.text ?? "",
            visibility: GraphQLEnum(RepositoryVisibility.public)
        )

        NetworkService.shared.apolloGithub.perform(mutation: Mutation_Create_repoMutation(input: input)) { result in
            
            switch result {
                case .success(let graphQLResult):
                    if let errors = graphQLResult.errors {
                        DispatchQueue.main.async {
                            print("Error : \(errors)")
                            self.errors = errors.map {
                                ErrorViewModel(message: $0.message)
                            }
                            completion()
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion()
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errors = [ErrorViewModel(message: error.localizedDescription)]
                        completion()
                    }
            }
            
            
        }
        
        
    }
    
    

    
//    private func featchGithubRepo(){
//        NetworkService.shared.apolloGithub.fetch(query: GetRepositoriesByUserNameQuery(username: "brindadavda", totalRepo: 31)){ [weak self] result in
//            
//            switch result {
//            case .success(let value):
//                var count = 0
//                // Retrieve rocket data and update the table
//                value.data?.user?.repositories?.nodes?.forEach({ node in
//                    count += 1
//                    print("count : \(count) Name : \(node!.name)")
//                })
//                
//            case .failure(let error):
//                // Print the error to the console
//                debugPrint(error.localizedDescription)
//            }
//        }
//    }

    
    private func fetchRockets() {
        
  // Create a request from our graphql file
        let query = RocketsQuery()
  // Connect to our Network Service. Apollo returns the standard Swift result, we handle it using switch case
        NetworkService.shared.apollo.fetch(query: query) { [weak self] result in
            switch result {
            case .success(let value):
                // Retrieve rocket data and update the table
                self?.rockets = value.data?.rockets?.compactMap { $0 } ?? []
                self?.rockets.forEach({print($0)})
                
            case .failure(let error):
                // Print the error to the console
                debugPrint(error.localizedDescription)
            }
        }
        
        NetworkService.shared.apolloCountry.fetch(query: query) { [weak self] result in
            switch result {
            case .success(let value):
                // Retrieve rocket data and update the table
//                self?.rockets = .rockets?.compactMap { $0 } ?? []
                print(value.data)
                
            case .failure(let error):
                // Print the error to the console
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    
    func getUrlEncodedAndDecoded(){
        let encoded: [UInt8] = [
            0xf6, 0xb4, 0x30, 0x52, 0x9c, 0x9a, 0xa6, 0x6d, 0x59, 0xfe, 0xbd, 0x37, 0x10, 0xff, 0x53, 0x50, 0x5c, 0xc1, 0xa2, 0xfb, 0xd7, 0xd9, 0x38, 0x12, 0x9f, 0x7b, 0x71, 0xa5, 0xed, 0x4b, 0x4a, 0x9d, 0x1d, 0x23, 0x82, 0xfb, 0xab, 0x80, 0x76, 0xe2, 0x6c, 0x6f, 0x17, 0xbd
        ]

        // Assume CPSKeys.salt is defined as
        let salt: [UInt8] = [
            0x9e, 0xc0, 0x44, 0x22, 0xef, 0xa0, 0x89, 0x42, 0x2d, 0x97, 0xde, 0x5c, 0x75, 0x8b, 0x20, 0x7d, 0x2f, 0xb5, 0xc3, 0x8f, 0xbe, 0xba, 0x15, 0x71, 0xf0, 0x15, 0x5, 0xc0, 0x83, 0x3f, 0x64, 0xfe, 0x74, 0x4d, 0xe7, 0x8b, 0xc4, 0xec, 0x1f, 0x91, 0x42, 0xc, 0x78, 0xd0, 0x5f, 0xad, 0x6b, 0x7c, 0xc8, 0xe9, 0xba, 0x61, 0xa0, 0x46, 0x23, 0xc8, 0xfb, 0x58, 0x8, 0xe3, 0xa8, 0x80, 0x42, 0xf7
        ]

        

        let decodedURL = decode(encoded: encoded, cipher: salt)
        print("Decoded URL: \(decodedURL)")

    }
    
    func decode(encoded: [UInt8], cipher: [UInt8]) -> String {
        return String(decoding: encoded.enumerated().map { offset, element in
            element ^ cipher[offset % cipher.count]
        }, as: UTF8.self)
    }
}

