//
//  ViewController.swift
//  instagramClone
//
//  Created by apple on 11/01/24.
//

import UIKit

class HomeViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource, myProtocol {

  
    @IBOutlet weak var storyCV: UICollectionView!
    
    @IBOutlet weak var postCV: UICollectionView!
    
    
    @IBAction func actionFavoutiteClick(_ sender: UIButton){
        /*print(PostViewCollectionCell.likedImages.count)
        print("counts : ")
        var count : Int = 0
        for i in 1...PostViewCollectionCell.likedImages.count{
            if(PostViewCollectionCell.likedImages[i-1] == 1){
                count += 1
            }
        }
        print(count)*/
    }
    
    @IBAction func actionMessageClick(_ sender: UIButton) {
        print("Message icon clicked")
    }
    
    
    
    //starting point
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set the delegate and datasource to storycollectionView
        storyCV.delegate = self
        storyCV.dataSource = self
        
        //set the delegate and datasource to post collectionView
        //postCV.delegate = self
        //postCV.dataSource = self
        
        storyCV.collectionViewLayout = setLayout(height: 120)
        //postCV.collectionViewLayout = setLayout(height: 455,width:self.postCV.bounds.size.width , scrollDirection: .vertical)
        
        
        tV.delegate = self
        tV.dataSource = self
        
        
        tV.rowHeight = 500

        
    }
    
    //creating label arryay
    static let images = ["img1","img1","img1","img1","img1","img1","img1","img1","img1","img1","img1","img1"]
    
    //variable for count
    let countforPost = 2
    
    //store index
    static var index : Int?
    
    
    //
    let reuseIdentifierforPost = "PostCell"

    
    //set the collection view datasource work
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.storyCV){
            return HomeViewController.images.count
        }
        //else for postCV
        return countforPost
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        HomeViewController.index = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == self.storyCV){
            //story collection view
            
            let storyCell = StoryViewCollectionCell().setStoryCVC(collectionView , cellForItemAt: indexPath) as! StoryViewCollectionCell
            
            if let iv = storyCell.IvView{
                UIViewRoundGradient(to: iv,startColor:  UIColor.red, endColor: UIColor.blue, lineWidth: 5, startPoint: CGPoint.topLeft, endPoint: CGPoint.bottomLeft)
            }
            
            return storyCell
        }
        //else for postCV
        /*let postCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierforPost, for: indexPath) as! PostViewCollectionCell
        
        postCollectionViewCell.userIV?.image = UIImage(named:  HomeViewController.images[indexPath.row]+".png")
        
        postCollectionViewCell.userNameLabel.text = HomeViewController.images[indexPath.row]
        
        postCollectionViewCell.delegate = self
        
        return postCollectionViewCell*/
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! collectionCell
        
        cell.iv.image = UIImage(named: HomeViewController.images[indexPath.row])
        
        
        return cell
    }
    
    
    //setting layout to collectionView
    func setLayout(height : Double = (UIScreen.main.bounds.width/4) , width : Double = (UIScreen.main.bounds.width/4), scrollDirection : UICollectionView.ScrollDirection = .horizontal) -> UICollectionViewLayout{
        //giving layout
        let layout = UICollectionViewFlowLayout()
        //setting the layout size
        layout.itemSize = CGSize(width:  width, height: height)
        //setting scrollDirection
        layout.scrollDirection = scrollDirection
        
        return layout
    }
    
    
    //from my protocol
    func loadNewScreen(activityViewController: UIViewController) {
        self.present(activityViewController, animated: true)
    }
    
    @IBOutlet weak var tV: UITableView!
    
    
}


extension HomeViewController : UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage

        if let possibleImage = info[.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }

        // do something interesting here!
        print(newImage.size)

        dismiss(animated: true)
    }
}




extension HomeViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let tasks = ["1","2","3"]
        
       //guard let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell2") else { return UITableViewCell() }
    
        //guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "Cell2") else { return UITableViewCell() }
        
        //tableView.estimatedRowHeight = 50.0
        
        print(indexPath.row)
        
        //let randomInt = Int.random(in: 0...3)
        
       // print(randomInt)
        
        let selectedTaskCategory = tasks[indexPath.row < tasks.count ? indexPath.row : 0]
        var cellChooser : UITableViewCell!
    

           if selectedTaskCategory == "1"{
               let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1")
               self.tV.rowHeight = 60
               cellChooser = cell
           }
           else if selectedTaskCategory == "2" {
               let emailCell = tableView.dequeueReusableCell(withIdentifier: "Cell2")
               //emailCell!.selectionStyle = UITableViewCellSelectionStyle.None
               self.tV.rowHeight = 200
               cellChooser = emailCell

           }
           else {
               let emptyCell = tableView.dequeueReusableCell(withIdentifier: "Cell3")
               cellChooser = emptyCell
               self.tV.rowHeight = 60
               //emptyCell!.selectionStyle = UITableViewCellSelectionStyle.None
           }

           return cellChooser
        
        //return cell1
    }
    
}

class collectionCell : UICollectionViewCell{
    
    @IBOutlet weak var iv: UIImageView!
}

