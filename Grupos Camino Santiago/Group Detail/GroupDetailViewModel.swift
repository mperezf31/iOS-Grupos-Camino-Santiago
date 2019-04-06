//
//  GroupDetailViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

class GroupDetailViewModel {
    
    weak var delegate: GroupDetailViewModelDelegate?
    weak var routingDelegate: GroupDetailViewModelRoutingDelegate?
    
    private let groupsRepository: GroupsStorage
    private let groupId: Int

    init(groupId: Int, groupsRepository: GroupsStorage) {
        self.groupId = groupId
        self.groupsRepository = groupsRepository
    }
    
    func getGroupDetail() {
        self.groupsRepository.getGroup(groupId: self.groupId){ (response) in
            switch response {
                
            case let .success(group):
                self.delegate?.groupDetailRetrieved(self, group: GroupViewModel(group: group))

            case let .error(error):
                self.delegate?.error(self,errorMsg: error as! String)
            }
        }
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



