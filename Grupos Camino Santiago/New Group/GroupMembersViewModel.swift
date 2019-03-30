//
//  GroupMembersViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

class GroupMembersViewModel : GroupsRepositoryDelegate {
    
    weak var delegate: GroupMembersViewModelViewModelDelegate?
    weak var routingDelegate: GroupMembersViewModelViewModelRoutingDelegate?
    
    private let groupsRepository: GroupsRepository
    private let groupId: Int
    
    init(groupId: Int, groupsRepository: GroupsRepository) {
        self.groupId = groupId
        self.groupsRepository = groupsRepository
        self.groupsRepository.delegate = self
    }
    
    func getGroupMembers() {
        self.groupsRepository.getGroup(groupId: self.groupId)
    }
    
    func udateGroups(_: GroupsRepository, groups: UserGroups) { }
    
    func groupRetrieved(_: GroupsRepository, group: Group) {
        self.delegate?.groupMembersRetrieved(self, group: group.members)
    }
    
    func error(_: GroupsRepository, errorMsg: String) {
        self.delegate?.error(self,errorMsg: errorMsg)
    }
    
}

protocol GroupMembersViewModelViewModelDelegate: class
{
    
    func groupMembersRetrieved(_: GroupMembersViewModel, group: [User])
    
    func error(_: GroupMembersViewModel, errorMsg: String)
}

protocol GroupMembersViewModelViewModelRoutingDelegate: class
{
    func finishGroupDetail(_ viewModel: GroupMembersViewModel)
}
