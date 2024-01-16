//  ChatVC.swift
//  Socket
//
//  Created by StarsDev on 26/12/2023.
import Foundation
import UIKit

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


class ChatVC: UIViewController , SocketIOManagerDelegate, UITextFieldDelegate{
    // MARK: - IBOutlet Properties
    @IBOutlet private weak var messageTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var typingLbl: UILabel!
    // MARK: - Variable Properties
    let socketManager = SocketIOManager.sharedInstance
    var chatMessages: [ChatMessage] = []
    var accessToken = ""
    var userName = ""
    var sendMessagetoID = ""
    var messageSenderName = ""
    private var typingBubbleView: TypingBubbleView!
    // MARK: - OverRide Func
    override func viewDidLoad() {
        super.viewDidLoad()
        socketManager.delegate = self
        messageTextField.delegate = self
        typingBubbleView = TypingBubbleView(frame: CGRect(x: 20, y:  tableView.frame.maxY + 0, width: 70, height: 32))
//        typingBubbleView = TypingBubbleView(frame: CGRect(x: 20, y: 565, width: 70, height: 32))
        print("Chat App")
        view.addSubview(typingBubbleView)
        self.typingBubbleView.stopAnimating()
        userNameLbl.text = messageSenderName
        addTapGestureToDismissKeyboard()
        socketManager.connectSocket()
        let recipientID = ""
        let userID = accessToken
        let messageID = ""
        socketManager.joinSocket(recipientID: recipientID, userID: userID, messageID: messageID) { success in
            if success {
                print("Join event sent successfully!")
            } else {
                print("Failed to send join event.")
            }
        }
    }
    // MARK: - Custom Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        socketManager.sendTypingEvent(recipientID: sendMessagetoID, userID: accessToken)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        socketManager.sendTypingDoneEvent(recipientID: sendMessagetoID, userID: accessToken)
        textField.resignFirstResponder()
        return true
    }
    func handleTypingEvent() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.typingBubbleView.startAnimating()
            // Animate the typing label with a fade effect
            UIView.animate(withDuration: 0.9, animations: {
                self.typingLbl.alpha = 1.0
                self.typingLbl.text = "Typing..."
                
            }) { (_) in
                // Optional: You can add additional animation completion logic here
            }
        }
    }
    func handleTypingDoneEvent() {
        self.typingBubbleView.stopAnimating()
        self.typingLbl.text = "Online"
    }
    func formatHTMLTime(htmlTime: String) -> String? {
        // Extract the time string from the HTML
        guard let timeString = htmlTime.extractTimeFromHTML() else {
            let errorMessage = "Error formatting time. Failed to extract time from HTML. HTML Time: \(htmlTime)"
            print(errorMessage)
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: timeString) {
            dateFormatter.dateFormat = "h:mm a"
            let formattedTime = dateFormatter.string(from: date)
            return formattedTime
        } else {
            let errorMessage = "Error formatting time. Failed to parse date. Time String: \(timeString)"
            print(errorMessage)
            return nil
        }
    }
    func addMessage(_ message: String, senderID: Int, receiverID: Int, time: String) {
        print(senderID)
        print(time)
        if let formattedTime = formatHTMLTime(htmlTime: time) {
            print("Formatted Time: \(formattedTime)")
            let chatMessage = ChatMessage(message: message, time: formattedTime, senderId: "\(senderID)")
            chatMessages.append(chatMessage)
        } else {
            print("Error formatting time")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            let indexPath = IndexPath(row: self.chatMessages.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    // MARK: - IBAction Methods
    @IBAction private func sendButtonTapped(_ sender: Any) {
        if socketManager.isSocketConnected {
            if let messageText = messageTextField.text, !messageText.isEmpty {
                let currentDate = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                let currentTimeString = dateFormatter.string(from: currentDate)
                socketManager.sendPrivateMessage(
                    toID: sendMessagetoID,
                    fromID: accessToken,
                    username: userName,
                    message: messageText,
                    color: "#056bba",
                    isSticker: false,
                    messageReplyID: ""
                ){ success in
                    if success {
                        print("Private message sent successfully!")
                    } else {
                        print("Failed to send private message.")
                    }
                }
                socketManager.sendTypingDoneEvent(recipientID: sendMessagetoID, userID: accessToken)
                let chatMessage = ChatMessage(message: messageText, time: currentTimeString, senderId: "")
                chatMessages.append(chatMessage)
                
                tableView.reloadData()
                messageTextField.resignFirstResponder()
                messageTextField.text = ""
            } else {
                print("Message text is empty.")
            }
        } else {
            print("Socket is not connected.")
        }
    }
    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func imageBtn(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
           imagePicker.delegate = self
           present(imagePicker, animated: true, completion: nil)
    }
    func sendImageFunction(image: UIImage) {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let currentTimeString = dateFormatter.string(from: currentDate)

        let chatMessage = ChatMessage(message: "", time: currentTimeString, senderId: accessToken, messageType: .image, image: image)
        chatMessages.append(chatMessage)

        tableView.reloadData()
        let indexPath = IndexPath(row: chatMessages.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

}
// MARK: - Extension Table View
extension ChatVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatMessage = chatMessages[indexPath.row]
        var cell: UITableViewCell
        if chatMessage.senderId == sendMessagetoID {
            let senderCell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
            senderCell.messageLabel.text = chatMessage.message
            senderCell.timeLabel.text = chatMessage.time
            senderCell.messageLabel.numberOfLines = 0
            senderCell.layer.borderWidth = 2
            senderCell.layer.cornerRadius = 22
            senderCell.layer.masksToBounds = true
            senderCell.layer.borderColor = UIColor.white.cgColor
            senderCell.messageLabel.textColor = UIColor.white
            senderCell.timeLabel.textColor = UIColor.white
            senderCell.messageLabel.textAlignment = .left
            cell = senderCell
        }else if chatMessage.messageType == .image {
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "ImageCellTV", for: indexPath) as! ImageCellTV
            // Assuming your ChatMessage model has an image property
            imageCell.imgView.image = chatMessage.image
            cell = imageCell
        }
        else {
            let otherCell = tableView.dequeueReusableCell(withIdentifier: "MessageCell2", for: indexPath) as! MessageCell2
            otherCell.massageLabel2.text = chatMessage.message
            otherCell.timeLabel2.text = chatMessage.time
            otherCell.layer.borderWidth = 4
            otherCell.layer.cornerRadius = 22
            otherCell.layer.masksToBounds = true
            otherCell.layer.borderColor = UIColor.white.cgColor
            otherCell.massageLabel2.textColor = UIColor.black
            otherCell.massageLabel2.textAlignment = .right
            otherCell.massageLabel2.numberOfLines = 0
            return otherCell
        }
        return cell
    }
}
extension ChatVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // Assuming you have a function to send images
            sendImageFunction(image: pickedImage)
        }

        dismiss(animated: true, completion: nil)
    }
}
