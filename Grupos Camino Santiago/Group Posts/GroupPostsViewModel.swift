//
//  GroupPostsViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

class GroupPostsViewModel {
    
    weak var delegate: GroupPostsViewModelViewModelDelegate?
    weak var routingDelegate: GroupPostsViewModelViewModelRoutingDelegate?
    
    private let groupsStorage: GroupsStorage
    private let groupId: Int
    
    init(groupId: Int, groupsStorage: GroupsStorage) {
        self.groupId = groupId
        self.groupsStorage = groupsStorage
    }
    
    func getGroupPosts() {
        self.groupsStorage.getGroupPosts(groupId: self.groupId) { (response) in
            switch response {
                
            case let .success(posts):
                self.delegate?.grouPostsRetrieved(self, posts: posts)

            case let .error(error):
                self.delegate?.error(self,errorMsg: error as! String)
            }
        }
    }
}

protocol GroupPostsViewModelViewModelDelegate: class
{
    
    func grouPostsRetrieved(_: GroupPostsViewModel, posts: [Post])
    
    func error(_: GroupPostsViewModel, errorMsg: String)
}

protocol GroupPostsViewModelViewModelRoutingDelegate: class
{
    func finishGroupDetail(_ viewModel: GroupPostsViewModel)
}
