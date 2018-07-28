
import UIKit

class TicTacToeViewController: UIViewController {
    @IBOutlet weak var gameBoard: UIView!
    @IBOutlet weak var newGame: UIButton!
    @IBOutlet var squares: [UIButton]!
    
    var game = Game(playerWithFirstMove: .human)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        gameBoard.createTicTacToeBoard()        
    }
    
    @IBAction func squareTapped(_ sender: UIButton) {
        guard game.gameIsInProgress == true else { return }
        guard game.gameBoard.squares[sender.tag].state == .empty else { return }
        
        let image = game.isXsTurn == true ? UIImage(named: "X.png") : UIImage(named: "O.png")
        sender.setImage(image, for: .normal)
        let square = game.gameBoard.squares[sender.tag]
        game.humanMove(atSquare: square)
        
        //Wait withTimeInterval seconds before computer move appears
        let _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [unowned self] (timer) in
            self.updateUI()
            self.callAlertIfGameEnded()
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game = Game(playerWithFirstMove: .human)
        updateUI()
    }
    
    func setUpUI() {
        newGame.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        newGame.layer.borderWidth = 3
        newGame.layer.borderColor = UIColor.blue.cgColor
        newGame.layer.cornerRadius = 20
        newGame.titleLabel?.textColor = .black
    }
    
    func updateUI() {
        for square in squares {
            let squareState = game.gameBoard.squares[square.tag].state
            let oImage = UIImage(named: "O.png")
            let xImage = UIImage(named: "X.png")
            switch squareState {
            case .empty: square.setImage(nil, for: .normal)
            case .o: square.setImage(oImage, for: .normal)
            case .x: square.setImage(xImage, for: .normal)
            }
        }
    }
    
    private func callAlertIfGameEnded() {
        if !game.gameIsInProgress {
            let completionMessage: String
            if let winner = game.winner {
                let winnerText = winner == .human ? "X" : "O"
                completionMessage = "\(winnerText) is the winner!"
            } else {
                completionMessage = "Tie game."
            }
            callAlert(withMessage: completionMessage)
        }
    }
    
    private func callAlert(withMessage completionMessage: String?) {
        let alertVC = UIAlertController(title: completionMessage, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let endGameAction = UIAlertAction(title: "Reset", style: .default) { [unowned self ] action in
            self.game = Game(playerWithFirstMove: .human)
            self.updateUI()
        }
        alertVC.addAction(endGameAction)
        
        present(alertVC, animated: true)
    }
    
}







