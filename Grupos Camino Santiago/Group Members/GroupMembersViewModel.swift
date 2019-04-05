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
    
    private(set) var membersViewModels: [MemberViewModel] = []
    private let groupsRepository: GroupsStorage
    private let groupId: Int
    public var isFounder : Bool = false
    public var isMember : Bool = false

    init(groupId: Int, groupsRepository: GroupsStorage) {
        self.groupId = groupId
        self.groupsRepository = groupsRepository
        self.groupsRepository.groupMembersDelegate = self
    }
    
    func getGroupMembers() {
        self.groupsRepository.getGroupMembers(groupId: self.groupId)
    }
    
    func joinGroup() {
        self.groupsRepository.joinGroup(groupId: self.groupId , join: !self.isMember)
    }
    
    func groupMemberRetrieved(_: GroupsStorage, idCurrentUser: Int, founder: User, members: [User]) {
        if idCurrentUser == founder.id {
            isFounder = true
        }else{
            isFounder = false
        }
 
        isMember = false
        membersViewModels = members.map({ (user: User) -> MemberViewModel in
            if (user.id == idCurrentUser) {
                isMember = true
            }
            return MemberViewModel(founder: false, user:user)
        })
        
        membersViewModels.insert(MemberViewModel(founder: true, user:founder), at: 0)
        
        self.delegate?.groupMembersRetrieved(self, members: members)
    }
    
    func error(_: GroupsStorage, errorMsg: String) {
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
