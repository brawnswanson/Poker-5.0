//
//  Table.swift
//  Poker 5.0
//
//  Created by Daniel Pressner on 08.10.20.
//  Copyright © 2020 Daniel Pressner. All rights reserved.
//

import Foundation
import Combine

class Table: ObservableObject {
    
    @Published var cards: [Card] = []
    @Published var players = Players()
    @Published var handStage: HandStage = .preFlop
    var hands: [Hand] = []
    
    var subscriptions = Set<AnyCancellable>()
    
    var deck = Deck()
    var smallBlindPlayer: Player?
    var bigBlindPlayer: Player?
    var buttonPlayer: Player?
    var currentPlayer: Player?
    let tablePositions: [Int] = [1,5,3,7,8,4,2,6]
	var smallBlind: Int = 0
    
	func setupGame(numberOfPlayers: Int, withChipCount: Int, smallBlind: Int) {
		self.smallBlind = smallBlind
        players.generate(numberOfRandomPlayers: numberOfPlayers, withChipCount: withChipCount)
        seatPlayers()
        setInitialMarkers()
    }
    
    func startHand() {
        clearCardsFromTable()
		if let player = smallBlindPlayer {
			player.currentBet = smallBlind
		}
		if let player = bigBlindPlayer {
			player.currentBet = smallBlind * 2
		}
		//TODO:- take blinds from players to start the betting
        shuffleAndDeal()
        
        print("let's go!")
    }
}

extension Table {
    //MARK:- Table setup functions
    func setInitialMarkers() {
        smallBlindPlayer = players.currentPlayers.randomElement()!
        smallBlindPlayer!.markerType = .smallBlind
        let smallBlindIndex = players.currentPlayers.firstIndex(of: smallBlindPlayer!)!
        let bigBlindIndex = smallBlindIndex + 1 < players.currentPlayers.count ? smallBlindIndex + 1 : 0
        bigBlindPlayer = players.currentPlayers[bigBlindIndex]
        bigBlindPlayer!.markerType = .bigBlind
        if players.currentPlayers.count > 3 {
            let buttonIndex = smallBlindIndex - 1 < 0 ? players.currentPlayers.count - 1 : smallBlindIndex - 1
            buttonPlayer = players.currentPlayers[buttonIndex]
            buttonPlayer!.markerType = .button
            let currentPlayerIndex = bigBlindIndex + 1 < players.currentPlayers.count ? bigBlindIndex + 1 : 0
            currentPlayer = players.currentPlayers[currentPlayerIndex]
            currentPlayer!.currentPlayer = true
        }
        else {
            buttonPlayer = smallBlindPlayer
            currentPlayer = smallBlindPlayer
            smallBlindPlayer!.currentPlayer = true
        }
    }
    
    func seatPlayers() {
        var currentIndex = 0
        print(players.allPlayers.count)
        for player in players.allPlayers {
            player.seatNumber = tablePositions[currentIndex]
            currentIndex += 1
        }
        objectWillChange.send()
    }
}

extension Table {
    //MARK:- Player Utility functions
    func getPlayer(atTablePosition positionNumber: Int) -> Player? {
        if let player = players.allPlayers.first(where: { $0.seatNumber == positionNumber }) {
            return player
        }
        else { return nil }
    }
}

extension Table {
    //MARK:- Card utility functions
    func clearCardsFromTable() {
        cards = []
        for player in players.currentPlayers {
            player.hand = []
        }
    }
    
    func shuffleAndDeal() {
        var dealingArray: [Player] = []
        if let currentSmallBlind = smallBlindPlayer {
            let firstHalfOfDealArray = Array(players.currentPlayers.prefix(upTo: players.currentPlayers.firstIndex(of: currentSmallBlind)!))
            let secondHalfOfDealArray = Array(players.currentPlayers.suffix(from: players.currentPlayers.firstIndex(of: currentSmallBlind)!))
            dealingArray = secondHalfOfDealArray + firstHalfOfDealArray
        }
        clearCardsFromTable()
        deck.shuffle()
        deck.cutCards()
        let cardsPublisher = PassthroughSubject<Card, Never>()
        let dealAnimationPublisher = Timer.publish(every: 0.2, on: .main, in: .default)
        
        //Deal player cards
        for player in players.currentPlayers {
            let pub1 = cardsPublisher
                .output(at: dealingArray.firstIndex(of: player)!)
            let pub2 = cardsPublisher
                .output(at: dealingArray.firstIndex(of: player)! + players.currentPlayers.count)
            pub1.merge(with: pub2)
                .sink(receiveValue: { player.hand.append($0) })
                .store(in: &subscriptions)
        }
        
        //Deal cards to board
        cardsPublisher
            .dropFirst(players.currentPlayers.count * 2)
            .prefix(5)
            .sink(receiveValue: { self.cards.append($0)})
            .store(in: &subscriptions)
        
        dealAnimationPublisher.subscribe(DealAnimationSubscriber(numberOfCardsToDeal: players.currentPlayers.count * 2 + 5, deck: deck, cardPublisher: cardsPublisher))
        dealAnimationPublisher.connect().store(in: &subscriptions)
    }
}

class DealAnimationSubscriber: Subscriber {
    typealias Input = Date
    typealias Failure = Never
    let howManyCards: Int
    var currentCount: Int = 0
    let deck: Deck
    let cardsPublisher: PassthroughSubject<Card, Never>
    
    init(numberOfCardsToDeal count: Int, deck: Deck, cardPublisher: PassthroughSubject<Card, Never>) {
        howManyCards = count
        self.deck = deck
        self.cardsPublisher = cardPublisher
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.max(howManyCards))
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        
    }
    
    func receive(_ input: Date) -> Subscribers.Demand {
        cardsPublisher.send(deck.cards[currentCount])
        currentCount += 1
        return .none
    }
}

enum HandStage {
    case preFlop, flop, turn, river
}
