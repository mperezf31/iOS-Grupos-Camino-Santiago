//
//  GroupListViewController.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 26/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialSnackbar
import JGProgressHUD

class GroupListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GroupsListViewModelDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let GROUP_CELL_IDENTIFIER = "GroupTableViewCell"
    private var viewModel: GroupListViewModel?
    private let hud = JGProgressHUD(style: .dark)
    
    private var mainRouteCoordinator : MainRouteCoordinator?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor(named: "PickledBluewood")
        return refreshControl
    }()
    
    init(viewModel: GroupListViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel?.delegate = self
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(viewModel: GroupListViewModel(groupsStorage: GroupsStorage(baseUrl: "")))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.addSubview(self.refreshControl)

        title = "Grupos Camino de Santiago"
        navigationItem.backBarButtonItem = UIBarButtonItem()

        tableView.register(UINib(nibName: GROUP_CELL_IDENTIFIER, bundle: nil), forCellReuseIdentifier: GROUP_CELL_IDENTIFIER)

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodoNote))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Logout"), style: .plain, target: self, action: #selector(logout))

        self.viewModel?.loadGroups()
    }
    
    @objc func addTodoNote()
    {
        self.viewModel?.handleAddGroup()
    }
    
    
    @objc func logout()
    {
        let uiAlertController = UIAlertController(title: "Cerrar sesión", message:"¿Seguro que desea cerrar sesión?", preferredStyle: .alert)
        let uiActionAccept = UIAlertAction(title: "OK", style: .default){ _ in
            self.viewModel?.logout()
        }
        let uiActionCancel = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        uiAlertController.addAction(uiActionAccept)
        uiAlertController.addAction(uiActionCancel)
        present(uiAlertController, animated: true, completion: nil)
    }
    

    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl)
    {
        self.viewModel?.loadGroups()
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
        cell.selectionStyle = .none

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
            return "Otros grupos"
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.itemSelected(section: indexPath.section, index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Eliminar"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if(!hud.isVisible){
                self.viewModel?.deleteGroup(section: indexPath.section, index: indexPath.row)
            }
        }
    }
    
    func groupsListViewModelDidUpdate(_: GroupListViewModel) {
        self.tableView.reloadData()
    }
    
    
    func showIndicator(_: GroupListViewModel, msg: String) {
        hud.textLabel.text = msg
        hud.show(in: self.view)
    }
    
    func hideIndicator(_: GroupListViewModel) {
        hud.dismiss()
        refreshControl.endRefreshing()
    }
    
    func error(_: GroupListViewModel, errorMsg: String) {        
        let message = MDCSnackbarMessage()
        message.text = errorMsg
        MDCSnackbarManager.show(message)
    }
    
}

