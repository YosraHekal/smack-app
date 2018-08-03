//
//  UserDataService.swift
//  Smack
//
//  Created by Yosra H. Hekal on 24.07.18.
//  Copyright © 2018 Yosra H. Hekal. All rights reserved.
//

import Foundation

class  UserDataService {
    
    static let instabce = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColour = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    
    func setUserData(id: String, colour: String, avatarName: String, email: String, name: String){
        self.id = id
        self.avatarColour = colour
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }


    func returnUiColou(components: String) -> UIColor {
        // [0.694117647058824, 0.847058823529412, 0.968627450980392, 1]
        
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ]")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a : NSString?
        
        
        scanner.scanUpToCharacters(from: comma , into: &r)
        scanner.scanUpToCharacters(from: comma , into: &g)
        scanner.scanUpToCharacters(from: comma , into: &b)
        scanner.scanUpToCharacters(from: comma , into: &a)
        
        let defaultColour = UIColor.lightGray
        
        guard  let rUnwrapped = r else { return defaultColour }
        guard  let gUnwrapped = g else { return defaultColour }
        guard  let bUnwrapped = b else { return defaultColour }
        guard  let aUnwrapped = a else { return defaultColour }
        
        
        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        let newUIColour  = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return newUIColour
        
    }

    
    func logoutUser(){
        id = ""
        avatarColour = ""
        avatarName = ""
        name = ""
        email = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessages()
    }









}
