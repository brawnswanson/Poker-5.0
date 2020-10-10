//
//  GameBoard.swift
//  Poker 5.0
//
//  Created by Daniel Pressner on 29.09.20.
//  Copyright © 2020 Daniel Pressner. All rights reserved.
//

import SwiftUI

struct AppView: View {
	
    @EnvironmentObject var gameModel: GamePlayModel
	@ObservedObject var viewModel: AppViewModel
	
    var body: some View {
		ZStack {
			Rectangle()
			.edgesIgnoringSafeArea(.all)
			.foregroundColor(Color("FeltGreen"))
			switch viewModel.appState {
			case .home:
				homeView
			case .setup:
				setupView
			case .inGame:
				gameView
			}
		}
    }
	
	var homeView: some View {
		VStack(spacing: 30) {
			Text("Poker Night")
				.font(.largeTitle)
				.fontWeight(.heavy)
			HStack {
				Button(action: { self.viewModel.appState = .setup }, label: {
					Text("Host Game")
				})
				Button(action: {}, label: {
					Text("Join Game")
				})
			}
		}
	}
	
	var setupView: some View {
		VStack {
			Spacer()
			Stepper("Number of Players: \(viewModel.numberOfPlayers)", value: $viewModel.numberOfPlayers, in: 2...8).padding()
			HStack {
				Text("Chips:")
				Slider(value: $viewModel.playerStake, in: 500.0...10000.0, step: 50.0, onEditingChanged: { _ in })
				Text("\(Int(viewModel.playerStake))")
			}.padding()
			HStack {
				Text("Blinds:")
				Slider(value: $viewModel.smallBlind, in: 10.0...viewModel.playerStake/2, step: 5.0, onEditingChanged: {_ in})
				Text("\(Int(viewModel.smallBlind))/\(Int(viewModel.smallBlind * 2))")
			}.padding()
			Button(action: { self.viewModel.appState = .home}, label: {
				Text("Cancel")
			})
			Button(action: {
					self.gameModel.startGame(numberOfPlayers: self.viewModel.numberOfPlayers, chipCount: Int(viewModel.playerStake), smallBlind: Int(viewModel.smallBlind))
                    self.viewModel.appState = .inGame}, label: {
				Text("Start Game")
			})
			Spacer()
		}
	}
	
	var gameView: some View {
        GamePlayView(tableModel: gameModel.table)
	}
}

struct GameBoard_Previews: PreviewProvider {
    static var previews: some View {
		AppView(viewModel: AppViewModel()).previewLayout(.fixed(width: 667, height: 375))
    }
}

