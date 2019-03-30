//
//  GroupsListViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 23/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import Foundation

class GroupListViewModel: GroupsRepositoryDelegate {

    private(set) var groupsUserViewModels: [GroupViewModel] = []
    private(set) var groupsMemberViewModels: [GroupViewModel] = []
    private(set) var otherGroupsViewModels: [GroupViewModel] = []
    
    weak var delegate: GroupsListViewModelDelegate?
    weak var routingDelegate: GroupsListViewModelRoutingDelegate?

    private let groupsRepository: GroupsRepository
    
    init(groupsRepository: GroupsRepository)
    {
        self.groupsRepository = groupsRepository
        self.groupsRepository.delegate = self
    }
    
    
    func loadGroups()
    {
        self.groupsRepository.getGroups()
    }
    
    
    func udateGroups(_: GroupsRepository, groups: UserGroups) {
        groupsUserViewModels = groups.groupsCreated.map({ (group: Group) -> GroupViewModel in
            return GroupViewModel(group:group)
        }).reversed()
        
        groupsMemberViewModels = groups.groupsAssociated.map({ (group: Group) -> GroupViewModel in
            return GroupViewModel(group:group)
        }).reversed()
        
        otherGroupsViewModels = groups.otherGroups.map({ (group: Group) -> GroupViewModel in
            return GroupViewModel(group:group)
        }).reversed()
        
        self.delegate?.groupsListViewModelDidUpdate(self)
    }
    
    func groupRetrieved(_: GroupsRepository, group: Group) {
        
    }
    
    func handleAddGroup() {
        self.routingDelegate?.groupListViewModeWantsToAddGroup(self)
    }
    
    
    func itemSelected(section : Int, index: Int) {
        switch section {
        case 0:
            self.routingDelegate?.showGroupDedtail(self,routeId: groupsUserViewModels[index].id)
        case 1:
            self.routingDelegate?.showGroupDedtail(self,routeId: groupsUserViewModels[index].id)
        default:
            self.routingDelegate?.showGroupDedtail(self,routeId: groupsUserViewModels[index].id)
        }

    }
    
    func error(_: GroupsRepository, errorMsg: String) {
        self.delegate?.error(self,errorMsg: errorMsg)
    }
    
}

protocol GroupsListViewModelDelegate: class
{
    func groupsListViewModelDidUpdate(_: GroupListViewModel)
    
    func error(_: GroupListViewModel, errorMsg: String)
    
}

protocol GroupsListViewModelRoutingDelegate: class
{
    func groupListViewModeWantsToAddGroup(_ viewModel: GroupListViewModel)
    
    func showGroupDedtail(_ viewModel: GroupListViewModel, routeId : Int)
}

