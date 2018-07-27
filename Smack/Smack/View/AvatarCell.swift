//
//  AvatarCell.swift
//  Smack
//
//  Created by Yosra H. Hekal on 25.07.18.
//  Copyright © 2018 Yosra H. Hekal. All rights reserved.
//

import UIKit


enum AvatarType{
    case dark
    case light
    
}


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
    
    
    func configureCell(index: Int, type: AvatarType){
        if type == AvatarType.dark {
            avatarImg.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImg.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.darkGray.cgColor
        }
    }
    
    func customizeview() {
        layer.backgroundColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
}
