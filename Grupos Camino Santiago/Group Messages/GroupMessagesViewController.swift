//
//  GroupPostsViewController.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit
import MessengerKit
import MaterialComponents.MaterialSnackbar
import JGProgressHUD

class GroupMessagesViewController: MSGMessengerViewController, MSGDataSource, GroupPostsViewModelViewModelDelegate {
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    private lazy var messages: [[MSGMessage]] = []
    
    private let viewModel: GroupMessagesViewModel
    private let hud = JGProgressHUD(style: .dark)
    
    init(viewModel: GroupMessagesViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(viewModel: GroupMessagesViewModel(groupId: 0, groupsStorage: GroupsStorage(baseUrl: "")))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        self.viewModel.getGroupMessages(enableCache : true)
    }
    
    
    @objc func updateMessages(){
        if !hud.isVisible{
            self.viewModel.getGroupMessages(enableCache : false)
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(updateMessages))
        collectionView.scrollToBottom(animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem()
    }
    
    func groupMessagesUpdate(_: GroupMessagesViewModel, messages: [MSGMessage]) {
        self.messages = []
        insert(messages)
    }
    
    func showIndicator(_: GroupMessagesViewModel, msg: String) {
        hud.textLabel.text = msg
        hud.show(in: self.view)
    }
    
    func hideIndicator(_: GroupMessagesViewModel) {
        hud.dismiss()
    }
    
    func error(_: GroupMessagesViewModel, errorMsg: String) {
        let message = MDCSnackbarMessage()
        message.text = errorMsg
        MDCSnackbarManager.show(message)
    }
    
    override func inputViewPrimaryActionTriggered(inputView: MSGInputView) {
        self.viewModel.addNewMessage(msg: inputView.message)
        inputView.resignFirstResponder()
    }
    
    override func insert(_ messages: [MSGMessage], callback: (() -> Void)? = nil) {
        for message in messages {
            if let lastSection = self.messages.last, let lastMessage = lastSection.last, lastMessage.user.displayName == message.user.displayName {
                self.messages[self.messages.count - 1].append(message)
            } else {
                self.messages.append([message])
            }
        }
        collectionView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.collectionView.scrollToBottom(animated: false)
        }
    }
    
    override var style: MSGMessengerStyle {
        var style = MessengerKit.Styles.travamigos
        style.inputPlaceholder = "Mensaje..."
        style.inputView = MSGImessageInputView.self
        style.outgoingGradient = [UIColor(named: "PickledBluewoodLight")!.cgColor,
                                  UIColor(named: "PickledBluewoodLight")!.cgColor]
        style.outgoingTextColor = .white
        style.incomingTextColor = .black
        return style
    }
    
    func numberOfSections() -> Int {
        return messages.count
    }
    
    func numberOfMessages(in section: Int) -> Int {
        return messages[section].count
    }
    
    func message(for indexPath: IndexPath) -> MSGMessage {
        return messages[indexPath.section][indexPath.item]
    }
    
    func headerTitle(for section: Int) -> String? {
        var sendDate = ""
        if let date = (messages[section].last?.sentAt){
            sendDate = formatter.string(from: date)
        }
        return "\((messages[section].first?.user.displayName)!)  -  \(sendDate)"
    }
    
    func footerTitle(for section: Int) -> String? {
        return ""
    }
    
}
