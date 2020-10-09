//
//  Card.swift
//  Poker 5.0
//
//  Created by Daniel Pressner on 29.09.20.
//  Copyright © 2020 Daniel Pressner. All rights reserved.
//

import SwiftUI

struct CardView: View {
	
    @ObservedObject var card: Card
    
    private var frameSize: CGSize { CGSize(width: 32, height: 42.67) }
	private var imageSize: CGSize { CGSize(width: 8, height: 8) }
	//MARK:- Body
    var body: some View {
        EmptyView()
		ZStack {
            cardBackground
            cardFace.opacity(card.faceVisible ? 100.0 : 0.0)
            cardBack.opacity(card.faceVisible ? 0.0 : 100.0)
        }.frame(width: frameSize.width, height: frameSize.height, alignment: .center)
    }
}
//
//struct Card_Previews: PreviewProvider {
//    static var previews: some View {
//		Card(vm: CardsModel(withCardData: CardData(suit: .hearts, value: .ten), cardSize: .large))
//    }
//}
//
extension CardView {
    var cardBackground: some View {
        ZStack {
            Rectangle()
            .foregroundColor(.white)
            .border(Color.gray, width: 1)
            .cornerRadius(4)
            .shadow(radius: 2)
        }.frame(width: frameSize.width, height: frameSize.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
    
    var cardFace: some View {
        AnyView(
            VStack(spacing: 0) {
                HStack {
                    Text("\(card.value.rawValue)").font(.footnote).foregroundColor(Color(card.color))
                        .padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 0))
                    Spacer()
                }
                Image(systemName: card.image)
                    .resizable()
                    .frame(width: imageSize.width, height: imageSize.height, alignment: .center)
                    .foregroundColor(Color(card.color))
                HStack {
                    Spacer()
                    Text("\(card.value.rawValue)").font(.footnote).foregroundColor(Color(card.color))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 3))
                }
            }
        )
    }
    
    var cardBack: some View {
        Image("CardBack")
        .resizable()
        .scaledToFit()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(suit: .clubs, value: .ten))
    }
}
