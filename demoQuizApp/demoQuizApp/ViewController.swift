//
//  ViewController.swift
//  demoQuizApp
//
//  Created by apple on 08/01/24.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    //creating structure for question
    struct Question : Decodable {
        let question : String
        let optionA : String
        let optionB : String
        let optionC : String
        let optionD : String
        let answer : String
    }
    
    //declare Question array
    var questionsArray : [Question]!
    
    //for result show
    var currentQuestion : Question?
    var currentQuestionPos = 0
    var noCorrectQuestion = 0
    
    //initializing views
    @IBOutlet weak var questionTV: UITextView!
    @IBOutlet weak var optionABtn: UIButton!
    @IBOutlet weak var optionBBtn: UIButton!
    @IBOutlet weak var optionCBtn: UIButton!
    @IBOutlet weak var optionDBtn: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBAction func ActionOptionSelected(_ sender: UIButton) {
        //optionA click event work
        checkAns(ans: sender.titleLabel?.text ?? "")
    }
    
    //check for answer
    func checkAns(ans : String){
        //ans is correct then add noCorrect question
        if(ans == currentQuestion!.answer){
            noCorrectQuestion += 1
        }
        
        //loading new question
        loadNewQuestion()
    }
    
    //now load new question
    func loadNewQuestion(){
        //if question remain
        if(currentQuestionPos+1 <  questionsArray.count){
            currentQuestionPos += 1
            currentQuestion = questionsArray[currentQuestionPos]
            setQuestion()
            
        }
        //last question then else condition will work
        else{
            performSegue(withIdentifier: "ShowResults", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowResults"){
            let vc = segue.destination as! ResultViewController
            //set data to result screen
            vc.noTotalQues = questionsArray.count
            vc.noCorrectAns = noCorrectQuestion
        }
    }
    
    //set the question in viewController
    func setQuestion(){
        questionTV.text = currentQuestion!.question
        optionABtn.setTitle(currentQuestion!.optionA, for: .normal)
        optionBBtn.setTitle(currentQuestion!.optionB, for: .normal)
        optionCBtn.setTitle(currentQuestion!.optionC, for: .normal)
        optionDBtn.setTitle(currentQuestion!.optionD, for: .normal)
        
        progressLabel.text = "\(currentQuestionPos + 1)/\(questionsArray.count)"
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //getting json data in array of struct Question formate
        questionsArray = readJSONFile(forName: "questions")
        currentQuestion = questionsArray[0]
        setQuestion()
        
    }
    
    
    //decoding json file
    func readJSONFile(forName name: String) -> [Question] {
        do {
            // creating a path from the main bundle and getting data object from the path
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                
                // Decoding the Product type from JSON data using JSONDecoder() class.
                let questionsArray = try JSONDecoder().decode([Question].self, from: jsonData)
                
                return questionsArray
            }
        } catch {
            print(error)
        }
        return []
    }
    
}

