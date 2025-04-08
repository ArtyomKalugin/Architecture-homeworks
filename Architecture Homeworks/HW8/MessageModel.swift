//
//  MessageModel.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 27.03.2025.
//

import Foundation

struct MessageModel: Codable {
    var gameId: String
    var objectId: String
    var commandId: String
    var args: [String]
}
