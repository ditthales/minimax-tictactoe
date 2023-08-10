//
//  GameView.swift
//  TicTacToe
//
//  Created by ditthales on 09/08/23.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameEngine = GameEngine()
    
    let player: String
    
    var enemy: String{
        if player == "x"{
            return "o"
        }else{
            return "x"
        }
    }
    
    let opacity = 0.8
    
    let gridItems: [GridItem] = Array(repeating: GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0), count: 3)
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            LazyVGrid(columns: gridItems, spacing: 0) {
                ForEach((0...9), id: \.self){ num in
                    if gameEngine.tabuleiro[num] == ""{
                        Button{
                            touchProcessor(num: num)
                        }label: {
                            Image("celula_vazia")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                        
                    }else if gameEngine.tabuleiro[num] == "x"{
                        Button{
                            touchProcessor(num: num)
                        }label: {
                            Image("celula_x")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }else if gameEngine.tabuleiro[num] == "o"{
                        Button{
                            touchProcessor(num: num)
                        }label: {
                            Image("celula_o")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                }
            }
            .padding()
            if gameEngine.isGameOver(){
                ZStack{
                    if gameEngine.checarVitoria(jogador: player){
                        Color.green
                            .opacity(opacity)
                        VStack(spacing: 20){
                            Text("PARABÉNS VC GANHOU")
                            Button{
                                gameEngine.resetTabuleiro()
                                dismiss()
                            }label: {
                                Text("Jogar novamente")
                            }
                        }
                        
                    }else if gameEngine.checarVitoria(jogador: enemy){
                        Color.red
                            .opacity(opacity)
                        VStack(spacing: 20){
                            Text("PERDEU PRA IA KKKKKKKKKKK")
                            Button{
                                gameEngine.resetTabuleiro()
                                dismiss()
                            }label: {
                                Text("Jogar novamente")
                            }
                        }
                        
                    }else if gameEngine.checarEmpate(){
                        Color.yellow
                            .opacity(opacity)
                        VStack(spacing: 20){
                            Text("DEU EMPATE MEU BOM, TENTA DNV")
                            Button{
                                gameEngine.resetTabuleiro()
                                dismiss()
                            }label: {
                                Text("Jogar novamente")
                            }
                        }
                        
                    }
                }
            }
            
        }
        .onAppear{
            if player == "o"{
                gameEngine.realizarJogada(jogador: "x", jogada: 0)
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    func touchProcessor(num: Int){
        print(num)
        if player == "x"{
            let jogada = gameEngine.tabuleiro[num]
            gameEngine.realizarJogada(jogador: "x", jogada: num)
            if !gameEngine.isGameOver() && (jogada != gameEngine.tabuleiro[num]) {
                gameEngine.jogada_O()
            }
        }else{
            let jogada = gameEngine.tabuleiro[num]
            gameEngine.realizarJogada(jogador: "o", jogada: num)
            if !gameEngine.isGameOver() && (jogada != gameEngine.tabuleiro[num]){
                gameEngine.jogada_X()
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(player: "x")
    }
}
