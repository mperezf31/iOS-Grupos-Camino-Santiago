//
//  ViewController.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 23/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GroupsListViewModelDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let GROUP_CELL_IDENTIFIER = "GroupCell"
    private var viewModel: GroupsListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = GroupsListViewModel(groupsRepository: GroupsRepository())
        self.viewModel?.delegate = self
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel?.groupsUserViewModels.count ?? 0
        case 1:
            return viewModel?.groupsMemberViewModels.count ?? 0
        default:
            return viewModel?.otherGroupsViewModels.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GROUP_CELL_IDENTIFIER, for: indexPath) as! GroupTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.viewModel = viewModel?.groupsUserViewModels[indexPath.row]
        case 1:
            cell.viewModel = viewModel?.groupsMemberViewModels[indexPath.row]
        default:
            cell.viewModel = viewModel?.otherGroupsViewModels[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Mis grupos"
        case 1:
            return "Grupos miembro"
        default:
            return "Grupos Camino Santiago"
        }
    }
    
    
    func groupsListViewModelDidUpdate(_: GroupsListViewModel) {
        self.tableView.reloadData()
    }
    
}

