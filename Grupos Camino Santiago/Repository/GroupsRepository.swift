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
    
    private(set) var groups: UserGroups?
    
    func getGroups() {
        
        AF.request(BASE_URL + "groups", method: .get,headers: getHeaders()).responseDecodable{ (response: DataResponse<UserGroups>) in
            if let userGroups = response.value {
                self.delegate?.udateGroups(self, groups: userGroups)
            }else{
                self.delegate?.error(self, errorMsg: "Se ha producido un error al intentar recuperar los grupos")
            }
        }
        
    }
    
    func addGroup(groupToAdd: Group) {
        
        do{
            var parameters = try groupToAdd.toDictionary()
            parameters["posts"] = nil
            parameters["members"] = nil
            
            print(parameters)
            
            AF.request(BASE_URL + "group", method: .post, parameters : parameters, encoding: JSONEncoding.default , headers: getHeaders()).responseDecodable{ (response: DataResponse<Group>) in
                
                print(response.response?.statusCode ?? "status code not found")
                print(response.error ?? "not error not found")
                print(response.value ?? "not data not found")
                
                if let group = response.value {
                    self.delegateAddGroup?.addGroupSuccess(self, groupAdded: group)
                }else{
                    self.delegate?.error(self, errorMsg: "Se ha producido un error al intentar crear el grupo")
                }
            }
        }
        catch
        {
            self.delegate?.error(self, errorMsg: "Se ha producido un error al intentar crear el grupo")
        }
        
        
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
    
    func error(_: GroupsRepository, errorMsg: String)
}

protocol AddGroupRepositoryDelegate:class {
    func addGroupSuccess(_: GroupsRepository, groupAdded: Group)
    
    func error(_: GroupsRepository, errorMsg: String)
}
