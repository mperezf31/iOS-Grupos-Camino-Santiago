//
//  GroupMembersViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

class GroupMembersViewModel : GroupMembersRepositoryDelegate {
    
    weak var delegate: GroupMembersViewModelViewModelDelegate?
    weak var routingDelegate: GroupMembersViewModelViewModelRoutingDelegate?
    
    private let groupsRepository: GroupsRepository
    private let groupId: Int
    
    init(groupId: Int, groupsRepository: GroupsRepository) {
        self.groupId = groupId
        self.groupsRepository = groupsRepository
        self.groupsRepository.groupMembersDelegate = self
    }
    
    func getGroupMembers() {
        self.groupsRepository.getGroupMembers(groupId: self.groupId)
    }
    
    func groupMemberRetrieved(_: GroupsRepository, members: [User]) {
        self.delegate?.groupMembersRetrieved(self, members: members)
    }
    
    func error(_: GroupsRepository, errorMsg: String) {
        self.delegate?.error(self,errorMsg: errorMsg)
    }
    
}

protocol GroupMembersViewModelViewModelDelegate: class
{
    
    func groupMembersRetrieved(_: GroupMembersViewModel, members: [User])
    
    func error(_: GroupMembersViewModel, errorMsg: String)
}

protocol GroupMembersViewModelViewModelRoutingDelegate: class
{
    func finishGroupDetail(_ viewModel: GroupMembersViewModel)
}
