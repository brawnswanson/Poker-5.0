//
//  PlayerView.swift
//  Poker 5.0
//
//  Created by Daniel Pressner on 29.09.20.
//  Copyright © 2020 Daniel Pressner. All rights reserved.
//

import SwiftUI

struct PlayerView: View {
	
	@ObservedObject var player: Player
    
	var body: some View {
		//TODO:- Player Compact View and large player view needed
		HStack {
			VStack {
				Text("\(player.name)")
				Text("$\(player.chipCount)")
			}
		}
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(player: Player(name: "Dan", chipCount: 1000))
    }
}
