//
//  Card.swift
//  Poker 5.0
//
//  Created by Daniel Pressner on 29.09.20.
//  Copyright © 2020 Daniel Pressner. All rights reserved.
//

import SwiftUI

struct Card: View {
	
	@ObservedObject var vm: CardsModel
	
	private var frameSize: CGSize {
		switch vm.cardSize {
		case .large:
			return CGSize(width: 60, height: 80)
		case .small:
			return CGSize(width: 36, height: 48)
		}
	}
	
	private var imageSize: CGSize {
		switch vm.cardSize {
		case .large:
			 return CGSize(width: 17, height: 17)
		case .small:
			return CGSize(width: 13, height: 13)
		}
	}
	//MARK:- Body
    var body: some View {
		ZStack {
			cardBackground
			cardFace
			cardBack.opacity(vm.faceShowing ? 0.0 : 100.0)
		}.frame(width: frameSize.width, height: frameSize.height, alignment: .center)
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
		Card(vm: CardsModel(withCardData: CardData(suit: .hearts, value: .ten), cardSize: .large))
    }
}

extension Card {
	var cardBackground: some View {
		Rectangle()
		.foregroundColor(.white)
		.border(Color.gray, width: 1)
		.cornerRadius(4)
		.shadow(radius: 2)
	}
	
	var cardFace: some View {
		switch vm.cardSize {
		case .large:
			return AnyView(
				VStack(spacing: 0) {
					HStack {
						Text("\(vm.card.value.rawValue)").font(.body).foregroundColor(Color(vm.card.color))
							.padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 0))
						Spacer()
					}
					Spacer()
					Image(systemName: vm.card.image)
						.resizable()
						.frame(width: imageSize.width, height: imageSize.height, alignment: .center)
						.foregroundColor(Color(vm.card.color))
					Spacer()
					HStack {
						Spacer()
						Text("\(vm.card.value.rawValue)").font(.body).foregroundColor(Color(vm.card.color))
						.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 3))
					}
				})
		case .small:
			return AnyView(
				HStack(spacing: 0) {
					Text("\(vm.card.value.rawValue)").font(.body).foregroundColor(Color(vm.card.color))
					Image(systemName: vm.card.image)
						.resizable()
						.frame(width: imageSize.width, height: imageSize.height, alignment: .center)
						.foregroundColor(Color(vm.card.color))
			})
		}
	}
	
	var cardBack: some View {
		Image("CardBack")
		.resizable()
		.scaledToFit()
	}
}
