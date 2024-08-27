//
//  ContentView.swift
//  TicTacToe
//
//  Created by Thapat Auechaikasem on 26/8/67.
//

import SwiftUI

struct ContentView: View {
    
    @State private var board: [[String]] = Array(repeating: Array(repeating: "", count: 3), count: 3)
    @State private var currentplayer: String = "X"
    @State private var gameover: Bool = false
    @State private var winner: String?
    
    private func checkWin() -> Bool {
        
        for row in 0..<3 {
            if board[row][0] == currentplayer && board[row][1] == currentplayer && board[row][2] == currentplayer {
                return true
            }
        }
        
        for column in 0..<3 {
            if board[0][column] == currentplayer && board[1][column] == currentplayer && board[2][column] == currentplayer {
                return true
            }
        }
        
        if board[0][0] == currentplayer && board[1][1] == currentplayer && board[2][2] == currentplayer{
            return true
        }
        
        if board[0][2] == currentplayer && board[1][1] == currentplayer && board[2][0] == currentplayer{
            return true
        }
        
        return false
    }
    
    private func isboardfull() -> Bool {
        for row in board {
            if row.contains("") {
                return false
            }
        }
        return true
    }
    
    private func resetgame() {
        board = Array(repeating: Array(repeating: "", count: 3), count: 3)
        currentplayer = "X"
        gameover = false
        winner = nil
    }
    
    var body: some View {
        VStack {
            
            // Title
            Text("Tic Tac Toe")
                .font(.largeTitle)
                .fontDesign(.rounded)
                .padding()
            
            // Table
            ForEach (0..<3) { row in
                HStack {
                    ForEach(0..<3) { column in
                        Button(action: {
                            if self.board[row][column] == "" {
                                self.board[row][column] = self.currentplayer
                                if self.checkWin() {
                                    self.winner = self.currentplayer
                                    self.gameover = true
                                } else if self.isboardfull() {
                                    self.winner = "Draw"
                                    self.gameover = true
                                } else {
                                    self.currentplayer = self.currentplayer ==  "X" ? "O" : "X"
                                }
                            }
                        }){
                            Text(self.board[row][column])
                                .frame(width: 80,height: 80)
                                .background(Color.orange.opacity(0.5))
                                .font(.largeTitle)
                                .foregroundStyle(.black)
                                .border(Color.black, width: 2)
                                .fontDesign(.rounded)
                        }
                    }
                }
            }
            
            //result when over
            
            if gameover {
                VStack {
                    Text(winner == "Draw" ? "It's a Draw!" : "\(winner ?? "ERROR") Wins!")
                        .font(.headline)
                        .padding()
                }
                
                Button("Play Again") {
                    self.resetgame()
                }
                .padding()
                .background(Color.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
