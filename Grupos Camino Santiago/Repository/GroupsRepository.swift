//
//  GroupsRepository.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 23/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import Foundation
import Alamofire

class GroupsRepository
{
    private let BASE_URL = "http://ec2-35-156-79-168.eu-central-1.compute.amazonaws.com/"

    weak var delegate: GroupsRepositoryDelegate?
    private(set) var groups: UserGroups?
    
    func getGroups() {

        var headers = HTTPHeaders()
        headers["Authentication"] = "1"
        
        AF.request(BASE_URL + "groups", method: .get,headers: headers).responseDecodable{ (response: DataResponse<UserGroups>) in
            if let userGroups = response.value {
                self.delegate?.udateGroups(self, groups: userGroups)
            }else{
                self.delegate?.error(self, errorMsg: "Se ha producido un error al intentar recuperar los grupos")
            }
        }
    
    }
    
    func add(note: Group)
    {

    }
}

protocol GroupsRepositoryDelegate: class
{
    func udateGroups(_: GroupsRepository, groups: UserGroups)
    
    func error(_: GroupsRepository, errorMsg: String)
}
