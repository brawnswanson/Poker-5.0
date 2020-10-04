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
	var hand: [Card] = []
	@Published var markerType: MarkerView.MarkerType = .none
	@Published var currentPlayer = false
	@Published var folded = false
	@Published var disconnected = false
	@Published var outOfGame = false
	
	init(name: String, chipCount: Int) {
		self.name = name
		self.chipCount = chipCount
	}
}
