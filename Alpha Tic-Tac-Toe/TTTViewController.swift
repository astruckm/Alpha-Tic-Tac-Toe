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
    @IBOutlet weak var start: UIButton!
    
    @IBOutlet var squares: [UIButton]!
    
    let playGame = PlayGame()
    var numberOfMovesPlayed = 0 {
        didSet {
            if oldValue % 2 == 0 {
                playGame.computerMove()
                updateUI()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        gameBoard.createTicTacToeBoard()
    }
    
    @IBAction func squareTapped(_ sender: UIButton) {
        let image = playGame.isXsTurn == true ? UIImage(named: "X.png") : UIImage(named: "O.png")
        sender.setImage(image, for: .normal)
        guard let square = Square(rawValue: sender.tag) else {
            print("Error initializing square with button's tag")
            return
        }
        playGame.humanMove(atSquare: square)
        numberOfMovesPlayed += 1
//        playGame.computerMove()
        
        print("Square with raw value \(sender.tag) taken")
        updateUI()
    }
    
    @IBAction func startGame(_ sender: UIButton) {
    }
    
    func setUpUI() {
        start.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        start.layer.borderWidth = 3
        start.layer.borderColor = UIColor.darkGray.cgColor
        start.layer.cornerRadius = 10
        start.titleLabel?.textColor = .black
    }
    
    func updateUI() {
        for square in squares {
            let row = square.tag / 3
            let column = square.tag % 3
            let squareState = playGame.gameBoard.squareStates[row][column]
            let oImage = UIImage(named: "O.png")
            let xImage = UIImage(named: "X.png")
            switch squareState {
            case .empty: square.setImage(nil, for: .normal)
            case .o: square.setImage(oImage, for: .normal)
            case .x: square.setImage(xImage, for: .normal)
            }
        }
        if playGame.winner != nil {
            let winnerMessage = "O or X is the winner!"
            let alert = UIAlertController(title: "Game Over!", message: winnerMessage, preferredStyle: UIAlertControllerStyle.alert)
            //Add UIAlertController
        }
    }
}







