//
//  AddChannelVC.swift
//  Smack
//
//  Created by Yosra H. Hekal on 02.08.18.
//  Copyright © 2018 Yosra H. Hekal. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var descriptionTxt: UITextField!
    
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }

    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelPressed(_ sender: Any) {
    }

    
    
    func setUpView(){
        let closeTouch = UITapGestureRecognizer(target: self , action: #selector(AddChannelVC.closeTab(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        nameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor : smackPurplePlaceHolder])
        descriptionTxt.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor : smackPurplePlaceHolder])
    }
    
    @objc func closeTab(_ recognizer: UITapGestureRecognizer){
    dismiss(animated: true, completion: nil)
    }


}
