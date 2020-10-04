//
//  GamePlayView.swift
//  Poker 5.0
//
//  Created by Daniel Pressner on 29.09.20.
//  Copyright © 2020 Daniel Pressner. All rights reserved.
//

import SwiftUI
import Combine

struct GamePlayView: View {
	
	@ObservedObject var gamePlayModel: GamePlayModel
	
	var subscriptions = Set<AnyCancellable>()
	
	var seatedPlayers: [Player] = []
	
    var body: some View {
		VStack {
			ZStack {
				HStack {
					VStack(spacing: 30) {
						if let player = gamePlayModel.getPlayer(forTablePosition: 4) {
							CombinedPlayerView(player: player, location: .left)
						}
						Spacer()
						if let player = gamePlayModel.getPlayer(forTablePosition: 2) {
							CombinedPlayerView(player: player, location: .left)
						}
						Spacer()
						if let player = gamePlayModel.getPlayer(forTablePosition: 7) {
							CombinedPlayerView(player: player, location: .left)
						}
					}
					Spacer()
					VStack {
						if let player = gamePlayModel.getPlayer(forTablePosition: 0) {
							CombinedPlayerView(player: player, location: .top)
						}
						Spacer()
						if let player = gamePlayModel.getPlayer(forTablePosition: 1) {
							CombinedPlayerView(player: player, location: .bottom)
						}
					}
					Spacer()
					VStack(spacing: 30) {
						if let player = gamePlayModel.getPlayer(forTablePosition: 6) {
							CombinedPlayerView(player: player, location: .right)
						}
						Spacer()
						if let player = gamePlayModel.getPlayer(forTablePosition: 3) {
							CombinedPlayerView(player: player, location: .right)
						}
						Spacer()
						if let player = gamePlayModel.getPlayer(forTablePosition: 5) {
							CombinedPlayerView(player: player, location: .right)
						}
					}
				}.padding()
				VStack {
					Spacer(minLength: 150)
					Text("Board(Card, Card, Card, Card, Card)")
					Spacer(minLength: 5)
					Text("Pot(can be multiple Pots)")
					Spacer(minLength: 150)
				}
			}
			VStack {
				Spacer()
				HStack {
					Button(action: {self.gamePlayModel.butt()}, label: {
						Text("Test player Publisher")
					})
					Text("Betting buttons")
				}
			}
		}
    }
}

struct GamePlayView_Previews: PreviewProvider {
    static var previews: some View {
		GamePlayView(gamePlayModel: GamePlayModel(numberOfPlayers: 8, chipCount: 1000)).previewLayout(.fixed(width: 650, height: 375))
		CombinedPlayerView(player: Player(name: "Dan", chipCount: 1000), location: .bottom)
    }
}

struct CombinedPlayerView: View {
	
	enum Layout {
		case left, right, top, bottom
	}
	
	@ObservedObject var player: Player
	var location: Layout
	
	
	var body: some View {
			VStack {
				if location == .bottom {
					VStack {
						if player.markerType != .none {
							MarkerView(markerType: player.markerType)
						}
						Text("Hand")
					}
				}
				HStack {
					if location == .right {
						HStack {
							if player.markerType != .none {
								MarkerView(markerType: player.markerType)
							}
							Text("Hand")
						}
					}
					PlayerView(player: player)
					if location == .left {
						HStack {
							Text("Hand")
							if player.markerType != .none {
								MarkerView(markerType: player.markerType)
							}
						}
					}
				}
				if location == .top {
					VStack {
						Text("Hand")
						if player.markerType != .none {
							MarkerView(markerType: player.markerType)
						}
					}
				}
			}
	}
}

