//
//  DecryptionHandler.swift
//  Socket
//
//  Created by StarsDev on 04/01/2024.
//
import CommonCrypto
import Foundation
class DecryptionHandler : NSObject{
    static  func decryptionAESModeECB(messageData: String, key: String) -> String? {
        
        let key = key + "-00000"
        let dataKey = Data(messageData.utf8)
        guard let messageString = String(data: dataKey, encoding: .utf8) else { return nil }
        guard let data = Data(base64Encoded: messageString, options: .ignoreUnknownCharacters) else { return nil }
        guard let keyData = key.data(using: String.Encoding.utf8) else { return nil }
        guard let cryptData = NSMutableData(length: Int((data.count)) + kCCBlockSizeAES128) else { return nil }
        
        let keyLength               = size_t(kCCKeySizeAES128)
        let operation:  CCOperation = UInt32(kCCDecrypt)
        let algoritm:   CCAlgorithm = UInt32(kCCAlgorithmAES)
        let options:    CCOptions   = UInt32(kCCOptionECBMode + kCCOptionPKCS7Padding)
        let iv:         String      = ""
        
        var numBytesEncrypted: size_t = 0
        
        let cryptStatus = CCCrypt(operation,
                                  algoritm,
                                  options,
                                  (keyData as NSData).bytes, keyLength,
                                  iv,
                                  (data as NSData).bytes, data.count,
                                  cryptData.mutableBytes, cryptData.length,
                                  &numBytesEncrypted)
        if cryptStatus < 0 {
            return nil
            
        }else {
            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                var str = String(decoding : cryptData as Data, as: UTF8.self)
                
                if str.isEmpty {
                    return messageData
                }else {
                    str = str.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                    return str
                }
                
            } else {
                return messageData
            }
        }
    }
}





//    func decrypt(encryptedText: String, key: String) -> String? {
//        guard let keyData = key.data(using: .utf8) else {
//            print("Invalid key format")
//            return nil
//        }
//
//        let algorithm = CCAlgorithm(kCCAlgorithmAES)
//        let options = CCOptions(kCCOptionPKCS7Padding)
//
//        guard let encryptedData = Data(base64Encoded: encryptedText) else {
//            print("Invalid Base64 encoding")
//            return nil
//        }
//
//        var decryptedBytes = [UInt8](repeating: 0, count: encryptedData.count + kCCBlockSizeAES128)
//        var decryptedLength = 0
//
//        let status = keyData.withUnsafeBytes { keyBytes in
//            encryptedData.withUnsafeBytes { encryptedBytes in
//                CCCrypt(
//                    CCOperation(kCCDecrypt),
//                    algorithm,
//                    options,
//                    keyBytes.baseAddress,
//                    keyData.count,
//                    nil,
//                    encryptedBytes.baseAddress,
//                    encryptedData.count,
//                    &decryptedBytes,
//                    decryptedBytes.count,
//                    &decryptedLength
//                )
//            }
//        }
//
//        guard status == kCCSuccess else {
//            print("Decryption failed with status \(status)")
//            return nil
//        }
//
//        let decryptedData = Data(decryptedBytes.prefix(decryptedLength))
//
//        // Try converting with different character sets
//        if let decryptedString = String(data: decryptedData, encoding: .utf8) {
//            return decryptedString
//        } else if let decryptedString = String(data: decryptedData, encoding: .isoLatin1) {
//            return decryptedString
//        } else if let decryptedString = String(data: decryptedData, encoding: .utf16) {
//            return decryptedString
//        } else {
//            print("Failed to convert decrypted data to string")
//            print("Hexadecimal representation of decrypted data:")
//            decryptedData.forEach { byte in
//                print(String(format: "%02X", byte), terminator: " ")
//            }
//            return nil
//        }
//    }
//    private func handlePrivateMessage(data: [String: Any]) {
//        if let username = data["username"] as? String,
//           let encryptedMessage = data["message"] as? String,
//           let color = data["color"] as? String,
//           let receiverID = data["receiver"] as? Int,
//           let senderID = data["sender"] as? Int,
//           let key = data["time"] as? Int,
//           let timeHtml = data["time_html"] as? String {
//            print("Received private message from \(username): \(encryptedMessage)")
//
//            if let key = data["time"] as? Int {
//                let keyString = "\(key)-00000"
//
//                if let decryptedMessage = decrypt(encryptedText: encryptedMessage, key: keyString) {
//                    print("Decrypted message: \(decryptedMessage)")
//                    delegate?.addMessage("\(username): " + decryptedMessage, senderID: senderID, receiverID: receiverID)
//                }
//            }
//        }
//    }




//
//  ChatVC.swift
//  Socket
//
//  Created by StarsDev on 26/12/2023.

//import UIKit
//
//class ChatVC: UIViewController , SocketIOManagerDelegate{
//    
//    // MARK: - IBOutlet Properties
//    @IBOutlet private weak var messageTextField: UITextField!
//    @IBOutlet private weak var tableView: UITableView!
//    @IBOutlet weak var userNameLbl: UILabel!
//    @IBOutlet weak var typingLbl: UILabel!
//    @IBOutlet weak var onlineLbl: UILabel!
//    // MARK: - Variable Properties
//    let socketManager = SocketIOManager.sharedInstance
//    var messages: [String] = []
//    var accessToken = ""
//    var userName = ""
//    var sendMessagetoID = ""
//    var senderId: String?
//    // MARK: - OverRide Func
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        socketManager.delegate = self
//        userNameLbl.text = userName
//        addTapGestureToDismissKeyboard()
//
//        let socketManager = SocketIOManager.sharedInstance
//        socketManager.connectSocket()
//        let recipientID = ""
//        let userID = accessToken
//        let messageID = ""
//        socketManager.joinSocket(recipientID: recipientID, userID: userID, messageID: messageID) { success in
//            if success {
//                print("Join event sent successfully!")
//            } else {
//                print("Failed to send join event.")
//            }
//        }
//    }
//    // MARK: - Custom Methods
//    func addMessage(_ message: String, senderID: Int, receiverID: Int) {
//        print (senderID)
//        print(receiverID)
//        self.senderId = "\(senderID)"
//        messages.append(message)
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
//            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//        }
//    }
//    // MARK: - IBAction Methods
//    @IBAction private func sendButtonTapped(_ sender: Any) {
//        let socketManager = SocketIOManager.sharedInstance
//        if socketManager.isSocketConnected {
//            if let messageText = messageTextField.text, !messageText.isEmpty {
//                socketManager.sendPrivateMessage(
//                    toID: sendMessagetoID,
//                    fromID: accessToken,
//                    username: userName,
//                    message: messageText,
//                    color: "#056bba",
//                    isSticker: false,
//                    messageReplyID: ""
//                ){ success in
//                    if success {
//                        print("Private message sent successfully!")
//                    } else {
//                        print("Failed to send private message.")
//                    }
//                }
//                messages.append(messageText)
//                tableView.reloadData()
//                messageTextField.resignFirstResponder()
//                messageTextField.text = ""
//                updateTableViewHeight()
//            } else {
//                print("Message text is empty.")
//            }
//        } else {
//            print("Socket is not connected.")
//        }
//    }
//    
//    @IBAction func backBtn(_ sender: UIButton) {
//        navigationController?.popViewController(animated: true)
//    }
//}
//// MARK: - Extension Table View
//extension ChatVC: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return messages.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let message = messages[indexPath.row]
//        
//        if let senderId = senderId, sendMessagetoID == senderId {
//            // Message is from the current user
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
//            cell.messageLabel.text = message
//            cell.layer.borderWidth = 2
//            cell.layer.cornerRadius = 20
//            cell.layer.masksToBounds = true
//            cell.layer.borderColor = UIColor.white.cgColor
//            return cell
//        } else {
//            // Message is from another user
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell2", for: indexPath) as! MessageCell2
//            cell.massageLabel2.text = message
//            cell.layer.borderWidth = 2
//            cell.layer.cornerRadius = 20
//            cell.layer.masksToBounds = true
//            cell.layer.borderColor = UIColor.white.cgColor
//            return cell
//        }
//    }
//    func updateTableViewHeight() {
//        UIView.animate(withDuration: 0.3) {
//            self.view.layoutIfNeeded()
//        }
//    }
//}




//import Foundation
//import CommonCrypto
//import SocketIO
//import CryptoKit
//
//protocol SocketIOManagerDelegate: AnyObject {
//    func addMessage(_ message: String, senderID: Int, receiverID: Int)
//}
//class SocketIOManager: NSObject {
//    static let sharedInstance = SocketIOManager()
//    weak var delegate: SocketIOManagerDelegate?
//    let manager: SocketManager
//    var socket: SocketIOClient!
//    let decryptionHandler = DecryptionHandler()
//    override init() {
//        // Increase the connect timeout to 10 seconds
//        let config = SocketIOClientConfiguration(
//            arrayLiteral: .connectParams(["connect_timeout": 10000]),
//            .reconnects(true),
//            .reconnectAttempts(-1) // Infinite attempts
//        )
//        manager = SocketManager(socketURL: URL(string: "https://social.untamedoutback.com.au:3000/")!, config: config)
//        super.init()
//        socket = manager.defaultSocket
//        setupSocketHandlers()
//    }
//    private func setupSocketHandlers() {
//        print("Socket Status: \(self.socket.status)")
//        socket.on("join") { (data, ack) in
//            print("Socket Ack: \(ack)")
//            print("Emitted Data: \(data)")
//        }
//        socket.on(clientEvent: .connect) { type, emitter in
//            print("Socket Connected")
//            print("Socket Status: \(self.socket.status)")
//        }
//        socket.on("private_message") { [weak self] (data, ack) in
//            guard let self = self else { return }
//
//            if let messageData = data.first as? [String: Any] {
//                // Handle the private message data here
//                self.handlePrivateMessage(data: messageData)
//            }
//        }
//        socket.on(clientEvent: .disconnect) { (data, ack) in
//            print("Socket Disconnected")
//        }
//        socket.on("error") { data, ack in
//            print("Socket Error: \(data)")
//        }
//    }
//    private func handlePrivateMessage(data: [String: Any]) {
//        if let username = data["username"] as? String,
//            let encryptedMessage = data["message"] as? String,
//            let _ = data["color"] as? String,
//            let receiverID = data["receiver"] as? Int,
//            let senderID = data["sender"] as? Int,
//            let key = data["time"] as? Int,
//            let _ = data["time_html"] as? String {
//            // Decrypt the message using the decryption function
//            if let decryptedMessage = DecryptionHandler.decryptionAESModeECB(messageData: encryptedMessage, key: "\(key)-00000") {
//                print("Received private message from \(username): \(decryptedMessage)")
//                delegate?.addMessage("\(username): " + decryptedMessage, senderID: senderID, receiverID: receiverID)
//            } else {
//                print("Failed to decrypt message from \(username)")
//            }
//        }
//    }
//    func joinSocket(recipientID: String, userID: String, messageID: String, completion: @escaping (Bool) -> Void) {
//        guard isSocketConnected else {
//            print("Socket is not connected. Waiting for connection...")
//            // Set up a one-time event listener for the 'connect' event
//            socket.once(clientEvent: .connect) { [weak self] data, ack in
//                print("Socket connected!")
//                self?.emitJoinEvent(recipientID: recipientID, userID: userID, messageID: messageID, completion: completion)
//            }
//            connectSocket() // Connect the socket
//            return
//        }
//        emitJoinEvent(recipientID: recipientID, userID: userID, messageID: messageID, completion: completion)
//    }
//    private func emitJoinEvent(recipientID: String, userID: String, messageID: String, completion: @escaping (Bool) -> Void) {
//        let eventData: [String: Any] = [
//            "recipient_id": recipientID,
//            "user_id": userID,
//            "message_id": messageID
//        ]
//        socket.emit("join", eventData)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            completion(true) // Assume success for simplicity
//        }
//    }
//    func sendPrivateMessage(toID: String, fromID: String, username: String, message: String, color: String, isSticker: Bool, messageReplyID: String, completion: @escaping (Bool) -> Void) {
//        guard isSocketConnected else {
//            print("Socket Status: \(self.socket.status)")
//            print("Socket is not connected. Unable to emit 'private_message' event.")
//            completion(false)
//            return
//        }
//        let messageData: [String: Any] = [
//            "to_id": toID,
//            "from_id": fromID,
//            "username": username,
//            "msg": message,
//            "color": color,
//            "isSticker": isSticker,
//            "message_reply_id": messageReplyID
//        ]
//        socket.emitWithAck("private_message", messageData).timingOut(after: 0) { ackData in
//            if let ackDataDict = ackData.first as? [String: Any], ackDataDict["status"] as? Int == 200 {
//                // Message sent successfully
//                print("Private Message Sent Successfully!")
//                completion(true)
//            } else {
//                // Message sending failed
//                print("Failed to send private message.")
//                completion(false)
//            }
//        }
//    }
//    func connectSocket() {
//        socket.connect()
//    }
//    func closeConnection() {
//        socket.disconnect()
//        print("Disconnected from Socket!")
//    }
//    // Check if the socket is connected
//    var isSocketConnected: Bool {
//        print("Socket Status: \(socket.status)")
//        return socket.status == .connected
//    }
//}
