//
//  MarkerView.swift
//  Poker 5.0
//
//  Created by Daniel Pressner on 01.10.20.
//  Copyright © 2020 Daniel Pressner. All rights reserved.
//

import SwiftUI

struct MarkerView: View {
	
	var markerType: MarkerType {
		didSet {
			print("marker")
		}
	}
		
		var body: some View {
			if markerType == .none {
				EmptyView()
			}
			else {
			ZStack {
				Circle()
				if markerType == .button {
					Circle().frame(width: 20, height: 20, alignment: .center)
						.foregroundColor(.white)
				}
				Text("\(markerType == .button ? "D" : markerType == .smallBlind ? "S" : "B")").font(.title2)
					.foregroundColor(markerType != .button ? .white : .black)
			}.frame(width: 25, height: 25, alignment: .center)
		}
		
    }
}

struct MarkerView_Previews: PreviewProvider {
    static var previews: some View {
		MarkerView(markerType: .smallBlind)
    }
}

extension MarkerView {
	enum MarkerType {
		case button, smallBlind, bigBlind, none
	}
}
