//
//  BetView.swift
//  Poker 5.0
//
//  Created by Daniel Pressner on 09.10.20.
//  Copyright © 2020 Daniel Pressner. All rights reserved.
//

import SwiftUI

struct BetView: View {
	
	@ObservedObject var bet: Bet
	@State var amount: Float = 0
	
    var body: some View {
		VStack {
			HStack {
				Slider(value: $amount, in: 0.0...1000.0, step: 1.0, onEditingChanged: {_ in})
				Text("\(Int(amount))")
			}
			HStack {
				Button(action: {}, label: {
					Text("Fold")
				})
				Button(action: {}, label: {
					Text("Call")
				})
				Button(action: {}, label: {
						Text("Bet")
				})
			}
		}.frame(width: 300, height: 100, alignment: .center)
		
    }
}

struct BetView_Previews: PreviewProvider {
    static var previews: some View {
        BetView(bet: Bet(player: Player(name: "Dan", chipCount: 1000), max: 1000, min: 5, call: 10))
    }
}
