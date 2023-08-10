//
//  GameView.swift
//  TicTacToe
//
//  Created by ditthales on 09/08/23.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameEngine = GameEngine()
    
    let player: PlayerType
    
    var enemy: PlayerType{
        switch player {
        case .x:
            return .o
        case .o:
            return .x
        case .vazio:
            return .vazio
        }
    }
    
    let opacity = 0.8
    
    let gridItems: [GridItem] = Array(repeating: GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0), count: 3)
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Image(GameAssets.tabuleiroAsset)
                .resizable()
                .aspectRatio(contentMode: .fit)
            LazyVGrid(columns: gridItems, spacing: 0) {
                ForEach((0...9), id: \.self){ num in
                    if gameEngine.tabuleiro[num] == .vazio{
                        Image(GameAssets.celulaVazia)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }else if gameEngine.tabuleiro[num] == .x{
                        Image(player == .x ? GameAssets.jogador_X : GameAssets.adversario_X)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }else if gameEngine.tabuleiro[num] == .o{
                        Image(player == .o ? GameAssets.jogador_O : GameAssets.adversario_O)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .padding()
            }
            
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
            if player == .o{
                gameEngine.realizarJogada(jogador: .x, jogada: 0)
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    func touchProcessor(num: Int){
        print(num)
        let jogada = gameEngine.tabuleiro[num]
        gameEngine.realizarJogada(jogador: player, jogada: num)
        if !gameEngine.isGameOver() && (jogada != gameEngine.tabuleiro[num]) {
            if player == .x{
                gameEngine.jogada_O()
            }else{
                gameEngine.jogada_X()
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(player: .x)
    }
}
