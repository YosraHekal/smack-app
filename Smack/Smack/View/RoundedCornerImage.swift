//
//  RoundedCornerImage.swift
//  Smack
//
//  Created by Yosra H. Hekal on 27.07.18.
//  Copyright © 2018 Yosra H. Hekal. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCornerImage: UIImageView {

    override func awakeFromNib() {
        super .awakeFromNib()
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }

}
