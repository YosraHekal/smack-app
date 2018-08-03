//
//  MessageCell.swift
//  Smack
//
//  Created by Yosra H. Hekal on 03.08.18.
//  Copyright © 2018 Yosra H. Hekal. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    //Outlets
    
    @IBOutlet weak var userImg: RoundedCornerImage!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timstampLbl: UILabel!
    
    @IBOutlet weak var messageBodyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    
    func configureCell(message: Message) {
        messageBodyLbl.text = message.message
        userNameLabel.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instabce.returnUiColou(components: message.userAvatarColour)
        
    }

}
