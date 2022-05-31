

import UIKit
import Kingfisher

class GameScreen: UIViewController {

    @IBOutlet weak var game_IMG_heart1: UIImageView!
    @IBOutlet weak var game_IMG_heart2: UIImageView!
    @IBOutlet weak var game_IMG_heart3: UIImageView!
    @IBOutlet weak var game_LBL_score: UILabel!
    @IBOutlet weak var game_IMG_image: UIImageView!
    @IBOutlet weak var game_BTN_ans1: UIButton!
    @IBOutlet weak var game_BTN_ans2: UIButton!
    @IBOutlet weak var game_BTN_ans3: UIButton!
    @IBOutlet weak var game_BTN_ans4: UIButton!
    
    
    var player: String = "Player"
    var score: Int = 0
    var mistakes: Int = 0
    var qIndex: Int = 0
    var questionsList = [Question]()
    var timer = Timer()
    
    let correctAnswers = ["Asics", "AT&T", "Cisco", "Delta", "F1", "Guinness", "Heartbrand", "Mastercard", "Nestle", "Pringles", "Quaker", "Rolex", "Toblerone", "United", "Walmart"]
    
    let photoLinks = ["https://i.ibb.co/xG7nDzM/asics.jpg",
                      "https://i.ibb.co/FVRqHHK/ATT.jpg",
                      "https://i.ibb.co/mtKTNs5/cisco.jpg",
                      "https://i.ibb.co/0qpDHng/delta.jpg",
                      "https://i.ibb.co/WspVkxz/F1.jpg",
                      "https://i.ibb.co/RCjCWyX/guinness.jpg",
                      "https://i.ibb.co/72VQRmZ/heart-Full.jpg",
                      "https://i.ibb.co/t37tmcj/mastercard.jpg",
                      "https://i.ibb.co/0BrLrg3/nestle.jpg",
                      "https://i.ibb.co/nkJGgWx/pringles.jpg",
                      "https://i.ibb.co/0Vm5rC9/quaker.jpg",
                      "https://i.ibb.co/cyt696c/rolex.jpg",
                      "https://i.ibb.co/6WsqbqL/toblerone.jpg",
                      "https://i.ibb.co/8xStytY/united.jpg",
                      "https://i.ibb.co/VgWxr00/walmart.jpg"]
    
    let wrongAnswers = ["Apple", "Amazon", "Walt Disney", "Toyota", "Louis Vuitton", "Intel", "GE", "Oracle", "Verizon", "IBM", "SAP", "Marlboro", "Budweiser", "American Express", "Pepsi", "Gucci", "L’Oreal",  "Hermes", "Nescafe", "Starbucks", "Accenture", "Gillette", "IKEA", "Frito-Lay", "Wells Fargo", "Siemens", "CVS", "Zara", "ESPN", "HSBC", "UPS", "J.P. Morgan", "Deloitte", "Chase", "Citi", "Porsche", "PwC", "Colgate", "Red Bull", "Lexus", "T-Mobile", "Santander", "Danone", "PayPal", "Chanel"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 196/255, green: 221/255, blue: 255/255, alpha: 1)

        initGame()
    }
    
    func initGame() {
        game_LBL_score.text = "0"
        for (answer, link) in zip(correctAnswers, photoLinks) {
            questionsList.append(Question(imageLink: link, answers: addPossibleAnswers(correct: answer)))
        }
        loadQuestion(question: questionsList[qIndex])
        restoreLives()
    }
    
    func addPossibleAnswers(correct: String) -> Array<Answer> {
        let tempWrong = randomAnswers()
        
        var answers = [Answer]()
        for player in tempWrong {
            answers.append(Answer(name: player, isTrue: false))
        }
        answers.append(Answer(name: correct, isTrue: true))
        answers.shuffle()
        
        return answers
    }
    
    private func randomAnswers() -> Array<String> {
        var resultSet = Set<String>()
        
        while resultSet.count < 3 {
            let randomIndex = Int(arc4random_uniform(UInt32(wrongAnswers.count)))
            resultSet.insert(wrongAnswers[randomIndex])
        }
        
        return Array(resultSet)
    }
    
    func loadQuestion(question: Question) {
        game_BTN_ans1.setTitle(question.answers[0].name, for: .normal)
        game_BTN_ans2.setTitle(question.answers[1].name, for: .normal)
        game_BTN_ans3.setTitle(question.answers[2].name, for: .normal)
        game_BTN_ans4.setTitle(question.answers[3].name, for: .normal)
        
        let uri = URL(string: question.imageLink)!
        game_IMG_image.kf.setImage(with: uri)
        
        qIndex += 1
    }
    
    func checkAnswer(question: Question, player: String) {
        if question.answers.contains(where: { $0.name == player && $0.isTrue}) {
            score += 50
            updateScore()
        }
        else {
            score -= 10
            mistakes += 1
            loseLives()
            updateScore()
        }
        colorAns(index: whatIsTheAns(question: question))
    }
    
    func loseLives() {
        switch mistakes {
        case 1:
            game_IMG_heart3.image = UIImage(named: "heartEmpty")
        case 2:
            game_IMG_heart2.image = UIImage(named: "heartEmpty")
            game_IMG_heart3.image = UIImage(named: "heartEmpty")
        case 3:
            game_IMG_heart1.image = UIImage(named: "heartEmpty")
            game_IMG_heart2.image = UIImage(named: "heartEmpty")
            game_IMG_heart3.image = UIImage(named: "heartEmpty")
        default:
            break
        }
    }
    
    func updateScore() {
        game_LBL_score.text = ("\(score)")
    }
    
    func restoreLives() {
        game_IMG_heart1.image = UIImage(named: "heartFull")
        game_IMG_heart2.image = UIImage(named: "heartFull")
        game_IMG_heart3.image = UIImage(named: "heartFull")
        
        mistakes = 0
    }
    
    func colorAns(index: Int) {
        switch index {
        case 1:
            game_BTN_ans1.tintColor = UIColor.green
            game_BTN_ans2.tintColor = UIColor.red
            game_BTN_ans3.tintColor = UIColor.red
            game_BTN_ans4.tintColor = UIColor.red
        case 2:
            game_BTN_ans1.tintColor = UIColor.red
            game_BTN_ans2.tintColor = UIColor.green
            game_BTN_ans3.tintColor = UIColor.red
            game_BTN_ans4.tintColor = UIColor.red
        case 3:
            game_BTN_ans1.tintColor = UIColor.red
            game_BTN_ans2.tintColor = UIColor.red
            game_BTN_ans3.tintColor = UIColor.green
            game_BTN_ans4.tintColor = UIColor.red
        case 4:
            game_BTN_ans1.tintColor = UIColor.red
            game_BTN_ans2.tintColor = UIColor.red
            game_BTN_ans3.tintColor = UIColor.red
            game_BTN_ans4.tintColor = UIColor.green
        default:
            break
        }
    }
    
    func checkGameOver() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 2,repeats: false , block: {_ in
            if self.qIndex < 15 && self.mistakes < 3 {
                self.loadQuestion(question: self.questionsList[self.qIndex])
                self.removeCol()
            }
            else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "gameover") as! GameOver
                vc.player = self.player
                vc.score = self.score
                self.present(vc, animated: true)
            }
        })
    }
    
    func whatIsTheAns(question: Question) -> Int{
        var counter = 0
        for ans in question.answers {
            counter += 1
            if ans.isTrue {
                return counter
            }
        }
        return 0
    }
    
    func removeCol() {
        game_BTN_ans1.tintColor = nil
        game_BTN_ans2.tintColor = nil
        game_BTN_ans3.tintColor = nil
        game_BTN_ans4.tintColor = nil
    }
    
    @IBAction func game_BTN_ans1(_ sender: Any) {
        checkAnswer(question: questionsList[qIndex-1], player: game_BTN_ans1.currentTitle!)
        checkGameOver()
    }
    
    @IBAction func game_BTN_ans2(_ sender: Any) {
        checkAnswer(question: questionsList[qIndex-1], player: game_BTN_ans2.currentTitle!)
        checkGameOver()
    }
    
    @IBAction func game_BTN_ans3(_ sender: Any) {
        checkAnswer(question: questionsList[qIndex-1], player: game_BTN_ans3.currentTitle!)
        checkGameOver()
    }
    
    @IBAction func game_BTN_ans4(_ sender: Any) {
        checkAnswer(question: questionsList[qIndex-1], player: game_BTN_ans4.currentTitle!)
        checkGameOver()
    }
    
    
    struct Question {
        let imageLink: String
        let answers: [Answer]
    }

    struct Answer {
        let name: String
        let isTrue: Bool
    }

    
}
