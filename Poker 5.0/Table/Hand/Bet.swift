//
//  Bet.swift
//  Poker 5.0
//
//  Created by Daniel Pressner on 09.10.20.
//  Copyright © 2020 Daniel Pressner. All rights reserved.
//

import Foundation

class Bet: ObservableObject {
    
    let player: Player
    let maxBet: Int
    let minBet: Int
    let callAmount: Int
    
    init(player: Player, max: Int, min: Int, call: Int) {
        maxBet = max
        minBet = min
        callAmount = call
        self.player = player
    }

}
