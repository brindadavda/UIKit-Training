//
//  DisplayCollectionViewVC.swift
//  demoCollectionView
//
//  Created by apple on 29/01/24.
//

import UIKit

class DisplayCollectionViewVC: UIViewController {
    
    //create images array
    var images = [String]()
    
    //set the count
    let count = 300
    
    
    //collection cell identifier
    let reuseIdentifier = "Cell"

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //get the image
        for _ in 1...count {
            images.append(getRandomeImage())
        }
        
        //set the layout of collectionview
        collectionView!.collectionViewLayout = getcollectionViewLayout()
    }
    
    deinit{
        debugPrint("Deallocation of memory")
    }

}

//generate randome images
fileprivate func getRandomeImage() -> String{
    
    let imgNameIndex = Int.random(in: 10...121)
    
    return String(imgNameIndex)
}

var width = UIScreen.main.bounds.width
let space = CGFloat(15)
let noOfCellinrow = CGFloat(3)

//collectionView layout
fileprivate func getcollectionViewLayout() -> UICollectionViewLayout {
    
    width = (width/noOfCellinrow) - 1.5*space
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
    
    if UIDevice.current.userInterfaceIdiom == .pad{
        layout.itemSize = CGSize(width: width, height:300)
    }else{
        layout.itemSize = CGSize(width: width, height:195)
    }
    
    
        layout.minimumInteritemSpacing = space
        layout.minimumLineSpacing = space

    
        return layout
}


extension DisplayCollectionViewVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! collectionViewCell
        
        cell.iv.image = UIImage(named: images[indexPath.row])
        
        return cell
    }
}

//creating collection view cell
class collectionViewCell : UICollectionViewCell{
    
    @IBOutlet weak var iv: UIImageView!

}
