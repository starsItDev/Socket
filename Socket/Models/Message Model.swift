//
//  Message Model.swift
//  Socket
//
//  Created by StarsDev on 12/01/2024.
//

 import Foundation
import UIKit
//struct ChatMessage {
//    var message: String
//    var time: String
//    var senderId: String
//    // Add any other properties you need
//
//    init(message: String, time: String, senderId: String) {
//        self.message = message
//        self.time = time
//        self.senderId = senderId
//    }
//}

enum MessageType {
    case text
    case image
}

class ChatMessage {
    var message: String
    var time: String
    var senderId: String
    var messageType: MessageType
    var image: UIImage? // Add this property for image messages

    init(message: String, time: String, senderId: String, messageType: MessageType = .text, image: UIImage? = nil) {
        self.message = message
        self.time = time
        self.senderId = senderId
        self.messageType = messageType
        self.image = image
    }
}
