//
//  PlayerViewModel.swift
//  Poker 5.0
//
//  Created by Daniel Pressner on 29.09.20.
//  Copyright © 2020 Daniel Pressner. All rights reserved.
//

import Foundation

class Player: ObservableObject, Identifiable, Equatable {
	static func == (lhs: Player, rhs: Player) -> Bool {
		lhs.id == rhs.id
	}
	
	let id = UUID()
	let name: String
	var chipCount: Int
    @Published var hand: [Card] = [] {
        didSet {
            if currentPlayer == true {
                for card in hand {
                    card.faceVisible = true
                }
            }
        }
    }
    var seatNumber: Int = 0
    @Published var markerType: MarkerView.MarkerType = .none
    @Published var currentPlayer = false
	@Published var folded = false
	@Published var disconnected = false
	@Published var outOfGame = false
    @Published var currentBet: Int?
    
	
	init(name: String, chipCount: Int) {
		self.name = name
		self.chipCount = chipCount
	}
}

class Players: ObservableObject {
    
    var allPlayers: [Player] = []
    var currentPlayers: [Player] {
        allPlayers.compactMap({$0}).filter({ $0.outOfGame == false }).sorted(by: { player1, player2 in
            player2.seatNumber < player1.seatNumber
        })
    }
    
    func generate(numberOfRandomPlayers count: Int, withChipCount amount: Int) {
        let names = ["Dan", "Kristen", "Nate", "Julia", "Andrew", "Lexi", "Mochi", "Papa", "Grandma"]
        for _ in 0..<count {
            let newPlayer = Player(name: names.randomElement()!, chipCount: amount)
            allPlayers.append(newPlayer)
        }
    }
    
}
