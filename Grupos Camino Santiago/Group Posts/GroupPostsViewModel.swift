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
    
    private let groupsRepository: GroupsStorage
    private let groupId: Int
    
    init(groupId: Int, groupsRepository: GroupsStorage) {
        self.groupId = groupId
        self.groupsRepository = groupsRepository
    }
    
    func getGroupPosts() {
        self.groupsRepository.getGroupPosts(groupId: self.groupId) { (response) in
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
