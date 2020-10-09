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
	
	@ObservedObject var tableModel: Table
    @EnvironmentObject var gameModel: GamePlayModel
    
	var subscriptions = Set<AnyCancellable>()
	
	var seatedPlayers: [Player] = []
	
    var body: some View {
		VStack {
			ZStack {
				HStack {
					VStack(spacing: 20) {
                        if let player = tableModel.getPlayer(atTablePosition: 2) {
                            CombinedPlayerView(player: player, location: .left)
						}
						Spacer()
                        if let player = tableModel.getPlayer(atTablePosition: 3) {
							CombinedPlayerView(player: player, location: .left)
						}
						Spacer()
                        if let player = tableModel.getPlayer(atTablePosition: 4) {
							CombinedPlayerView(player: player, location: .left)
						}
					}
					Spacer()
					VStack {
                        if let player = tableModel.getPlayer(atTablePosition: 1) {
							CombinedPlayerView(player: player, location: .top)
						}
						Spacer()
                        if let player = tableModel.getPlayer(atTablePosition: 5) {
							CombinedPlayerView(player: player, location: .bottom)
						}
					}
					Spacer()
					VStack(spacing: 20) {
                        if let player = tableModel.getPlayer(atTablePosition: 8) {
							CombinedPlayerView(player: player, location: .right)
						}
						Spacer()
                        if let player = tableModel.getPlayer(atTablePosition: 7) {
							CombinedPlayerView(player: player, location: .right)
						}
						Spacer()
                        if let player = tableModel.getPlayer(atTablePosition: 6) {
							CombinedPlayerView(player: player, location: .right)
						}
					}
				}.padding()
				VStack {
					Spacer()
                    BoardView(board: tableModel.cards, roundStage: .preFlop)
					Text("Pot(can be multiple Pots)")
                    HStack {
                        Button(action: {gameModel.butt()}, label: {
                            Text("Cycle Board")
                        })
                        Button(action: {}, label: {Text("Flip card test")})
                    }
					Spacer()
				}
			}
		}
    }
}

//struct GamePlayView_Previews: PreviewProvider {
//    static var previews: some View {
//		GamePlayView(gamePlayModel: GamePlayModel(numberOfPlayers: 8, chipCount: 1000)).previewLayout(.fixed(width: 650, height: 375))
//		CombinedPlayerView(player: Player(name: "Dan", chipCount: 1000), location: .right)
//    }
//}

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
                        if let bet = player.currentBet {
                            Text("\(bet)")
                        }
						if player.markerType != .none {
							MarkerView(markerType: player.markerType)
						}
					}
				}
				HStack {
					if location == .right {
						HStack {
                            if let bet = player.currentBet {
                                Text("\(bet)")
                            }
							if player.markerType != .none {
								MarkerView(markerType: player.markerType)
							}
                            HandView(hand: player.hand, faceVisible: player.currentPlayer)
						}
					}
					PlayerView(player: player)
                    if location != .right {
						HStack {
                            HandView(hand: player.hand, faceVisible: player.currentPlayer)
                            if player.markerType != .none && location == .left {
								MarkerView(markerType: player.markerType)
							}
                            if let bet = player.currentBet {
                                Text("\(bet)")
                            }
						}
					}
				}
				if location == .top {
					VStack {
						if player.markerType != .none {
							MarkerView(markerType: player.markerType)
						}
                        if let bet = player.currentBet {
                            Text("\(bet)")
                        }
					}
				}
			}
	}
}


struct HandView: View {
    
    var hand: [Card]
    var faceVisible: Bool
    var body: some View {
        HStack {
            ForEach(hand) { card in
                CardView(card: card)
            }
        }
    }
}

struct BoardView: View {
    
    var board: [Card]
    var roundStage: HandStage
    var numberOfCardsToShow: Int {
        switch roundStage {
        case .preFlop:
            return 0
        case .flop:
            return 3
        case .turn:
            return 4
        case .river:
            return 5
        }
    }
    
    var body: some View {
        HStack {
            ForEach(board.prefix(numberOfCardsToShow)) { card in
                CardView(card: toggleCardVisible(card: card))
            }
        }
    }
    
    func toggleCardVisible(card: Card) -> Card {
        card.faceVisible = true
        return card
    }
}


