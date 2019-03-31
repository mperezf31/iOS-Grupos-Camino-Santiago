//
//  GroupMemberUiCellCollectionViewCell.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

class GroupMemberUiCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var rol: UILabel!
    
    var viewModel: MemberViewModel?
    {
        didSet
        {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    private func updateViews()
    {
        self.name?.text = viewModel?.name
        self.rol?.text = viewModel?.rol
    }
    
}
