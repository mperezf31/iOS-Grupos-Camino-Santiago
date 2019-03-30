//
//  GroupsRepository.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 23/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import Alamofire

class GroupsRepository
{
    private let BASE_URL = "http://ec2-35-156-79-168.eu-central-1.compute.amazonaws.com/"
    
    weak var delegate: GroupsRepositoryDelegate?
    weak var delegateAddGroup: AddGroupRepositoryDelegate?
    
    private(set) var userGroups: UserGroups?
    
    func getGroups() {
        
        AF.request(BASE_URL + "groups", method: .get,headers: getHeaders()).responseDecodable{ (response: DataResponse<UserGroups>) in
            if let userGroups = response.value {
                self.userGroups = userGroups
                self.delegate?.udateGroups(self, groups: userGroups)
            }else{
                self.delegate?.error(self, errorMsg: "Se ha producido un error al intentar recuperar los grupos")
            }
        }
        
    }
    
    func addGroup(groupToAdd: Group) {
        
        do{
            let parameters = try groupToAdd.toDictionary()
            print(parameters)
            
            AF.request(BASE_URL + "group", method: .post, parameters : parameters, encoding: JSONEncoding.default , headers: getHeaders()).responseDecodable{ (response: DataResponse<Group>) in
                
                print(response.response?.statusCode ?? "status code not found")
                print(response.error ?? "error not found")
                print(response.value ?? "data not found")
                
                if let group = response.value {
                    self.delegateAddGroup?.addGroupSuccess(self, groupAdded: group)
                    self.userGroups?.groupsCreated.append(group)
                    if let groups = self.userGroups {
                        self.delegate?.udateGroups(self, groups: groups)
                    }
                }else{
                    self.delegateAddGroup?.error(self, errorMsg: "Se ha producido un error al intentar crear el grupo")
                }
            }
        }
        catch
        {
            self.delegateAddGroup?.error(self, errorMsg: "Los datos introducidos no son correctos")
        }
        
        
    }
    
    func getGroup(groupId: Int){
      //  self.delegate?.groupRetrieved(self, group: Group())
        self.delegate?.error(self, errorMsg: "Se ha producido un error al intentar crear el grupo")
    }
    
    
    func convertToDictionary(data: Data) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func getHeaders() -> HTTPHeaders {
        var headers = HTTPHeaders()
        headers["Authentication"] = "1"
        return headers
    }
    
}

protocol GroupsRepositoryDelegate: class
{
    func udateGroups(_: GroupsRepository, groups: UserGroups)
    
    func groupRetrieved(_: GroupsRepository, group: Group)

    func error(_: GroupsRepository, errorMsg: String)
}

protocol AddGroupRepositoryDelegate:class {
    func addGroupSuccess(_: GroupsRepository, groupAdded: Group)
    
    func error(_: GroupsRepository, errorMsg: String)
}
