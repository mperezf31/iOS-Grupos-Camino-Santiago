//
//  GroupsStorage.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 23/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import Alamofire

class GroupsStorage
{
    
    weak var delegate: GroupsStorageDelegate?
    
    private let networkStorage :NetworkStorage
    private let localStorage: LocalStorage
    
    private var authUser : User?

    init(baseUrl: String) {
        self.networkStorage = NetworkStorage(baseUrl: baseUrl)
        self.localStorage = LocalStorage()
    }
    
    func getAuthUser() ->User? {
        if let user = self.authUser {
            return user
        }else{
            self.authUser = self.localStorage.getAuthUser()
            return self.authUser
        }
    }
    
    func getAuthUserId() ->Int? {
         return getAuthUser()?.id
    }
    
    func getGroups(enableCache: Bool) {
        if !enableCache {
            self.localStorage.clearCache()
        }
        
        if let authUserId = getAuthUserId(){
            if let groupList = self.localStorage.getGroupList(){
                self.delegate?.groupsUpdate(self, groups: groupList)
            }else{
                self.networkStorage.getGroups(userId: authUserId) { (response) in
                    
                    switch response {
                        
                    case let .success(groups):
                        self.localStorage.addGroupList(groups: groups)
                        self.delegate?.groupsUpdate(self, groups: groups)
                        
                    case let .error(error):
                        self.delegate?.error(self, error:error)
                        
                    }
                }
            }
           
        }else{
            self.delegate?.error(self, error: StorageError(code: .unauthenticatedUser, msgError: "Usuario no autenticado"))
        }
    }

    func deleteGroup(groupId: Int){
        if let authUserId = getAuthUserId(){
            self.networkStorage.deleteGroup(userId: authUserId, goupId: groupId) { (response) in
                
                switch response {
                    
                case .success(_):
                    //Update cache groups
                    self.localStorage.deleteGroup(goupId: groupId)
                    if let groupList = self.localStorage.getGroupList(){
                        self.delegate?.groupsUpdate(self, groups: groupList)
                    }
                    
                case let .error(error):
                    self.delegate?.error(self, error:error)
                }
            }
            
        }else{
            self.delegate?.error(self, error: StorageError(code: .unauthenticatedUser, msgError: "Usuario no autenticado"))
        }
    }
    
    func addGroup(groupToAdd: Group, completion: @escaping ((Result<Group>) -> ())) {
        if let authUserId = getAuthUserId(){
            self.networkStorage.addGroup(userId: authUserId, groupToAdd: groupToAdd){ (response) in
                
                //Add group to the cache
                if case let .success(group) = response {
                    self.localStorage.addNewGroup(groupToAdd: group)
                    if let groupList = self.localStorage.getGroupList(){
                        self.delegate?.groupsUpdate(self, groups: groupList)
                    }
                }
                
                completion(response)
            }
            
        }else{
            completion(.error(StorageError(code: .unauthenticatedUser, msgError: "Usuario no autenticado")))
        }
        
    }
    
    
    func getGroup(groupId: Int, completion: @escaping ((Result<Group>) -> ())){
        if let authUserId = getAuthUserId(){
            
            if let group = self.localStorage.getGroupDetail(groupId: groupId){
                completion(.success(group))
            }else{
                networkStorage.getGroup(userId: authUserId, groupId: groupId){(response) in
                    
                    if case .success(let group) = response {
                        self.localStorage.addGroupDetail(group: group)
                    }
                    
                    completion(response)
                }
            }
            
        }else{
            completion(.error(StorageError(code: .unauthenticatedUser, msgError: "Usuario no autenticado")))
        }
    }
    
    
    func getGroupPosts(groupId: Int, completion: @escaping ((Result<[Post]>) -> ())){
        if let group = self.localStorage.getGroupDetail(groupId: groupId){
            completion(.success(group.posts))
        }else{
            getGroup( groupId: groupId){(response) in
                
                switch response {
                    
                case let .success(group):
                    completion(.success(group.posts))
                    
                case let .error(error):
                    completion(.error(error))
                    
                }
            }
        }
    }
    
    
    func joinGroup(groupId: Int , join: Bool, completion: @escaping ((Result<Group>) -> ())) {
        
        if let authUserId = getAuthUserId(){
            
            if(join){
                self.networkStorage.joinGroup(userId: authUserId, groupId: groupId) { (response) in
                    
                    switch response {
                        
                    case let .success(group):
                        self.getGroups(enableCache: false)
                        completion(.success(group))
                        
                    case let .error(error):
                        completion(.error(error))
                    }
                    
                }
                
            }else{
                self.networkStorage.leaveGroup(userId: authUserId, groupId: groupId) { (response) in
                    
                    switch response {
                        
                    case let .success(group):
                        self.getGroups(enableCache: false)
                        completion(.success(group))
                        
                    case let .error(error):
                        completion(.error(error))
                    }
                    
                }
            }
            
        }else{
            completion(.error(StorageError(code: .unauthenticatedUser, msgError: "Usuario no autenticado")))
        }
        
    }
    
    
    func login(email: String, password: String, completion: @escaping ((Result<User>) -> ())){
        
        self.networkStorage.login(email: email, password: password) { (response) in
            
            //iSave authentication user
            if case .success(let user) = response {
                self.localStorage.saveAuthUser(authUser: user)
            }
            completion(response)
            
        }
        
    }
    
    
    func register(user: User, completion: @escaping ((Result<User>) -> ())){
        
        self.networkStorage.register(user: user) { (response) in
            
            //iSave register user
            if case .success(let user) = response {
                self.localStorage.saveAuthUser(authUser: user)
            }
            completion(response)
            
        }
        
    }
    
    func logout(){
        self.authUser = nil
        self.localStorage.closeSession()
    }
    
    
    func getHeaders(userId : Int) -> HTTPHeaders {
        var headers = HTTPHeaders()
        headers["Authentication"] = "\(userId)"
        return headers
    }
    
}

protocol GroupsStorageDelegate: class
{
    func groupsUpdate(_: GroupsStorage, groups: UserGroups)
    
    func error(_: GroupsStorage, error: StorageError)
}

enum Result<T> {
    case success(T)
    case error(StorageError)
}

struct StorageError
{
    let code: ErrorCode
    let msgError : String
    
    init(code:ErrorCode, msgError: String) {
        self.code = code
        self.msgError = msgError
    }
    
}

enum ErrorCode {
    case invalidData
    case networkError
    case unauthenticatedUser
}
