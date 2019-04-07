//
//  LocalStorage.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 05/04/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

class LocalStorage {
    
    
    private var userGroups: UserGroups?
    private var groupDetail = [Int : Group]()
    
    private var authuser : User?
    
    init() {
    }
    
    func saveAuthUser(authUser: User) {
        self.authuser = authUser
    }

    func getAuthUser() ->User? {
        return authuser
    }

    func addUserGroup(groupToAdd: Group) {
        self.userGroups?.groupsCreated.append(groupToAdd)
    }
    
    
    func getUserGroups() -> UserGroups? {
        return userGroups
    }
    
    func addGroupDetail(group: Group) {
        if let id = group.id {
            groupDetail[id] = group
        }
    }
    
    func getGroupDetail(groupId: Int) ->Group? {
        return groupDetail[groupId]
    }
    
}
