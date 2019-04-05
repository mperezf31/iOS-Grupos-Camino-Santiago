//
//  GroupDetailViewController.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

class GroupDetailViewController: UIViewController , GroupDetailViewModelDelegate{
   
    @IBOutlet weak var groupPhoto: UIImageView!
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var departureDate: UILabel!
    @IBOutlet weak var arrivalDate: UILabel!
    @IBOutlet weak var groupDescription: UILabel!
    @IBOutlet weak var departurePlace: UILabel!
    
    @IBOutlet weak var founderPhoto: UIImageView!
    @IBOutlet weak var founderName: UILabel!
    @IBOutlet weak var founderEmail: UILabel!
    
    private let viewModel: GroupDetailViewModel

    init(viewModel: GroupDetailViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(viewModel: GroupDetailViewModel(groupId: 0, groupsRepository: GroupsStorage(baseUrl: "")))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.viewModel.getGroupDetail()
    }
    
    
    func groupDetailRetrieved(_: GroupDetailViewModel, group: GroupViewModel) {
        self.groupTitle.text = group.title
        self.departureDate.text = "Salida el día \(group.departureDate)"
        self.arrivalDate.text = "Llegada el día \(group.arrivalDate)"
        self.groupDescription.text = group.description
        self.departurePlace.text = group.departurePlace
        
        self.founderName.text = group.founderName
        self.founderEmail.text = group.founderEmail
    }
    
    func error(_: GroupDetailViewModel, errorMsg: String) {

    }
    
}
