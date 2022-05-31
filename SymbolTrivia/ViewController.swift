
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func getPlayerName(_ sender: Any) {
        if (playerName.text == "") {
            playerName.text = "Player"
        }
    
    let vc = storyboard?.instantiateViewController(withIdentifier: "game") as! GameScreen
    vc.player = playerName.text!
    present(vc, animated: true)
    
    
    }

}


