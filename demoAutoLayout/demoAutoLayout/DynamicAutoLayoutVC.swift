//
//  dynamicAutoLayoutVC.swift
//  demoAutoLayout
//
//  Created by apple on 19/01/24.
//

import UIKit


class DynamicAutoLayoutVC: UIViewController {

    @IBOutlet weak var cvHCoon: NSLayoutConstraint!
    
    
    @IBOutlet weak var cv: UICollectionView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var tv: UITextView!

    
    @IBAction func actionOnTap(_ sender: UIButton) {
        sender.removeFromSuperview();
    }
    
    
    @IBAction func actionConChageAtclick(_ sender: UIButton) {
        
        print(#function)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //display diable on label and tv
        label.isHidden = false
        tv.isHidden = false
        
        cv.delegate = self
        cv.dataSource = self
        
        //flow layout variable
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.scrollDirection = .horizontal
        
        
        cv.showsHorizontalScrollIndicator = false
        
        cv.setCollectionViewLayout(flowLayout, animated: true)
        
    }
    
    

    

}

// declare variable
fileprivate let images : [String] = ["pencil" ,"eraser", "pencil" ,"eraser","pencil" ,"eraser","pencil" ,"eraser","pencil" ,"eraser"]

//reusable cell
let reuableIdentifier : String = "cell"

//dynamic size
var sizeVar : CGSize!

//is tapped
var isTappeditem : IndexPath!

extension DynamicAutoLayoutVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // declaring cell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuableIdentifier, for: indexPath) as! collectionCell

        
        cell.iv.image =  UIImage(systemName: images[indexPath.row])
    
        
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuableIdentifier, for: indexPath) as! collectionCell
    
        //make visible item
        isTappeditem = indexPath
        
        label.text = "\(images[indexPath.row]) + \(indexPath.row)"
        
        UIView.animate(withDuration: 1, animations: {
            cell.iv.transform = CGAffineTransform(scaleX: 2, y: 2)
        })

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: 200, height: 100)
    }
  
    
}


class collectionCell : UICollectionViewCell {
    
    @IBOutlet weak var iv: UIImageView!

    
}
