//
//  LocalStorage.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 05/04/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit


class LocalStorage {
    
    private let AUTH_USER = "auth_user"
    
    //Cache the groups list with basic info
    private let listGroupCache = NSCache<NSString, UserGroups>()
    
    //Cache the groups detail
    private let groupDetailCache = NSCache<NSNumber, Group>()
    
    init() {
    }
    
    //Persistence methods
    func saveAuthUser(authUser: User) {
       
        do {
            let jsonData = try JSONEncoder().encode(authUser)
            let jsonString = String(data: jsonData, encoding: .utf8)
            UserDefaults.standard.set(jsonString, forKey: AUTH_USER)
        } catch {
            print("Error al guardar el usuario")
        }
      
    }
    
    func getAuthUser() ->User? {
        
        if let jsonString = UserDefaults.standard.string(forKey: AUTH_USER){
            
            do {
                return try JSONDecoder().decode(User.self, from:Data(jsonString.utf8))
            } catch {
                return nil
            }
            
        }else{
            return nil
        }
        
    }
    
    func closeSession() {
        UserDefaults.standard.removeObject(forKey: AUTH_USER)
        clearCache()
    }
    
    
    //Cache methods
    func addGroupList(groups: UserGroups) {
        self.listGroupCache.setObject(groups, forKey: "GroupsList")
    }
    
    func getGroupList() ->UserGroups? {
        return self.listGroupCache.object(forKey: "GroupsList")
    }
    
    func addGroupDetail(group: Group) {
        if let id = group.id {
            self.groupDetailCache.setObject(group, forKey: NSNumber(value: id))
        }
    }
    
    func getGroupDetail(groupId: Int) ->Group? {
        return self.groupDetailCache.object(forKey: NSNumber(value: groupId))
    }
    
    func updateGroupDetail(group: Group) {
        addGroupDetail(group: group)
    }
    
    func clearGroupCache(groupId : Int) {
         return self.groupDetailCache.removeObject(forKey: NSNumber(value: groupId))
    }
    
    func addNewGroup(groupToAdd : Group) {
        if let groupsList = getGroupList(){
            groupsList.groupsCreated.append(groupToAdd)
            addGroupList(groups: groupsList)
            addGroupDetail(group: groupToAdd)
        }
    }
    
    func deleteGroup(goupId: Int){
        if let groupsList = getGroupList(){
            for group in groupsList.groupsCreated {
                if(group.id == goupId){
                    if let groupToDelete = groupsList.groupsCreated.index(of: group){
                        groupsList.groupsCreated.remove(at:groupToDelete)
                    }
                }
            }
            addGroupList(groups: groupsList)
        }
       
    }
    
    
    func clearCache() {
        self.listGroupCache.removeAllObjects()
        self.groupDetailCache.removeAllObjects()
    }
    
    func clearGroupsListCache() {
        self.listGroupCache.removeAllObjects()
    }
    
}
