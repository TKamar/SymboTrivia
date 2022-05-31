
import UIKit

class GameOver: UIViewController {
    
    @IBOutlet weak var scoreGame: UILabel!
    @IBOutlet weak var gameOver_BTN: UIButton!
    var player: String = ""
    var score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        viewTxt()
  
    }
    
    func viewTxt() {
        scoreGame.text = "Nice \(player)! Your score is: \(score) !"
    }
    
    @IBAction func tryAgain(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
        present(vc, animated: true)
        
    }
    

}
