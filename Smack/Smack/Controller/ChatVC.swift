//
//  ChatVC.swift
//  Smack
//
//  Created by Yosra H. Hekal on 12.07.18.
//  Copyright © 2018 Yosra H. Hekal. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate,UITableViewDataSource {

    
    //Outlets
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var messageTxtBox: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var typingUsersLbl: UILabel!
    //Variables
    var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        sendBtn.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handltap))
        view.addGestureRecognizer(tap)
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelsSelected(_:)), name: NOTIF_CHANNELS_SELECTED, object: nil)
        
        SocketService.instance.getChatMessages { (newMessage) in
            if newMessage.channelID == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.messages.append(newMessage)
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom , animated: true)
                }
            }
        }
        
//        SocketService.instance.getChatMessages { (success) in
//            if success {
//                self.tableView.reloadData()
//                let endIndex = IndexPath(row: MessageService.instance.messages.count - 1 , section: 0)
//                if MessageService.instance.messages.count > 0 {
//                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: true)
//                }
//            }
//        }
        
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard  let channelId = MessageService.instance.selectedChannel?.id else {return}
            var names = ""
            var numberofTypers = 0
            for (typingUser, channel) in typingUsers {
                if typingUser != UserDataService.instabce.name && channel == channelId {
                    if names == "" {
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)"
                    }
                    numberofTypers += 1
                }
            }
            if numberofTypers > 0 && AuthService.instance.isLoggedIn == true {
                var verb = "is"
                if numberofTypers > 1 {
                    verb = "are"
                }
                self.typingUsersLbl.text = "\(names) \(verb) typing..."
            } else {
                self.typingUsersLbl.text = ""
            }
        }
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
        
        
        
    }
    
    @objc func handltap(){
        view.endEditing(true)
    }
    
    @objc func userDataDidChange(_ notif: Notification){
        if AuthService.instance.isLoggedIn{
            //get channels
            onLoginGetMessages()
        } else {
            channelNameLabel.text = "Please Log in!"
            tableView.reloadData()
        }
    }
    
    @objc func channelsSelected(_ notif: Notification){
        updateWithChannels()
    }
    
    func updateWithChannels(){
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLabel.text = "#\(channelName)"
        getMessages()
    }
    
    func onLoginGetMessages(){
        MessageService.instance.findAllChannels { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannels()
                }
            } else {
                self.channelNameLabel.text = "No Channels yet!"
            }
        }
    }

    func getMessages(){
        guard let channelId = MessageService.instance.selectedChannel?.id else {return}
        MessageService.instance.findAllMessageForChannel(channelId: channelId) { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }


    @IBAction func messageBoxEditing(_ sender: Any) {
        guard let channelId = MessageService.instance.selectedChannel?.id else {return}
        if messageTxtBox.text == "" {
        isTyping = false
        sendBtn.isHidden = true
        SocketService.instance.manager.defaultSocket.emit("stopType", UserDataService.instabce.name, channelId)
    } else {
        if isTyping == false {
            sendBtn.isHidden = false
            SocketService.instance.manager.defaultSocket.emit("startType", UserDataService.instabce.name, channelId)
        }
        isTyping = true
        
        }
    }
    
    @IBAction func sendMsgPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else {return}
            guard let message = messageTxtBox.text else {return}
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instabce.id, channelId: channelId) { (success) in
                if success {
                    self.messageTxtBox.text = ""
                    //self.messageTxtBox.resignFirstResponder() //closes keyboard after sending the message
                    SocketService.instance.manager.defaultSocket.emit("stopType", UserDataService.instabce.name, channelId)
                }
            }
        }
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
}
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }





}
