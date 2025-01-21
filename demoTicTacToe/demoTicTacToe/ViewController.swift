//
//  ViewController.swift
//  demoTicTacToe
//
//  Created by apple on 10/01/24.
//

/* ------- logic for this :
 is set an array to "0" for 9 times
 
 and when user tap on any one button reserve that index value of array by that number of player
 
 for example if index = 0 && value = 0 then it's ready to play by player or else if it's not 0 then it's either 1 or 2 of the array perticular that index value so by that way it's reserved.
 
 now le's code it!
------ */
import UIKit

class ViewController: UIViewController {
    
    //player buttons outlate
    @IBOutlet weak var playingBtn: UIButton!
    
    //declaring array of size 9
    var gameState : [Int] = [0,0,0,0,0,0,0,0,0];
    //declaring and initalizing active player
    var activePlayer = 1
    //game is active or not
    var gameIsActive = true
    //combination for win game
    var winningCombination = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6],[0,3,6],[1,4,7],[2,5,9]]

    //logic for placing the value on board
    @IBAction func actionTap(_ sender: UIButton) {
        if(gameState[sender.tag - 1] == 0 && gameIsActive){
            gameState[sender.tag - 1] = activePlayer
            
            if(activePlayer == 1){
                sender.setImage(UIImage(named: "Cross.png"), for: .normal)
                activePlayer = 2
            }else{
                sender.setImage(UIImage(named: "Nought.png"), for: .normal)
                activePlayer = 1
                
            }
        }
        //logic for checking win or tie game
        /*------ logic here :
         
         first traveling from array of winning combination
         and check fro it's played already a the first vaule of game state != 0 and first and second and tird combination index value of game state is equal
         
         then it's final winnning.
         ------*/
        
        //for show the alert title here declared variable
        var title : String?
        
        for combination in winningCombination{
            //check for game completed
            if (gameState[combination[0]] != 0 &&
                gameState[combination[0]] == gameState[combination[1]] &&
                gameState[combination[1]] == gameState[combination[2]]){
                gameIsActive = false
                
                if gameState[combination[0]] == 1{
                    title = "CROSS PLAYER WIN!"
                }else{
                    title = "NOUGHT PLAYER WIN!"
                }
                //show alert
                showAlert(title: title)
                
            }
        }
        
        gameIsActive = false
        
        for i in gameState{
            if i == 0{
                gameIsActive = true
                break
            }
        }
        
        //after checking the game is running or not if it's not running and no winner combination found
        //then it's a draw
        if gameIsActive == false{
            title = "IT'S A DRAW!"
            //show alert
            showAlert(title: title)
            
        }
    }
    
    
    //show alert working
    func showAlert(title : String!){
        let alert = UIAlertController(title: "Result", message: title, preferredStyle: .alert)
        let playAgainAction = UIAlertAction(title: "Play Again", style: .default , handler: clearGame(_ : ))
        alert.addAction(playAgainAction)
        //adding in dispatcher queue
        DispatchQueue.main.async {
                   self.present(alert, animated: false, completion: nil)
        }
    }
    
    
    
    //logic for clear game
    func clearGame(_ action : UIAlertAction){
        self.gameState = [0,0,0,0,0,0,0,0,0]
        self.gameIsActive = true
        self.activePlayer = 1
        
        //clear all image
        for i in 1...9{
            let btn = self.view.viewWithTag(i) as! UIButton
            btn.setImage(nil, for: .normal)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

