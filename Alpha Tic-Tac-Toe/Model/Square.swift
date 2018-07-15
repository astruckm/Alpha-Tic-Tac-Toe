//
//  Square.swift
//  Alpha Tic-Tac-Toe
//
//  Created by ASM on 7/10/18.
//  Copyright © 2018 ASM. All rights reserved.
//

import Foundation

//For whole model, should I be working with row-column, or raw index (0-8)?

let squaresPerSide = 3

struct Square: Hashable {
    enum Position: Int, Hashable {
        case topLeft, topMid, topRight, midLeft, midMid, midRight, bottomLeft, bottomMid, bottomRight
        static var allPositions: [Position] = [.topLeft, .topMid, .topRight, .midLeft, .midMid, .midRight, .bottomLeft, .bottomMid, .bottomRight]
    }
    
    enum State: String, Equatable, Hashable {
        case empty, x, o
        
        var adversary: State? {
            switch self {
            case .empty: return nil
            case .x: return .o
            case .o: return .x
            }
        }
        
        static func == (lhs: State, rhs: State) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }
    }
    
    let position: Position
    var state: State
    var row: Int { return position.rawValue / squaresPerSide }
    var column: Int { return position.rawValue % squaresPerSide }
    var isOnDiagonalLR: Bool { return self.row == self.column }
    var isOnDiagonalRL: Bool { return (self.row + self.column == 2) }
    
    static let allSquares: [Square] = {
        var squares: [Square] = []
        for position in Position.allPositions {
            squares.append(Square(position: position, state: .empty))
        }
        return squares
    }()
    
}
