//
//  Message.swift
//  constraints_exercise_3
//
//  Created by Sofia Carena on 19/11/2021.
//

import Foundation

struct Message: Decodable {
    var username: String
    var message: String
    var timeMessage: String
    
    enum CodingKeys: String, CodingKey {
        case username, message, timeMessage
    }
}
