
import Foundation

class ComputerMoves: TracksGameState {
    //MARK: Properties
    let playingAsX: Bool
    var side: Square.State { return playingAsX ? .x : .o }
    
    init(playingAsX: Bool) {
        self.playingAsX = playingAsX
    }

    //MARK: TracksGameState
    //Sub-types of playedSquares in extensions below
    var playedSquares: [Square] = []
    
    //MARK: Track important pairs/lines
    private var threateningPairs: [(Square, Square)] = []
    private var winnablePairs: [(Square, Square)] = []
    private var possibleWinningLineSquares: [[Square]] = []

    func updateImportantPairs() {
        threateningPairs = []
        winnablePairs = []
        possibleWinningLineSquares = []
        let rowsColumnsDiagonals = [playedSquaresFirstRow, playedSquaresSecondRow, playedSquaresThirdRow, playedSquaresFirstColumn, playedSquaresSecondColumn, playedSquaresThirdColumn, playedSquaresOnDiagonalLR, playedSquaresOnDiagonalRL]
        for line in rowsColumnsDiagonals {
            if line.count == 2 {
                if line[0].state == line[1].state && line[0].state == side.adversary {
                    threateningPairs.append((line[0], line[1]))
                } else if line[0].state == line[1].state && line[0].state == side {
                    winnablePairs.append((line[0], line[1]))
                }
            }
            if line.count == 1 && line[0].state == side {
                possibleWinningLineSquares.append(line)
            }
        }
    }
    
    
    //MARK: Methods called in Game
    
    //First move is in the center or otherwise in a corner
    func playFirstMove(humanMove: Square?) -> Square.Position {
        if let previousMove = humanMove, previousMove.position != .midMid {
            return .midMid
        }
        
        let random = Int(arc4random_uniform(4))
        let cornerPositionsRawValue = (random + (random / 2)) * 2
        if let position = Square.Position(rawValue: cornerPositionsRawValue) {
            return position
        }
        
        print("\nCould not initialize correct Square Position!\n")
        return .topLeft
    }
    
    //Priority of moves: 1. Win game if possible 2. Block human from winning 3. Threaten human from row or column (non-diagonal) 4. Threaten from diagonal 5. Finish a tie game
    func playNextMoves() -> Square.Position {
        if !winnablePairs.isEmpty {
            let winnablePair = winnablePairs[0]
            return fillOutImportantPair(winnablePair)
        }
        if !threateningPairs.isEmpty {
            let threateningPair = threateningPairs[0]
            return fillOutImportantPair(threateningPair)
        }
        if let randomOptimalSquare = playRandomOptimalRowColumn(), !possibleWinningLineSquares.isEmpty {
            return randomOptimalSquare
        }
        if let threateningDiagonal = playThreateningDiagonal() {
            return threateningDiagonal
        }
        
        return playRandomAvailableSquare()
    }
    
    //MARK: Sub-methods
    
    private func fillOutImportantPair(_ pair: (Square, Square)) -> Square.Position {
        guard !(threateningPairs.isEmpty && winnablePairs.isEmpty) else {
            print("blockOpponentsPair called erroneously")
            return .topLeft
        }
        
        let squareRawValue: Int
        let sumOfPairsRawValues = pair.0.position.rawValue + pair.1.position.rawValue
        //figure out total sum of rawValues in line, then subtract to get missing
        if pair.0.row == pair.1.row {
            squareRawValue = (((pair.0.row * squaresPerSide) + 1) * squaresPerSide) - sumOfPairsRawValues
        } else if pair.0.column == pair.1.column {
            squareRawValue = ((pair.0.column + squaresPerSide) * squaresPerSide) - sumOfPairsRawValues
        } else if (pair.0.isOnDiagonalLR && pair.1.isOnDiagonalLR) || pair.0.isOnDiagonalRL && pair.1.isOnDiagonalRL {
            squareRawValue = 12 - sumOfPairsRawValues
        } else {
            print("Error finding threateningPair to block!")
            squareRawValue = 0
        }
        guard let squareToBlock = Square.Position(rawValue: squareRawValue) else {
            print("squareToBlock calculated incorrectly")
            return .topLeft
        }
        return squareToBlock
    }
    
    private func playRandomOptimalRowColumn() -> Square.Position? {
        var testPositions = [0,1,2,3,4,5,6,7,8]
        while !testPositions.isEmpty {
            let position = generateRandomPosition()
            
            if !playedSquaresPositions.contains(position) {
                let possibleSquare = Square(position: position, state: side)
                //If position is on a possibleWinningLine that is column or row (not diagonal), return.
                for square in possibleWinningLineSquares {
                    let sumPossibleRawValues = square[0].position.rawValue + possibleSquare.position.rawValue
                    if square[0].row == possibleSquare.row {
                        let rowThirdSquareRawValue = (((possibleSquare.row * squaresPerSide) + 1) * squaresPerSide) - sumPossibleRawValues
                        if !playedSquaresIndices.contains(rowThirdSquareRawValue) {
                            
                            return position
                        }
                    }
                    if square[0].column == possibleSquare.column {
                        let rowThirdSquareRawValue = ((possibleSquare.column + squaresPerSide) * squaresPerSide) - sumPossibleRawValues
                        if !playedSquaresIndices.contains(rowThirdSquareRawValue) {
                            
                            return position
                        }
                    }
                }
            }
            
            if let index = testPositions.index(of: position.rawValue) {
                testPositions.remove(at: index)
            }
        }
        
        return nil
    }
    
    //If computer controls the middle square, play an empty diagonal that will prevent human from winning
    private func playThreateningDiagonal() -> Square.Position? {
        let possibleMiddleSquare = playedSquares.filter { $0.position == .midMid }
        if let possibleSide = possibleMiddleSquare.first?.state, possibleSide == side {
            let cornerPositionsRawValue = [0,2,6,8]
            for cornerValue in cornerPositionsRawValue {
                let rowIndex = cornerValue / squaresPerSide
                let columnIndex = cornerValue % squaresPerSide
                let numberplayedInRow = playedSquaresIndices.filter{($0/squaresPerSide) == rowIndex}.count
                let numberplayedInColumn = playedSquaresIndices.filter{($0%squaresPerSide) == columnIndex}.count
                //position has to be empty, and its row and column have to each have only one other square
                if let position = Square.Position(rawValue: cornerValue), !playedSquaresPositions.contains(position), numberplayedInRow <= 1, numberplayedInColumn <= 1 {
                    return position
                }
            }
        }
        return nil
    }
    
    //This if near end of game, there are no ways to win or threaten
    private func playRandomAvailableSquare() -> Square.Position {
        while true {
            let position = generateRandomPosition()
            
            if !playedSquaresPositions.contains(position) {
                return position
            }
        }
    }

    //TODO: abstract this more, so can take in any value, use for firstMove
    private func generateRandomPosition() -> Square.Position {
        let random = Int(arc4random_uniform(9))
        return Square.Position(rawValue: random)!
    }

    //TODO: abstract finding another rawValue in a row or column???
    
}

extension ComputerMoves {
    //Sub-types of playedSquares
    private var playedSquaresSet: Set<Square> { return Set(playedSquares) } //No duplicates
    private var playedSquaresPositions: [Square.Position] { return playedSquaresSet.map {$0.position} }
    private var playedSquaresIndices: [Int] { return playedSquaresPositions.map {$0.rawValue} }
}

extension ComputerMoves {
    //Track playedSquares within each line
    private var playedSquaresFirstRow: [Square] { return playedSquaresSet.filter {$0.position.rawValue / squaresPerSide == 0} }
    private var playedSquaresSecondRow: [Square] { return playedSquaresSet.filter {$0.position.rawValue / squaresPerSide == 1} }
    private var playedSquaresThirdRow: [Square] { return playedSquaresSet.filter {$0.position.rawValue / squaresPerSide == 2} }
    private var playedSquaresFirstColumn: [Square] { return playedSquaresSet.filter {$0.position.rawValue % squaresPerSide == 0} }
    private var playedSquaresSecondColumn: [Square] { return playedSquaresSet.filter {$0.position.rawValue % squaresPerSide == 1} }
    private var playedSquaresThirdColumn: [Square] { return playedSquaresSet.filter {$0.position.rawValue % squaresPerSide == 2} }
    private var playedSquaresOnDiagonalLR: [Square] { return playedSquaresSet.filter{$0.isOnDiagonalLR} }
    private var playedSquaresOnDiagonalRL: [Square] { return playedSquaresSet.filter{$0.isOnDiagonalRL} }
}


