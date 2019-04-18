//
//  GroupPostsViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import MessengerKit

class GroupMessagesViewModel {
    
    weak var delegate: GroupPostsViewModelViewModelDelegate?
    weak var routingDelegate: GroupPostsViewModelViewModelRoutingDelegate?
    
    private let groupsStorage: GroupsStorage
    private let groupId: Int
    
    init(groupId: Int, groupsStorage: GroupsStorage) {
        self.groupId = groupId
        self.groupsStorage = groupsStorage
    }
    
    func getGroupMessages() {
        self.delegate?.showIndicator(self, msg: "Obteniendo mensajes...")
        self.groupsStorage.getGroupPosts(groupId: self.groupId) { (response) in
            self.delegate?.hideIndicator(self)
            
            switch response {
    
            case let .success(posts):
                self.delegate?.groupMessagesUpdate(self, messages: self.mapperMessages(posts: posts))
                
            case let .error(error):
                self.delegate?.error(self,errorMsg: error.msgError)
            }
        }
    }
    
    func addNewMessage(msg :String) {
        self.delegate?.showIndicator(self, msg: "Enviando...")

        self.groupsStorage.addGroupPost(groupId: self.groupId , message: msg) { (response) in
            self.delegate?.hideIndicator(self)

            switch response {
                
            case let .success(posts):
                self.delegate?.groupMessagesUpdate(self, messages: self.mapperMessages(posts: posts))
                
            case let .error(error):
                self.delegate?.error(self,errorMsg: error.msgError)
            }
        }
    }
    
    private func mapperMessages(posts : [Post]) -> [MSGMessage] {
        var messages : [MSGMessage] = []
        let authUser = groupsStorage.getAuthUser()
        
        for post in posts {
            let sender = getMessageSender(authuserId: authUser!.id!, author: post.author!)
            let date = Date(timeIntervalSince1970: post.whenSent!)
            let message = MSGMessage(id: post.id!, body: .text(post.content ?? ""), user: sender, sentAt: date)
            messages.append(message)
        }
        
        return messages
    }
    
    private func getMessageSender(authuserId : Int , author: User) -> Sender {
        var avatar : UIImage
        if let photoString = author.photo {
            avatar = UIImage.init(imageString: photoString)!
        }else{
            avatar = UIImage(named: "User")!
        }
        
        return Sender(displayName: author.name!, avatar: avatar, isSender: authuserId == author.id!)
    }
}

protocol GroupPostsViewModelViewModelDelegate: class
{
    func groupMessagesUpdate(_: GroupMessagesViewModel, messages: [MSGMessage])
    
    func showIndicator(_: GroupMessagesViewModel, msg: String)
    
    func hideIndicator(_: GroupMessagesViewModel)
    
    func error(_: GroupMessagesViewModel, errorMsg: String)
}

protocol GroupPostsViewModelViewModelRoutingDelegate: class
{
    func finishGroupDetail(_ viewModel: GroupMessagesViewModel)
}
