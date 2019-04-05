//
//  GroupDetailViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

class GroupDetailViewModel : GroupDetailRepositoryDelegate {
    
    weak var delegate: GroupDetailViewModelDelegate?
    weak var routingDelegate: GroupDetailViewModelRoutingDelegate?
    
    private let groupsRepository: GroupsStorage
    private let groupId: Int

    init(groupId: Int, groupsRepository: GroupsStorage) {
        self.groupId = groupId
        self.groupsRepository = groupsRepository
        self.groupsRepository.groupDetailDelegate = self
    }
    
    func getGroupDetail() {
        self.groupsRepository.getGroup(groupId: self.groupId)
    }
    
    func groupsRetrieved(_: GroupsStorage, groups: UserGroups) { }
    
    func groupRetrieved(_: GroupsStorage, group: Group) {
        self.delegate?.groupDetailRetrieved(self, group: GroupViewModel(group: group))
    }
    
    func error(_: GroupsStorage, errorMsg: String) {
        self.delegate?.error(self,errorMsg: errorMsg)
    }
    
}

protocol GroupDetailViewModelDelegate: class
{
    
    func groupDetailRetrieved(_: GroupDetailViewModel, group: GroupViewModel)

    func error(_: GroupDetailViewModel, errorMsg: String)
}

protocol GroupDetailViewModelRoutingDelegate: class
{
    func finishGroupDetail(_ viewModel: GroupDetailViewModel)
}



