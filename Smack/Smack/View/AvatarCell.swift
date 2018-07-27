//
//  AvatarCell.swift
//  Smack
//
//  Created by Yosra H. Hekal on 25.07.18.
//  Copyright © 2018 Yosra H. Hekal. All rights reserved.
//

import UIKit
@IBDesignable

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeview()
    }
    override func prepareForInterfaceBuilder(){
        customizeview()
    }
    
    
    func customizeview() {
        layer.backgroundColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
}
