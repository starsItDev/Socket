//
//  MessageCell2.swift
//  Socket
//
//  Created by StarsDev on 02/01/2024.
//

import UIKit

class MessageCell2: UITableViewCell {

    
    @IBOutlet weak var viewConstranit: NSLayoutConstraint!
    
    @IBOutlet weak var massageLabel2: UILabel!
    @IBOutlet weak var timeLabel2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//    override func prepareForReuse() {
//            super.prepareForReuse()
//            // Reset properties to their default values
//            massageLabel2.numberOfLines = 1 // or the desired default number of lines
//        viewConstranit?.isActive = false
//            // Reset other properties as needed
//        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
