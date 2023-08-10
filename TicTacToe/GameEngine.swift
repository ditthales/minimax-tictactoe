//
//  GameEngine.swift
//  TicTacToe
//
//  Created by ditthales on 09/08/23.
//

import Foundation

class GameEngine: ObservableObject{
    @Published var tabuleiro: [Int: PlayerType] = [
        0: .vazio, 1: .vazio, 2: .vazio,
        3: .vazio, 4: .vazio, 5: .vazio,
        6: .vazio, 7: .vazio, 8: .vazio,
    ]
    
    func resetTabuleiro(){
        tabuleiro = [
            0: .vazio, 1: .vazio, 2: .vazio,
            3: .vazio, 4: .vazio, 5: .vazio,
            6: .vazio, 7: .vazio, 8: .vazio,
        ]
    }
    
    func spaceIsFree(n: Int) -> Bool{
        if tabuleiro[n] == PlayerType.vazio{
            return true
        }
        return false
    }
    
    func isBoardEmpty() -> Bool{
        for v in tabuleiro.values{
            if v != PlayerType.vazio{
                return false
            }
        }
        return true
    }
    
    func realizarJogada(jogador: PlayerType, jogada: Int){
        if spaceIsFree(n: jogada){
            tabuleiro[jogada] = jogador
        }
    }
    
    func checarVitoria(jogador: PlayerType) -> Bool{
        if (tabuleiro[0] == tabuleiro[1] && tabuleiro [0] == tabuleiro[2] && tabuleiro[0] == jogador){
            return true
        }else if (tabuleiro[3] == tabuleiro[4] && tabuleiro [3] == tabuleiro[5] && tabuleiro[3] == jogador){
            return true
        }else if (tabuleiro[6] == tabuleiro[7] && tabuleiro [6] == tabuleiro[8] && tabuleiro[6] == jogador){
            return true
        }else if (tabuleiro[0] == tabuleiro[3] && tabuleiro [0] == tabuleiro[6] && tabuleiro[0] == jogador){
            return true
        }else if (tabuleiro[1] == tabuleiro[4] && tabuleiro [1] == tabuleiro[7] && tabuleiro[1] == jogador){
            return true
        }else if (tabuleiro[2] == tabuleiro[5] && tabuleiro [2] == tabuleiro[8] && tabuleiro[2] == jogador){
            return true
        }else if (tabuleiro[0] == tabuleiro[4] && tabuleiro [0] == tabuleiro[8] && tabuleiro[0] == jogador){
            return true
        }else if (tabuleiro[2] == tabuleiro[4] && tabuleiro [2] == tabuleiro[6] && tabuleiro[2] == jogador){
            return true
        }else{
            return false
        }
    }
    
    func checarEmpate() -> Bool {
        if !tabuleiro.values.contains(PlayerType.vazio) && !checarVitoria(jogador: .x) && !checarVitoria(jogador: .o) {
            return true
        }
        return false
    }
    
    func isGameOver() -> Bool{
        return checarVitoria(jogador: .x) || checarVitoria(jogador: .o) || checarEmpate()
    }

    func jogada_X(){
        var melhorScore = -1000
        var melhorJogada = 0
        
        for chave in tabuleiro.keys{
            if spaceIsFree(n: chave){
                tabuleiro[chave] = .x
                let score = minimax(isMaximizing: false)
                tabuleiro[chave] = PlayerType.vazio
                if (score > melhorScore){
                    melhorScore = score
                    melhorJogada = chave
                }
            }
        }
        realizarJogada(jogador: .x, jogada: melhorJogada)
    }

    func jogada_O(){
        var melhorScore = 1000
        var melhorJogada = 0
        
        for chave in tabuleiro.keys{
            if spaceIsFree(n: chave){
                tabuleiro[chave] = .o
                let score = minimax(isMaximizing: true)
                tabuleiro[chave] = PlayerType.vazio
                if (score < melhorScore){
                    melhorScore = score
                    melhorJogada = chave
                }
            }
        }
        realizarJogada(jogador: .o, jogada: melhorJogada)
    }
  
    func minimax(isMaximizing: Bool, metrica: Int = 0) -> Int{
        if checarVitoria(jogador: .x){
            return 100-metrica
        }else if checarVitoria(jogador: .o){
            return -100+metrica
        }else if checarEmpate(){
            return 0
        }
        
        
        if isMaximizing{
            var melhorScore = -1000
            
            for chave in tabuleiro.keys{
                if spaceIsFree(n: chave){
                    tabuleiro[chave] = .x
                    let score = minimax(isMaximizing: false, metrica: metrica + 1)
                    tabuleiro[chave] = PlayerType.vazio
                    if (score > melhorScore){
                        melhorScore = score
                    }
                }
            }
            return melhorScore
        }else{
            var melhorScore = 1000
            
            for chave in tabuleiro.keys{
                if spaceIsFree(n: chave){
                    tabuleiro[chave] = .o
                    let score = minimax(isMaximizing: true, metrica: metrica + 1)
                    tabuleiro[chave] = PlayerType.vazio
                    if (score < melhorScore){
                        melhorScore = score
                    }
                }
            }
            return melhorScore
        }
    }
        
    func vezDoX() -> Bool{
        var contX = 0
        var contO = 0
        
        for valor in tabuleiro.values{
            if valor == .x{
                contX += 1
            }
            if valor == .o{
                contO += 1
            }
        }
        return !(contX > contO)
    }
    

}
