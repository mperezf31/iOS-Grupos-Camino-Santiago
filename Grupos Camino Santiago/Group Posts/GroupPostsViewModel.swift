//
//  GroupPostsViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

class GroupPostsViewModel : GroupPostsRepositoryDelegate {
    
    weak var delegate: GroupPostsViewModelViewModelDelegate?
    weak var routingDelegate: GroupPostsViewModelViewModelRoutingDelegate?
    
    private let groupsRepository: GroupsStorage
    private let groupId: Int
    
    init(groupId: Int, groupsRepository: GroupsStorage) {
        self.groupId = groupId
        self.groupsRepository = groupsRepository
        self.groupsRepository.groupPostsDelegate = self
    }
    
    func getGroupPosts() {
        self.groupsRepository.getGroupPosts(groupId: self.groupId)
    }
    
    func groupPostsRetrieved(_: GroupsStorage, posts: [Post]) {
        self.delegate?.grouPostsRetrieved(self, posts: posts)
    }
    
    func error(_: GroupsStorage, errorMsg: String) {
        self.delegate?.error(self,errorMsg: errorMsg)
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
