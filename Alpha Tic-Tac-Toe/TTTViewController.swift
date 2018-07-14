//
//  ViewController.swift
//  Alpha Tic-Tac-To
//
//  Created by ASM on 7/9/18.
//  Copyright © 2018 ASM. All rights reserved.
//

import UIKit

class TicTacToeViewController: UIViewController {
    @IBOutlet weak var gameBoard: UIView!
    @IBOutlet weak var newGame: UIButton!
    
    @IBOutlet var squares: [UIButton]!
    
    var game = Game()
    var gameIsInProgress = false
    var numberOfMovesPlayed = 0 /*{
        didSet {
            if oldValue % 2 == 0 {
                updateUI()
                numberOfMovesPlayed += 1
            }
        }
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        gameBoard.createTicTacToeBoard()        
    }
    
    @IBAction func squareTapped(_ sender: UIButton) {
        guard gameIsInProgress == true else { return }
        guard game.gameBoard.squares[sender.tag].state == .empty else { return }
        
        let image = game.isXsTurn == true ? UIImage(named: "X.png") : UIImage(named: "O.png")
        sender.setImage(image, for: .normal)
        let square = game.gameBoard.squares[sender.tag]
        game.humanMove(atSquare: square)
        numberOfMovesPlayed += 1
        
        let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [unowned self] (timer) in
            self.updateUI()
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        gameIsInProgress = true
        game = Game()
        updateUI()
    }
    
    func setUpUI() {
        newGame.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        newGame.layer.borderWidth = 3
        newGame.layer.borderColor = UIColor.darkGray.cgColor
        newGame.layer.cornerRadius = 10
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
        if game.winner != nil {
//            let winnerMessage = "O or X is the winner!"
//            let alert = UIAlertController(title: "Game Over!", message: winnerMessage, preferredStyle: UIAlertControllerStyle.alert)
        }
    }
}







