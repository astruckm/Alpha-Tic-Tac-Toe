//
//  ViewController.swift
//  Alpha Tic-Tac-To
//
//  Created by ASM on 7/9/18.
//  Copyright © 2018 ASM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var gameBoard: UIView!
    @IBOutlet weak var topLeftSquare: UIButton!
    @IBOutlet weak var topMidSquare: UIButton!
    @IBOutlet weak var topRightSquare: UIButton!
    @IBOutlet weak var midLeftSquare: UIButton!
    @IBOutlet weak var midMidSquare: UIButton!
    @IBOutlet weak var midRightSquare: UIButton!
    @IBOutlet weak var bottomLeftSquare: UIButton!
    @IBOutlet weak var bottomMidSquare: UIButton!
    @IBOutlet weak var bottomRightSquare: UIButton!
    
    var isXsTurn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameBoard.createTicTacToeBoard()
    }
    
    @IBAction func squareTapped(_ sender: UIButton) {
        updateUI()
        isXsTurn.toggle()
        print("\(sender) taken")
    }
    
    func updateUI() {
        let image = isXsTurn == true ? UIImage(named: "X.png") : UIImage(named: "O.png")
        sender.setImage(image, for: .normal)
    }
}









