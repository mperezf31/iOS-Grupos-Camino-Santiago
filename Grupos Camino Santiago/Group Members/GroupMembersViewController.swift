//
//  GroupMembersViewController.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

class GroupMembersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, GroupMembersViewModelViewModelDelegate {
   
    private let MEMBER_CELL_IDENTIFIER = "GroupMemberUiCellCollectionViewCell"

    private let viewModel: GroupMembersViewModel
    @IBOutlet weak var collectionView: UICollectionView!

    init(viewModel: GroupMembersViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(viewModel: GroupMembersViewModel(groupId: 0, groupsRepository: GroupsRepository()))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myLayout = UICollectionViewFlowLayout()
        myLayout.scrollDirection = .vertical
        myLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        myLayout.minimumInteritemSpacing = 10
        myLayout.estimatedItemSize = CGSize(width: 90, height: 100)

        self.collectionView.setCollectionViewLayout(myLayout, animated: false)

        self.collectionView.register(UINib(nibName: MEMBER_CELL_IDENTIFIER, bundle: nil), forCellWithReuseIdentifier: MEMBER_CELL_IDENTIFIER)

        self.viewModel.getGroupMembers()
    }
    
    
    func groupMembersRetrieved(_: GroupMembersViewModel, members : [User]) {
        self.collectionView.reloadData()
    }
    
    func error(_: GroupMembersViewModel, errorMsg: String) {
        print("GroupMembersViewController")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.membersViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MEMBER_CELL_IDENTIFIER, for: indexPath) as! GroupMemberUiCellCollectionViewCell
        
        cell.viewModel = viewModel.membersViewModels[indexPath.row]
        cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.layer.cornerRadius = 7
        return cell
        
    }

    
}
