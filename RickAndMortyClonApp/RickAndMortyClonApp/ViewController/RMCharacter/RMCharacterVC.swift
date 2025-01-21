//
//  RMCharacterVC.swift
//  RickAndMortyClonApp
//
//  Created by apple on 29/06/24.
//

import UIKit


///Controller to show and serch Characters
class RMCharacterVC: UIViewController  {
    
    @IBOutlet weak var headerView : UIView!
    @IBOutlet weak var spinner : UIActivityIndicatorView!
    @IBOutlet weak var cv : UICollectionView!
    
    
    private let viewModel  = RMCharacterListViewViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        RMTabVC.loadHeaderView(headerView: &headerView, title: .charcter)
        
        spinner.startAnimating()
        
        viewModel.featchChatecters()
        
        setUpCollectionView()
        
    
        
//        let request = RMRequest(endPoint: .character, pathComponetns: ["1"], queryPerameters: [URLQueryItem(name: "name", value: "rick"),URLQueryItem(name: "status", value: RMCharacterStatus.alive.rawValue)])
//        print(String(describing: request.url))
        
        
        
              
//        RMService.shared.execute(request, expecting: RMCharacters.self){ result in
//            switch result{
//            case .success :
//                    break
//            case .failure(let error) :
//                print(String(describing: error))
//            }
//        }
    }
    
    private func setUpCollectionView(){
        cv.delegate = viewModel
        cv.dataSource = viewModel
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            self.spinner.stopAnimating()
            
            
            self.cv.isHidden = false
            self.spinner.isHidden = !self.cv.isHidden
            
            UIView.animate(withDuration: 0.4, animations: {
                self.cv.alpha = 1
            })
        })
    }


}

