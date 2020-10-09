//
//  Deck.swift
//  Poker 5.0
//
//  Created by Daniel Pressner on 09.10.20.
//  Copyright © 2020 Daniel Pressner. All rights reserved.
//

import Foundation

class Deck {
    var cards: [Card] = []
    var currentCardIndex = 0
    
    init() {
        for suit in Suit.allCases {
            for value in FaceValue.allCases {
                let card = Card(suit: suit, value: value)
                cards.append(card)
            }
        }
    }
}

extension Deck {
    
    func shuffle() {
        resetCardView()
        for _ in 1...7 {
            cards.shuffle()
        }
    }
    
    func cutCards() {
        let topHalf = Array(cards[0...25])
        let bottomHalf = Array(cards[26...51])
        cards = bottomHalf + topHalf
    }
    
    func resetCardView() {
        for card in cards {
            card.faceVisible = false
        }
    }
}
