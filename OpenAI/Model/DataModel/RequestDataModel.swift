//
//  UserMessageDataModel.swift
//  OpenAI
//
//  Created by Eng.Omar Elsayed on 05/12/2023.
//

import Foundation

struct RequestData: Codable {
    var model: String
    var messages: [UserMessage]
    var temperature: Double = 0.2
}

struct UserMessage: Codable {
    var role: String = "user"
    var content: String
}
