//
//  ChatVC.swift
//  Smack
//
//  Created by Yosra H. Hekal on 12.07.18.
//  Copyright © 2018 Yosra H. Hekal. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    
    //Outlets
    
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }


}