//
//  ChannelVC.swift
//  Smack
//
//  Created by Yosra H. Hekal on 12.07.18.
//  Copyright © 2018 Yosra H. Hekal. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }

}
