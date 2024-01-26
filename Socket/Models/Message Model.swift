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
    case video // Add this case for video
}

class ChatMessage {
    var message: String
    var time: String
    var senderId: String
    var messageType: MessageType
    var image: UIImage?
    var videoURL: URL? // Add this property for video messages

    init(message: String, time: String, senderId: String, messageType: MessageType = .text, image: UIImage? = nil, videoURL: URL? = nil) {
        self.message = message
        self.time = time
        self.senderId = senderId
        self.messageType = messageType
        self.image = image
        self.videoURL = videoURL
    }
}
