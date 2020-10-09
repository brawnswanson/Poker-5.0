//
//  CardData.swift
//  Poker 5.0
//
//  Created by Daniel Pressner on 29.09.20.
//  Copyright © 2020 Daniel Pressner. All rights reserved.
//

import Foundation
import Combine

class Card: Identifiable, ObservableObject {
    
    let id = UUID()
	let suit: Suit
	let value: FaceValue
    @Published var faceVisible = false
	var image: String {
		switch suit {
			case .hearts:
				return "suit.heart.fill"
			case .diamonds:
				return "suit.diamond.fill"
			case .spades:
				return "suit.spade.fill"
			case .clubs:
				return "suit.club.fill"
		}
	}
	var color: String {
		switch suit {
		case .hearts, .diamonds:
			return "SuitRed"
		case .spades, .clubs:
			return "SuitBlack"
		}
	}
    
    init(suit: Suit, value: FaceValue) {
        self.suit = suit
        self.value = value
    }
}

extension Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.id == rhs.id
    }
}

enum Suit: String, CaseIterable {
	case hearts, spades, diamonds, clubs
}

enum FaceValue: String, CaseIterable {
	case two = "2", three = "3", four = "4", five = "5", six = "6", seven = "7", eight = "8", nine = "9", ten = "10", jack = "J", queen = "Q", king = "K", ace = "A"
	
	func numericValue(aceHigh: Bool) -> Int {
		switch self {
		case .ace:
			return aceHigh ? 14 : 1
		case .two:
			return 2
		case .three:
			return 3
		case .four:
			return 4
		case .five:
			return 5
		case .six:
			return 6
		case .seven:
			return 7
		case .eight:
			return 8
		case .nine:
			return 9
		case .ten:
			return 10
		case .jack:
			return 11
		case .queen:
			return 12
		case .king:
			return 13
		}
	}
}
