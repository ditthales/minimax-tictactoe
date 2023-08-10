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
            Color(red: 32/255, green: 77/255, blue: 98/255)
                .padding(-30)
            Image(GameAssets.tabuleiroAsset)
                .resizable()
                .aspectRatio(contentMode: .fit)
            LazyVGrid(columns: gridItems, spacing: 0) {
                ForEach((0...9), id: \.self){ num in
                    if gameEngine.tabuleiro[num] == .vazio{
                        Button{
                            touchProcessor(num: num)
                        }label:{
                            Image(GameAssets.celulaVazia)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .padding()
                        }
                    }else if gameEngine.tabuleiro[num] == .x{
                        Button{
                            touchProcessor(num: num)
                        }label:{
                            Image(player == .x ? GameAssets.jogador_X : GameAssets.adversario_X)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .padding()
                        }
                    }else if gameEngine.tabuleiro[num] == .o{
                        Button{
                            touchProcessor(num: num)
                        }label:{
                            Image(player == .o ? GameAssets.jogador_O : GameAssets.adversario_O)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .padding()
                        }
                    }
                }
            }
            
            if gameEngine.isGameOver(){
                ZStack{
                    if gameEngine.checarVitoria(jogador: player){
                        Color.green
                            .opacity(opacity)
                        VStack(spacing: 20){
                            Text(GameTexts.ganhou)
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
                            Text(GameTexts.perdeu)
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
                            Text(GameTexts.empate)
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
        .padding(gameEngine.isGameOver() ? 0 : 20)
        .ignoresSafeArea()
    }
    
    func touchProcessor(num: Int){
        print(num)
        let jogada = gameEngine.tabuleiro[num]
        gameEngine.realizarJogada(jogador: player, jogada: num)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if !gameEngine.isGameOver() && (jogada != gameEngine.tabuleiro[num]) {
                if player == .x{
                    gameEngine.jogada_O()
                }else{
                    gameEngine.jogada_X()
                }
            }
        }
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(player: .x)
    }
}
