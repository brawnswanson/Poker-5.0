//
//  GamePlayModel.swift
//  Poker 5.0
//
//  Created by Daniel Pressner on 29.09.20.
//  Copyright © 2020 Daniel Pressner. All rights reserved.
//

import Foundation
import Combine

class GamePlayModel: ObservableObject {
	
	@Published var players: [Player] = []
	var subscriptions = Set<AnyCancellable>()
	let maxPlayers = 8
	var numberOfPlayers: Int = 0
	var playerOnButton: Player?
	
	init(numberOfPlayers: Int, chipCount: Int) {
		self.numberOfPlayers = numberOfPlayers
		//MARK:- set up table position array
		let names = ["Dan", "Kristen", "Nate", "Julia", "Andrew", "Lexi", "Mochi", "Papa", "Grandma"]
		
		var tempArray: [Player] = []
		 for _ in 0..<numberOfPlayers {
			tempArray.append(Player(name: names.randomElement()!, chipCount: 1000))
		}
		players = tempArray
		//moveMarkers(withCurrentButton: players.randomElement()!) //Setting initial markers with random player
	}
	
	func getPlayer(forTablePosition index: Int) -> Player? {
		if index < players.count { return players[index] }
		else { return nil }
	}
	
	func butt() {
		moveMarkers(withCurrentButton: players.first(where: { player in
			player.markerType == .button
		})!)
	}
	
	func moveMarkers(withCurrentButton player: Player) {
		//TODO:- Need to account for situation when only 2 players, or 2 active players
		//Reset currentPlayer flag
		for current in players {
			current.currentPlayer = false
			current.markerType = .none
		}
		//Move to next person in the array the one sent in function call
		//this player is the new button. Set the other items appropriately
		//noting that there is no button when down to 2 players.
		//TODO:- check for number of active players function
		//TODO:- get next active player function
		//TODO:- set the new flags
		//TODO:- test if I need to send objectwillchange
		let buttonPlayer = getNextPlayer(withCurrentPlayer: player)
		let smallBlindPlayer = getNextPlayer(withCurrentPlayer: buttonPlayer)
		let bigBlindPlayer = getNextPlayer(withCurrentPlayer: smallBlindPlayer)
		let currentPlayer = getNextPlayer(withCurrentPlayer: bigBlindPlayer)
		buttonPlayer.markerType = .button
		smallBlindPlayer.markerType = .smallBlind
		bigBlindPlayer.markerType = .bigBlind
		currentPlayer.currentPlayer = true
		objectWillChange.send()
	}
	
	func getNextPlayer(withCurrentPlayer player: Player) -> Player {
		var currentIndex = 1
		var foundNext = false
		while !foundNext {
			currentIndex = currentIndex + 1 < 8 ? currentIndex + 1 : 0
			if let _ = players.first(where: { player in
				player.outOfGame == false
			}) {
				foundNext = true
			}
		}
		return players.first(where: { player in
			player.chipCount == 0
		})!
	}
}
