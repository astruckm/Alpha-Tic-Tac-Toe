//
//  GameBoard.swift
//  Alpha Tic-Tac-Toe
//
//  Created by ASM on 7/12/18.
//  Copyright © 2018 ASM. All rights reserved.
//

import Foundation

class GameBoard {
    //Is a var to allow changing its state
    var squares: [Square] = Square.allSquares
    
//    var columnOne: [Square] { return squares.filter({$0.column == 0}) }
//    var columnTwo: [Square] { return squares.filter({$0.column == 1}) }
//    var columnThree: [Square] { return squares.filter({$0.column == 2}) }
//    var rowOne: [Square] { return squares.filter({$0.row == 0}) }
//    var rowTwo: [Square] { return squares.filter({$0.row == 1}) }
//    var rowThree: [Square] { return squares.filter({$0.row == 2}) }
//    var diagonalLR: [Square] { return squares.filter({$0.isOnDiagonalLR}) }
//    var diagonalRL: [Square] { return squares.filter({$0.isOnDiagonalRL}) }
    
    
    //Deprecated****************
    var allSquares: [[Square.Position]] = [[.topLeft, .topMid, .topRight], [.midLeft, .midMid, .midRight], [.bottomLeft, .bottomMid,. bottomRight]]
    var squareStates: [[Square.State]] = [[.empty, .empty, .empty], [.empty, .empty, .empty], [.empty, .empty, .empty]]
    //**************************
    
    var winnablePairs: [[Square]] = [[]]
    
//    func trackWinnablePairs(forSquare square: Square, ofSide side: Square.State) {
//        guard side != .empty else { return }
//        var pair = [square]
//        guard let squareIndex = squares.index(of: square) else {
//            print("Error: square for trackWinnablePair(forSquare:ofSide:) was invalid")
//            return
//        }
//
//        let column = square.column
//        let row = square.row
//
//        //Indices to check horizontal/vertical pairs
//        let columnToRight = (column + 1) % squaresPerSide
//        let columnToLeft = (column + 2) % squaresPerSide
//        let rowBelow = (row + 1) % squaresPerSide
//        let rowAbove = (row + 2) % squaresPerSide
//
//        //column pairs
//        if (squares[squareIndex+1] == side && squareStates[row][columnToLeft] == .empty) {
//            pair.append(allSquares[row][columnToRight])
//            winnablePairs.append(pair)
//            return
//        } else if (squareStates[row][columnToLeft] == side && squareStates[row][columnToRight] == .empty) {
//            pair.append(allSquares[row][columnToLeft])
//            winnablePairs.append(pair)
//            return
//        }
//
//        row pairs
//        if (squareStates[rowBelow][column] == side && squareStates[rowAbove][column] == .empty) {
//            pair.append(allSquares[rowBelow][column])
//            winnablePairs.append(pair)
//            return
//        } else if (squareStates[rowAbove][column] == side && squareStates[rowBelow][column] == .empty) {
//            pair.append(allSquares[row][columnToLeft])
//            winnablePairs.append(pair)
//            return
//        }
//
//        //diagonal pairs: rawValue is either 0, 4, 8 OR 2, 4, 6---can use that to simplify this?
//        if square.isOnDiagonal {
//            //left to right diagonal
//            if square.row == square.column && squareStates[rowBelow][columnToRight] == side && squareStates[rowAbove][columnToLeft] == .empty {
//                pair.append(allSquares[rowBelow][columnToRight])
//                winnablePairs.append(pair)
//                return
//            } else if square.row == square.column && squareStates[rowAbove][columnToLeft] == side && squareStates[rowBelow][columnToRight] == .empty {
//                pair.append(allSquares[rowAbove][columnToLeft])
//                winnablePairs.append(pair)
//                return
//            }
//            //right to left diagonal
//            if squareStates[rowBelow][columnToLeft] == side && squareStates[rowAbove][columnToRight] == .empty {
//                pair.append(allSquares[rowBelow][columnToLeft])
//                winnablePairs.append(pair)
//                return
//            } else if squareStates[rowAbove][columnToRight] == side && squareStates[rowBelow][columnToLeft] == .empty {
//                pair.append(allSquares[rowAbove][columnToRight])
//                winnablePairs.append(pair)
//                return
//            }
//
//        }
//    }
    
    
}
