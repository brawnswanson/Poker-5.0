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
	
    @Published var table = Table()
    
    func startGame(numberOfPlayers: Int, chipCount:Int) {
        table.setupGame(numberOfPlayers: numberOfPlayers, withChipCount: chipCount)
        table.startHand()
    }
    
    func butt() {}
}
