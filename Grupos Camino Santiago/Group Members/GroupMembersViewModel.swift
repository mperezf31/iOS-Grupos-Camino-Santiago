//
//  GroupMembersViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

class GroupMembersViewModel {
    
    weak var delegate: GroupMembersViewModelViewModelDelegate?
    weak var routingDelegate: GroupMembersViewModelViewModelRoutingDelegate?
    
    private(set) var membersViewModels: [MemberViewModel] = []
    private let groupsStorage: GroupsStorage
    private let groupId: Int
    public var isFounder : Bool = false
    public var isMember : Bool = false
    public var currentuserId : Int

    init(groupId: Int, groupsStorage: GroupsStorage) {
        self.groupId = groupId
        self.groupsStorage = groupsStorage
        self.currentuserId = groupsStorage.getAuthUserId() ?? 0
    }
    
    func getGroupMembers() {
        self.groupsStorage.getGroup(groupId: self.groupId){ (response) in
            switch response {
                
            case let .success(group):
                self.parseMemberRetrieved(founder: group.founder!,members: group.members)
            case let .error(error):
                self.delegate?.error(self,errorMsg: error.msgError)
            }
        }
    }

    func parseMemberRetrieved(founder: User, members: [User]) {
        if self.currentuserId == founder.id {
            isFounder = true
        }else{
            isFounder = false
        }
 
        isMember = false
        membersViewModels = members.map({ (user: User) -> MemberViewModel in
            if (user.id == self.currentuserId) {
                isMember = true
            }
            return MemberViewModel(founder: false, user:user)
        })
        
        membersViewModels.insert(MemberViewModel(founder: true, user:founder), at: 0)
        
        self.delegate?.groupMembersRetrieved(self, members: members)
    }
    

    
    func joinGroup() {
        self.groupsStorage.joinGroup(groupId: self.groupId , join: !self.isMember){ (response) in
            switch response {
                
            case let .success(group):
                self.parseMemberRetrieved(founder: group.founder!,members: group.members)
            case let .error(error):
                self.delegate?.error(self,errorMsg: error.msgError)
            }
        }
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
