//
//  GameViewModel.swift
//  Poker 5.0
//
//  Created by Daniel Pressner on 29.09.20.
//  Copyright © 2020 Daniel Pressner. All rights reserved.
//

import Foundation
import Combine

class AppViewModel: ObservableObject {
	
	var appState: AppStates = .home {
		willSet {
			objectWillChange.send()
		}
	}
	@Published var numberOfPlayers: Int = 2
}

enum AppStates {
	case home, setup, inGame
}
