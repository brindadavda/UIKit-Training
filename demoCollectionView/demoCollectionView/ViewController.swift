//
//  ViewController.swift
//  demoCollectionView
//
//  Created by apple on 09/01/24.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! myUICollectionViewCell
        
        print(cell)

    
        cell.myImageView.image = UIImage(named: images[indexPath.row]+".jpg")

        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    

    //inital view declared here
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    
    //creating array for shows the images
    let images : [String] = ["img1","img2","img3","img4","img1","img2","img3","img4"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let itemSize = (UIScreen.main.bounds.width/4 - 2)
        //giving layout
        let layout = UICollectionViewFlowLayout()
        //setting the layout size
        layout.itemSize = CGSize(width:  itemSize, height: itemSize)
        //setting
        layout.minimumInteritemSpacing  = 10
        layout.minimumLineSpacing = 10
        
        //setting the layout to myCollectionView
        myCollectionView.collectionViewLayout = layout
        
        
        
        //got to viewCollection controller while performing the gesture
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe: )))
        
        //set the gesture
        self.view.addGestureRecognizer(leftSwipe)
        
        
        
    }
    
    //swipeAction func
    @objc func swipeAction(swipe: UISwipeGestureRecognizer){
        //perform selectore
        performSegue(withIdentifier: "moveForward", sender: self)
    }
}

