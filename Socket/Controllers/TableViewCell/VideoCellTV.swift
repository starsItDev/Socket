//
//  VideoCellTV.swift
//  Socket
//
//  Created by StarsDev on 25/01/2024.
//

import UIKit



class VideoCellTV: UITableViewCell {
    @IBOutlet weak var imgVideoView: UIImageView!
    
    @IBOutlet weak var imageVideoBtnTap: UIButton!
    
    @IBOutlet weak var viewUIView: UIView!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
