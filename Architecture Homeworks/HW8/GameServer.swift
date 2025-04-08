//
//  GameServer.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 27.03.2025.
//

import Foundation

final class GameServer {
    
    // MARK: - Private methods
    
    private var games: [String: EventLoop]
    
    // MARK: - Init
    
    init(games: [String: EventLoop]) {
        self.games = games
    }
    
    // MARK: - Methods
    
    func receiveMessage(_ message: Data) {
        let decodedMessage = try? JSONDecoder().decode(MessageModel.self, from: message)
        sendMessageToGame(decodedMessage)
    }
    
    // MARK: - Private methods
    
    private func sendMessageToGame(_ message: MessageModel?) {
        guard let message = message else { return }
    
        games[message.gameId]?.append(
            InterpretCommand(
                objectId: message.objectId,
                commandId: message.commandId,
                args: message.args,
                eventLoop: games[message.gameId]
            )
        )
    }
}
