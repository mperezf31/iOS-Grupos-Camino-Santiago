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
    
    weak var delegateGroupList: GroupsRepositoryDelegate?
    weak var delegateAddGroup: AddGroupRepositoryDelegate?
    weak var groupDetailDelegate: GroupDetailRepositoryDelegate?
    weak var groupPostsDelegate: GroupPostsRepositoryDelegate?
    weak var groupMembersDelegate :GroupMembersRepositoryDelegate?
    
    private(set) var userGroups: UserGroups?
    private(set) var group: Group?
    
    let userId = 1

    func getGroups() {
        
        AF.request(BASE_URL + "groups", method: .get,headers: getHeaders()).responseDecodable{ (response: DataResponse<UserGroups>) in
            if let userGroups = response.value {
                self.userGroups = userGroups
                self.delegateGroupList?.groupsRetrieved(self, groups: userGroups)
            }else{
                self.delegateGroupList?.error(self, errorMsg: "Se ha producido un error al intentar recuperar los grupos")
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
                        self.delegateGroupList?.groupsRetrieved(self, groups: groups)
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
    
    
    private func getGroup(groupId: Int, completion: @escaping (Group)->(), error: @escaping (String)->()){
        
        AF.request(BASE_URL + "group/\(groupId)", method: .get, headers: getHeaders()).responseDecodable{ (response: DataResponse<Group>) in
            if let group = response.value {
                self.group = group
                completion(group)
            }else{
                error("Se ha producido un error al intentar obtener la información del grupo")
            }
        }
    }
    
    
    func getGroup(groupId: Int){
        if(self.group?.id == groupId){
            self.groupDetailDelegate?.groupRetrieved(self, group: self.group!)
        }else{
            getGroup(groupId: groupId, completion:{ group in
                self.groupDetailDelegate?.groupRetrieved(self, group: group )
            },error:{ msgError in
                self.groupDetailDelegate?.error(self, errorMsg: msgError)
            })
        }
    }
    
    func getGroupMembers(groupId: Int){
        if(self.group?.id == groupId){
            self.groupMembersDelegate?.groupMemberRetrieved(self,  idCurrentUser: self.userId, members: self.getmembers(group: self.group!) )
        }else{
            getGroup(groupId: groupId, completion:{ group in
                self.groupMembersDelegate?.groupMemberRetrieved(self,  idCurrentUser: self.userId, members: self.getmembers(group: group) )
            },error:{ msgError in
                self.groupMembersDelegate?.error(self, errorMsg: msgError)
            })
        }
    }
    
    private func getmembers(group : Group)-> [User]{
        var members = group.members
        members.insert(group.founder!, at: 0)
        return members
    }
    
    func getGroupPosts(groupId: Int){
        if(self.group?.id == groupId){
            self.groupPostsDelegate?.groupPostsRetrieved(self, posts: self.group?.posts ?? Array())
        }else{
            getGroup(groupId: groupId, completion:{ group in
                self.groupPostsDelegate?.groupPostsRetrieved(self, posts: self.group?.posts ?? Array())
            },error:{ msgError in
                self.groupPostsDelegate?.error(self, errorMsg:msgError)
            })
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
        headers["Authentication"] = "\(self.userId)"
        return headers
    }
    
}

protocol GroupsRepositoryDelegate: RepositoryDelegateBase
{
    func groupsRetrieved(_: GroupsRepository, groups: UserGroups)

    func error(_: GroupsRepository, errorMsg: String)
}

protocol AddGroupRepositoryDelegate: RepositoryDelegateBase
{
    func addGroupSuccess(_: GroupsRepository, groupAdded: Group)
    
    func error(_: GroupsRepository, errorMsg: String)
}

protocol GroupDetailRepositoryDelegate: RepositoryDelegateBase
{
    
    func groupRetrieved(_: GroupsRepository, group: Group)
    
}

protocol GroupPostsRepositoryDelegate: RepositoryDelegateBase
{
    
    func groupPostsRetrieved(_: GroupsRepository, posts:[Post])
}

protocol GroupMembersRepositoryDelegate: RepositoryDelegateBase
{
    func groupMemberRetrieved(_: GroupsRepository, idCurrentUser: Int, members: [User])
}

protocol RepositoryDelegateBase: class
{
    func error(_: GroupsRepository, errorMsg: String)
}
