//
//  InitialView.swift
//  TicTacToe
//
//  Created by ditthales on 10/08/23.
//

import SwiftUI

struct InitialView: View {
    var body: some View {
        NavigationStack{
            VStack(spacing: 30){
                Text(GameTexts.escolha)
                Text(GameTexts.xComeca)
                NavigationLink("Quero ser X", destination: GameView(gameEngine: GameEngine(), player: .x))
                NavigationLink("Quero ser O", destination: GameView(gameEngine: GameEngine(), player: .o))
            }
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
