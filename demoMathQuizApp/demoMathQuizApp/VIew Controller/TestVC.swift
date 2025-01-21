//
//  TestVC.swift
//  demoMathQuizApp
//
//  Created by apple on 29/01/24.
//

import UIKit
import AVFoundation

class TestVC: UIViewController {
    
    static let STORY_BOARD_IDENTIFIER = "testVC"
    //play sound from this countDownNumber
    private let COUNT_DOWN_TIMER = 5
    //set the title for submit
    private let BTN_TITLE = "Submit"
    //audio file name
    private let AUDIO_FIlE_NAME = "tick.mp3"
    //progress layer
    private let PROGRESS_LAYER = CAShapeLayer()
    
    //get questions array
    private var questions = [Question]()
    //total count for text
    private var count = 0
    //get the result value
    private var result : String?
    //correct ans calculate
    private var totalCorrectAns = 0
    //declare timer variable
    private var timeCount : Int!
    private var timer  = Timer()
    //play sound
    private var player: AVAudioPlayer?
    //all the views
    @IBOutlet weak var gotoResultVCBtn: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionNoLabel: UILabel!
    @IBOutlet weak var ansTF: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var voiceBtn: UIButton!
    @IBOutlet var bottomBtnCon: NSLayoutConstraint!
    
    //change for voice action either stop or play
    @IBAction func playPauseBtn(_ sender: UIButton) {
        //pause the sound
        if voiceBtn.isSelected{
            voiceBtn.isSelected = false
        }else{
            voiceBtn.isSelected = true
        }
    }
    
    /* ------- navigation to  ResultVC work start ------- */
    @IBAction func goToResultVC(_ sender: UIButton) {
        //first validate the ansTF and then check the ans
        let text = ansTF.text!
        if !text.trimmingCharacters(in: .whitespaces).isEmpty && ((Double(text)?.isNaN) != nil){ //if not done button come then generate next question
                //check for done button then navigate to result VC
                checkCorrectAns(text: text.trimmingCharacters(in: .whitespaces))
                //navigate to resultVC
                if sender.titleLabel!.text == BTN_TITLE{
                    navigateToResultVC()
                }else{
                    timer.invalidate()
                    count += 1
                    self.viewDidLoad()
                }
            }else{ //present alert for empty text filed
                let alert = showAlert(title: "Invalid Ans!", message: "Please provide the ans")
                self.present(alert, animated: true)
        }
    }
    /* ------- navigation to  ResultVC work end ------- */
    
    /* ------ action function work when timer start ------ */
    @objc func action(){
        timeCount -= 1
        timerLabel.text = String(timeCount)
        //play sound if count <= countDownNumber
        if timeCount <= COUNT_DOWN_TIMER{
            playerPlayPause()
        }
        //handle to show the progress changing
        UIView.animate(withDuration: 1.0, animations: {
            self.PROGRESS_LAYER.strokeEnd = CGFloat(Double(self.timeCount)/Double(getrange+10)*0.01)
        })
        if timeCount == 0{
            //stop timer
            timer.invalidate()
            //increment question count
            count += 1
            //reload the view
            self.viewDidLoad()
        }
    }
    /* ------ action function work end ------ */
    
    /* ------ check ans is correct start ------*/
    private func checkCorrectAns(text : String){
        //get the correct ans
        let correctAns = questions[count].correctAns
        if Double(text) == correctAns {
            totalCorrectAns += 1
        }
    }
    /* ------ check ans is correct end ------*/
    
    /* ------ set player in this view start ------*/
    private func setPlayer(){
        //get the name and type of audio file
        let result : [Substring] = AUDIO_FIlE_NAME.split(separator: ".")
        guard let path = Bundle.main.path(forResource: String(result[0]), ofType: String(result[1]))else{return}
        let soundURl = URL(fileURLWithPath: path)
        player = try? AVAudioPlayer(contentsOf: soundURl)
        player!.prepareToPlay()
    }
    /* ------ set player in this view end ------*/
    
    /* ------ player playpause logic start ------- */
    private func playerPlayPause(){
        guard let player = player else{return}
        //if the player pause then play else pause the audio
        if !player.isPlaying{
            if !voiceBtn.isSelected{
                player.play()
            }
        }else{
            player.pause()
        }
    }
    /* ------ player playpause logic end ------- */
    
    /* ------ navigate to resultVC start ------ */
    private func navigateToResultVC(){
        let resultVC = storyboard?.instantiateViewController(identifier: ResultVC.storyBoardIdentifier) as! ResultVC
            
        resultVC.totalNoOfQuestion = questions.count
        resultVC.totalNoOfCorrectAns = totalCorrectAns
        
        navigationController?.pushViewController(resultVC, animated: true)
    }
    /* ------ navigate to resultVC end ------ */
    
    /* ------ get custome progress layer start ------ */
    private func getProgressLayer() -> CAShapeLayer{
        let center = CGPoint(x: customView.frame.width/2, y: customView.frame.height/2)
        let raduis = CGFloat(30)
        let customeShape = CustomeCircleShape(center: center, radius: raduis)
        let shape : CAShapeLayer = customeShape.customeShape()
        shape.strokeColor = CGColor(red: 1, green: 0.9, blue: 0, alpha: 1)
        shape.fillColor = nil
        shape.lineWidth = 5
        PROGRESS_LAYER.path = shape.path
        PROGRESS_LAYER.strokeColor = UIColor.systemBlue.cgColor
        PROGRESS_LAYER.lineWidth = 1
        PROGRESS_LAYER.fillColor = nil
        PROGRESS_LAYER.strokeEnd = 1
        return PROGRESS_LAYER
    }
    /* ------ get custome progress layer end ------ */
    
    /* ------ get questions logic start ------ */
    private func setQuestions(){
        //generate questions if valid noofquestion is given
        questions = generateQuestion(totalQuestion: noOfQuestions! , operations: operations!, range: getrange!)
        //check for current count which is not greater to total no of question
        if count < questions.count{
            if count == questions.count - 1{
                gotoResultVCBtn.setTitle(BTN_TITLE, for: .normal)
            }
            let question = questions[count]
            questionLabel.text = "\(String(describing: question.num1)) \(question.operand.rawValue) \(String(describing: question.num2)) = ?"
            //set the question number label
            questionNoLabel.text = "Question : \(String(describing: count+1))"
            //set the timer label
            timerLabel.text = String(timeCount)
            //start timer
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
        }
        else{
            //for stop the generate questions and also stop timer
            ansTF.isHidden = true
            timer.invalidate()
            //because if the submit btn clicked then also timer still running
            if navigationController?.topViewController == self{
                navigateToResultVC()
            }
        }
    }
    /* ------ get questions logic end ------ */
    
    @objc func keyboardWillShow(notification: Notification){
        //if keyboard show then
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            bottomBtnCon.constant = keyboardSize.height
        }
        
    }
    
    @objc func keyboardWillHide(){
        bottomBtnCon.constant = 150
    }
    
    
    /* ------ View Did Load function start ------ */
    override func viewDidLoad() {
        super.viewDidLoad()
        //adding custome progress layer to view
        customView.layer.addSublayer(getProgressLayer())
        //set time count based on range
        timeCount = getTimeCount(range: getrange)
        //set the palyer
        setPlayer()
        //set the navigation bar hidden
        self.navigationController?.navigationBar.isHidden = true
        //set the text field empty
        ansTF.text = ""
        //set the questions
        setQuestions()
        //handle keyboard from notification observer
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    /* ------ View Did Load function end ------ */
    
    /* ------ View Did Disapper function start ------ */
    override func viewDidDisappear(_ animated: Bool) {
        //set the player to nil
        player = nil
    }
    /* ------ View Did Disapper function end ------ */

    /* ------ deallocation of testVC from meomry start ------ */
    deinit {
        print("Test view controller's deinit called")
    }
    /* ------ deallocation of testVC from meomry end ------ */
    
}
