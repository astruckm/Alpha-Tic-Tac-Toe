//
//  GameBoard.swift
//  Alpha Tic-Tac-Toe
//
//  Created by ASM on 7/12/18.
//  Copyright © 2018 ASM. All rights reserved.
//

import Foundation

class GameBoard {
    let squares: [Square] = Square.allSquares
    
    //Deprecated
    var allSquares: [[Square.Position]] = [[.topLeft, .topMid, .topRight], [.midLeft, .midMid, .midRight], [.bottomLeft, .bottomMid,. bottomRight]]
    //2x2 array to represent rows and columns
    var squareStates: [[Square.State]] = [[.empty, .empty, .empty], [.empty, .empty, .empty], [.empty, .empty, .empty]]
    
    var winnablePairs: [[Square]] = [[]]
    
    func trackWinnablePairs(forSquare square: Square, ofSide side: Square.State) {
        guard side != .empty else { return }
        var pair = [square]
        let column = square.column
        let row = square.row
        
        //Indices to check horizontal/vertical pairs
        let columnToRight = (column + 1) % squaresPerSide
        let columnToLeft = (column + 2) % squaresPerSide
        let rowBelow = (row + 1) % squaresPerSide
        let rowAbove = (row + 2) % squaresPerSide
        
        //column pairs
        if (squareStates[row][columnToRight] == side && squareStates[row][columnToLeft] == .empty) {
            pair.append(allSquares[row][columnToRight])
            winnablePairs.append(pair)
            return
        } else if (squareStates[row][columnToLeft] == side && squareStates[row][columnToRight] == .empty) {
            pair.append(allSquares[row][columnToLeft])
            winnablePairs.append(pair)
            return
        }
        
        //row pairs
        if (squareStates[rowBelow][column] == side && squareStates[rowAbove][column] == .empty) {
            pair.append(allSquares[rowBelow][column])
            winnablePairs.append(pair)
            return
        } else if (squareStates[rowAbove][column] == side && squareStates[rowBelow][column] == .empty) {
            pair.append(allSquares[row][columnToLeft])
            winnablePairs.append(pair)
            return
        }
        
        //diagonal pairs: rawValue is either 0, 4, 8 OR 2, 4, 6---can use that to simplify this?
        if square.isOnDiagonal {
            //left to right diagonal
            if square.row == square.column && squareStates[rowBelow][columnToRight] == side && squareStates[rowAbove][columnToLeft] == .empty {
                pair.append(allSquares[rowBelow][columnToRight])
                winnablePairs.append(pair)
                return
            } else if square.row == square.column && squareStates[rowAbove][columnToLeft] == side && squareStates[rowBelow][columnToRight] == .empty {
                pair.append(allSquares[rowAbove][columnToLeft])
                winnablePairs.append(pair)
                return
            }
            //right to left diagonal
            if squareStates[rowBelow][columnToLeft] == side && squareStates[rowAbove][columnToRight] == .empty {
                pair.append(allSquares[rowBelow][columnToLeft])
                winnablePairs.append(pair)
                return
            } else if squareStates[rowAbove][columnToRight] == side && squareStates[rowBelow][columnToLeft] == .empty {
                pair.append(allSquares[rowAbove][columnToRight])
                winnablePairs.append(pair)
                return
            }
            
        }
    }
    
    //make properties for each row, column, and diagonal?
    
}
