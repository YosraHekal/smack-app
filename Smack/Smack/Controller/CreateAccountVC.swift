//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Yosra H. Hekal on 13.07.18.
//  Copyright © 2018 Yosra H. Hekal. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    //Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTXT: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    
    //Variables
    var avatarName = "profileDefault"
    var avatarColour = "[0.5, 0.5 , 0.5 , 1]"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instabce.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instabce.avatarName)
            avatarName = UserDataService.instabce.avatarName
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let name = usernameTxt.text, usernameTxt.text != "" else { return }
        guard let email = emailTXT.text , emailTXT.text != "" else { return }
        guard let pass = passwordTxt.text , passwordTxt.text != "" else { return }
            
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColour: self.avatarColour, completion: { (success) in
                            if success {
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                print(UserDataService.instabce.name, UserDataService.instabce.avatarColour, UserDataService.instabce.avatarName)
                            }
                        })
                        
                    }
                })
            }
        }
        
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func pickBGColourPressed(_ sender: Any) {
    }
    
}
