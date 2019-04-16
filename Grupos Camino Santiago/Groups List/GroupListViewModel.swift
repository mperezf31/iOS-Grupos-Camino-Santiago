//
//  GroupsListViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 23/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import Foundation

class GroupListViewModel: GroupsStorageDelegate {
    
    private(set) var groupsUserViewModels: [GroupViewModel] = []
    private(set) var groupsMemberViewModels: [GroupViewModel] = []
    private(set) var otherGroupsViewModels: [GroupViewModel] = []
    
    weak var delegate: GroupsListViewModelDelegate?
    weak var routingDelegate: GroupsListViewModelRoutingDelegate?
    
    private let groupsStorage: GroupsStorage
    
    init(groupsStorage: GroupsStorage)
    {
        self.groupsStorage = groupsStorage
        self.groupsStorage.delegate = self
    }
    
    
    func loadGroups(enableCache: Bool)
    {
        self.delegate?.showIndicator(self, msg: "Obteniendo grupos...")
        self.groupsStorage.getGroups(enableCache: enableCache)
    }
    
    func logout() {
        self.groupsStorage.logout()
        self.routingDelegate?.showLogin(self)
    }
    
    func deleteGroup(section : Int, index: Int) {
        self.delegate?.showIndicator(self, msg: "Eliminando grupo...")
        self.groupsStorage.deleteGroup(groupId: getGroupBySection(section: section, index: index).id)
    }
    
    func groupsUpdate(_: GroupsStorage, groups: UserGroups) {
        groupsUserViewModels = groups.groupsCreated.map({ (group: Group) -> GroupViewModel in
            return GroupViewModel(group:group)
        }).reversed()
        
        groupsMemberViewModels = groups.groupsAssociated.map({ (group: Group) -> GroupViewModel in
            return GroupViewModel(group:group)
        }).reversed()
        
        otherGroupsViewModels = groups.otherGroups.map({ (group: Group) -> GroupViewModel in
            return GroupViewModel(group:group)
        }).reversed()
        
        self.delegate?.hideIndicator(self)
        self.delegate?.groupsListViewModelDidUpdate(self)
    }
    
    
    func handleAddGroup() {
        self.routingDelegate?.groupListViewModeWantsToAddGroup(self)
    }
    
    
    func itemSelected(section : Int, index: Int) {
        self.routingDelegate?.showGroupDedtail(self,routeId: getGroupBySection(section: section, index: index).id)
    }
    
    func error(_: GroupsStorage, error: StorageError) {
        self.delegate?.hideIndicator(self)
        self.delegate?.error(self, errorMsg: error.msgError)
    }
    
    private func getGroupBySection(section : Int, index: Int) -> GroupViewModel{
        switch section {
        case 0:
            return self.groupsUserViewModels[index]
        case 1:
            return self.groupsMemberViewModels[index]
        default:
            return self.otherGroupsViewModels[index]
        }
    }
    
}

protocol GroupsListViewModelDelegate: class
{
    
    func showIndicator(_: GroupListViewModel, msg: String)
    
    func hideIndicator(_: GroupListViewModel)
    
    func groupsListViewModelDidUpdate(_: GroupListViewModel)
    
    func error(_: GroupListViewModel, errorMsg: String)
    
}

protocol GroupsListViewModelRoutingDelegate: class
{
    func groupListViewModeWantsToAddGroup(_ viewModel: GroupListViewModel)
    
    func showGroupDedtail(_ viewModel: GroupListViewModel, routeId : Int)
    
    func showLogin(_ viewModel: GroupListViewModel)
}

