//
//  GroupDetailViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

class GroupDetailViewModel : GroupsRepositoryDelegate {
    
    weak var delegate: GroupDetailViewModelDelegate?
    weak var routingDelegate: GroupDetailViewModelRoutingDelegate?
    
    private let groupsRepository: GroupsRepository
    private let groupId: Int

    init(groupId: Int, groupsRepository: GroupsRepository) {
        self.groupId = groupId
        self.groupsRepository = groupsRepository
        self.groupsRepository.delegate = self
    }
    
    func getGroupDetail() {
        self.groupsRepository.getGroup(groupId: self.groupId)
    }
    
    func finishGroupDetail() {
        self.routingDelegate?.finishGroupDetail(self)
    }
    
    func udateGroups(_: GroupsRepository, groups: UserGroups) { }
    
    func groupRetrieved(_: GroupsRepository, group: Group) {
        self.delegate?.groupDetailRetrieved(self, group: group)
    }
    
    func error(_: GroupsRepository, errorMsg: String) {
        self.delegate?.error(self,errorMsg: errorMsg)
    }
    
}

protocol GroupDetailViewModelDelegate: class
{
    
    func groupDetailRetrieved(_: GroupDetailViewModel, group: Group)

    func error(_: GroupDetailViewModel, errorMsg: String)
}

protocol GroupDetailViewModelRoutingDelegate: class
{
    func finishGroupDetail(_ viewModel: GroupDetailViewModel)
}



