//
//  RoundedCorners.swift
//  Smack
//
//  Created by Yosra H. Hekal on 13.07.18.
//  Copyright © 2018 Yosra H. Hekal. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCorners: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.awakeFromNib()
    }
}
