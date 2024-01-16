//import UIKit
//import MessageKit
//
//struct Sender: SenderType {
//    var senderId: String
//    var displayName: String
//}
//
//struct Message: MessageType {
//    var sender: SenderType
//    var messageId: String
//    var sentDate: Date
//    var kind: MessageKind
//}
//
//class MessageKitVC: MessagesViewController {
//
//    var messages: [MessageType] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Set yourself as the delegate and datasource
//        messagesCollectionView.messagesDataSource = self
//        messagesCollectionView.messagesLayoutDelegate = self
//        messagesCollectionView.messagesDisplayDelegate = self
//
//        // Initial messages
//        messages.append(Message(sender: Sender(senderId: "1", displayName: "John"), messageId: "1", sentDate: Date(), kind: .text("Hello, how are you?")))
//        messages.append(Message(sender: Sender(senderId: "2", displayName: "Jane"), messageId: "2", sentDate: Date(), kind: .text("Hi, I'm good. How about you?")))
//        
//        // Reload the messages view
//        messagesCollectionView.reloadData()
//        messagesCollectionView.scrollToLastItem(animated: true)
//        
//        // Simulate sending more messages after a delay
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.sendMoreMessages()
//        }
//    }
//
//    func sendMoreMessages() {
//        let newMessage1 = Message(sender: Sender(senderId: "1", displayName: "John"), messageId: "3", sentDate: Date(), kind: .text("I'm doing well, thanks!"))
//        let newMessage2 = Message(sender: Sender(senderId: "2", displayName: "Jane"), messageId: "4", sentDate: Date(), kind: .text("That's great to hear!That's great to hear!That's great to hear!That's great to hear!That's great to hear!"))
//        
//        // Add new messages
//        messages.append(newMessage1)
//        messages.append(newMessage2)
//        
//        // Reload the messages view
//        messagesCollectionView.reloadData()
//        messagesCollectionView.scrollToLastItem(animated: true)
//    }
//}
//
//// MARK: - MessagesDataSource
//
//extension MessageKitVC: MessagesDataSource {
//    var currentSender: SenderType {
//        return Sender(senderId: "1", displayName: "John")
//    }
//
//    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
//        return messages[indexPath.section]
//    }
//
//    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
//        return messages.count
//    }
//}
//
//// MARK: - MessagesLayoutDelegate
//
//extension MessageKitVC: MessagesLayoutDelegate {
//    // Implement layout delegate methods if needed
//}
//
//// MARK: - MessagesDisplayDelegate
//
//extension MessageKitVC: MessagesDisplayDelegate {
//    // Implement display delegate methods if needed
//}
//////  ChatVC.swift
//////  Socket
//////
//////  Created by StarsDev on 26/12/2023.
////import Foundation
////import UIKit
////
////class ChatVC: UIViewController , SocketIOManagerDelegate, UITextFieldDelegate{
////
////    struct ChatMessage {
////        var message: String
////        var time: String
////        var senderId: String
////        // Add any other properties you need
////
////        init(message: String, time: String, senderId: String) {
////            self.message = message
////            self.time = time
////            self.senderId = senderId
////        }
////    }
////    // MARK: - IBOutlet Properties
////    @IBOutlet private weak var messageTextField: UITextField!
////    @IBOutlet private weak var tableView: UITableView!
////    @IBOutlet weak var userNameLbl: UILabel!
////    @IBOutlet weak var typingLbl: UILabel!
////    // MARK: - Variable Properties
////    let socketManager = SocketIOManager.sharedInstance
////    var chatMessages: [ChatMessage] = []
////
////    var accessToken = ""
////    var userName = ""
////    var sendMessagetoID = ""
////    var messageSenderName = ""
////    var senderId: String?
////    private var typingBubbleView: TypingBubbleView!
////    // MARK: - OverRide Func
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        socketManager.delegate = self
////        messageTextField.delegate = self
////        typingBubbleView = TypingBubbleView(frame: CGRect(x: 20, y: tableView.frame.maxY + 0, width: 70, height: 32))
////        view.addSubview(typingBubbleView)
////        self.typingBubbleView.stopAnimating()
////        userNameLbl.text = messageSenderName
////        addTapGestureToDismissKeyboard()
////        socketManager.connectSocket()
////        let recipientID = ""
////        let userID = accessToken
////        let messageID = ""
////        socketManager.joinSocket(recipientID: recipientID, userID: userID, messageID: messageID) { success in
////            if success {
////                print("Join event sent successfully!")
////            } else {
////                print("Failed to send join event.")
////            }
////        }
////    }
////    // MARK: - Custom Methods
////    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
////        socketManager.sendTypingEvent(recipientID: sendMessagetoID, userID: accessToken)
////        return true
////        }
////    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
////        socketManager.sendTypingDoneEvent(recipientID: sendMessagetoID, userID: accessToken)
////        textField.resignFirstResponder()
////        return true
////    }
////    func handleTypingEvent() {
////        DispatchQueue.main.async { [weak self] in
////            guard let self = self else { return }
////            self.typingBubbleView.startAnimating()
////            // Animate the typing label with a fade effect
////            UIView.animate(withDuration: 0.9, animations: {
////                self.typingLbl.alpha = 1.0
////                self.typingLbl.text = "Typing..."
////                
////            }) { (_) in
////                // Optional: You can add additional animation completion logic here
////            }
////        }
////    }
////    func handleTypingDoneEvent() {
////        self.typingBubbleView.stopAnimating()
////        self.typingLbl.text = "Online"
////    }
////    func addMessage(_ message: String, senderID: Int, receiverID: Int, time: String) {
////        print(senderID)
////        print(time)
////        if let formattedTime = formatHTMLTime(htmlTime: time) {
////            print("Formatted Time: \(formattedTime)")
////            self.senderId = "\(senderID)"
////            let chatMessage = ChatMessage(message: message, time: formattedTime, senderId: "\(senderID)")
////            chatMessages.append(chatMessage)
////        } else {
////            print("Error formatting time")
////        }
////        
////        DispatchQueue.main.async {
////            self.tableView.reloadData()
////            let indexPath = IndexPath(row: self.chatMessages.count - 1, section: 0)
////            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
////        }
////    }
////    func formatHTMLTime(htmlTime: String) -> String? {
////        // Extract the time string from the HTML
////        guard let timeString = htmlTime.extractTimeFromHTML() else {
////            let errorMessage = "Error formatting time. Failed to extract time from HTML. HTML Time: \(htmlTime)"
////            print(errorMessage)
////            return nil
////        }
////        let dateFormatter = DateFormatter()
////        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
////
////        if let date = dateFormatter.date(from: timeString) {
////            dateFormatter.dateFormat = "h:mm a"
////            let formattedTime = dateFormatter.string(from: date)
////            return formattedTime
////        } else {
////            let errorMessage = "Error formatting time. Failed to parse date. Time String: \(timeString)"
////            print(errorMessage)
////            return nil
////        }
////    }
////    // MARK: - IBAction Methods
////    @IBAction private func sendButtonTapped(_ sender: Any) {
////            if socketManager.isSocketConnected {
////                self.senderId = nil
////
////                if let messageText = messageTextField.text, !messageText.isEmpty {
////                    let currentDate = Date()
////                                let dateFormatter = DateFormatter()
////                                dateFormatter.dateFormat = "h:mm a"
////                                let currentTimeString = dateFormatter.string(from: currentDate)
////                    socketManager.sendPrivateMessage(
////                        toID: sendMessagetoID,
////                        fromID: accessToken,
////                        username: userName,
////                        message: messageText,
////                        color: "#056bba",
////                        isSticker: false,
////                        messageReplyID: ""
////                    ){ success in
////                        if success {
////                            print("Private message sent successfully!")
////                        } else {
////                            print("Failed to send private message.")
////                        }
////                    }
////                    socketManager.sendTypingDoneEvent(recipientID: sendMessagetoID, userID: accessToken)
////                    let chatMessage = ChatMessage(message: messageText, time: currentTimeString, senderId: sendMessagetoID)
////                    chatMessages.append(chatMessage)
////
////                    tableView.reloadData()
////                    messageTextField.resignFirstResponder()
////                    messageTextField.text = ""
////                    updateTableViewHeight()
////                } else {
////                    print("Message text is empty.")
////                }
////            } else {
////                print("Socket is not connected.")
////            }
////        }
////
////    @IBAction func backBtn(_ sender: UIButton) {
////        navigationController?.popViewController(animated: true)
////    }
////}
////// MARK: - Extension Table View
////extension ChatVC: UITableViewDataSource {
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return chatMessages.count
////    }
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let chatMessage = chatMessages[indexPath.row]
////
////        var cell: UITableViewCell
////
////        if let currentSenderId = senderId, currentSenderId == sendMessagetoID {
////            let senderCell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
////            senderCell.messageLabel.text = chatMessage.message
////                    senderCell.timeLabel.text = chatMessage.time
////            senderCell.layer.borderWidth = 5
////            senderCell.layer.cornerRadius = 20
////            senderCell.layer.masksToBounds = true
////            senderCell.layer.borderColor = UIColor.white.cgColor
////            senderCell.messageLabel.textColor = UIColor.white
////            senderCell.messageLabel.textAlignment = .left
////            print("SenderID: \(String(describing: senderId)), SendMessagetoID: \(sendMessagetoID), Alignment: Left")
////            cell = senderCell
////        } else {
////            let otherCell = tableView.dequeueReusableCell(withIdentifier: "MessageCell2", for: indexPath) as! MessageCell2
////            otherCell.massageLabel2.text = chatMessage.message
////                   otherCell.timeLabel2.text = chatMessage.time
////            otherCell.layer.borderWidth = 2
////            otherCell.layer.cornerRadius = 20
////            otherCell.layer.masksToBounds = true
////            otherCell.layer.borderColor = UIColor.white.cgColor
////            otherCell.massageLabel2.textColor = UIColor.black
////            otherCell.massageLabel2.textAlignment = .right
////            print("SenderID: \(String(describing: senderId)), SendMessagetoID: \(sendMessagetoID), Alignment: Right")
////            cell = otherCell
////        }
////
////        return cell
////    }
////    func updateTableViewHeight() {
////        UIView.animate(withDuration: 0.3) {
////             self.view.layoutIfNeeded()
////        }
////    }
////}
////extension String {
////    // Extracts the time string from HTML content
////    func extractTimeFromHTML() -> String? {
////        guard let startIndex = self.range(of: "title=\"")?.upperBound,
////              let endIndex = self.range(of: "\">", range: startIndex..<self.endIndex)?.lowerBound else {
////            return nil
////        }
////
////        let timeString = String(self[startIndex..<endIndex])
////        return timeString
////    }
////}
////
