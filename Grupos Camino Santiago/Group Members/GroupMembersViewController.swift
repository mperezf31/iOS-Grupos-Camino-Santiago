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
    
    @IBOutlet weak var joinGroup: UIButton!
    
    @IBAction func joinGroupClick() {
        self.viewModel.joinGroup()
    }
    
    init(viewModel: GroupMembersViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(viewModel: GroupMembersViewModel(groupId: 0, groupsRepository:GroupsStorage(baseUrl: "")))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        joinGroup.isHidden = true
        
        let myLayout = UICollectionViewFlowLayout()
        myLayout.scrollDirection = .vertical
        
        let size = (collectionView.frame.size.width - CGFloat(90)) / CGFloat(3)
        myLayout.itemSize = CGSize(width: size, height: 115)
        
        myLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        myLayout.minimumInteritemSpacing = 10

        self.collectionView.setCollectionViewLayout(myLayout, animated: false)

        self.collectionView.register(UINib(nibName: MEMBER_CELL_IDENTIFIER, bundle: nil), forCellWithReuseIdentifier: MEMBER_CELL_IDENTIFIER)
        self.viewModel.getGroupMembers()
    }
    
    
    func groupMembersRetrieved(_: GroupMembersViewModel, members : [User]) {
        if (self.viewModel.isFounder){
            joinGroup.isHidden = true
        }else if(self.viewModel.isMember){
            joinGroup.isHidden = false
            joinGroup.isEnabled = true
            joinGroup.setTitle("Salir del grupo", for: .normal)
        }else{
            joinGroup.isHidden = false
            joinGroup.isEnabled = true
            joinGroup.setTitle("Unirse al grupo", for: .normal)
        }
        
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
