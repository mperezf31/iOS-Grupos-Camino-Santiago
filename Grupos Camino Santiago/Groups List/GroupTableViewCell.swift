//
//  GroupTableViewCell_2.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 25/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var departureDate: UILabel!
    
    var viewModel: GroupViewModel?
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func updateViews()
    {
        self.title?.text = viewModel?.title
        self.groupImage.image = viewModel?.photo
        self.departureDate?.text = "Salida: \(viewModel!.departureDate)"
        
    }
    
    
}
