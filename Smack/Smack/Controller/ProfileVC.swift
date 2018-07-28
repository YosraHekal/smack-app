//
//  ProfileVC.swift
//  Smack
//
//  Created by Yosra H. Hekal on 28.07.18.
//  Copyright © 2018 Yosra H. Hekal. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var logoutTitle: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    @IBAction func closeModelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        profileImg.image = UIImage(named: "menuProfileIcon")
        UserDataService.instabce.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    
    func setupView(){
        if AuthService.instance.isLoggedIn {
            userEmail.text = UserDataService.instabce.email
            userName.text = UserDataService.instabce.name
            profileImg.image = UIImage(named: UserDataService.instabce.avatarName)
            profileImg.backgroundColor = UserDataService.instabce.returnUiColou(components: UserDataService.instabce.avatarColour)
            let closeTap = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
            bgView.addGestureRecognizer(closeTap)
        }
    }
    @objc func closeTap(_ recogzier: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
}
