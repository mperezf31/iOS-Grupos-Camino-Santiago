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
    private var userGroups: UserGroups?
    private var groupDetail = [Int : Group]()
    
    init() {
    }
    
    func saveAuthUser(authUser: User) {
       
        do {
            let jsonData = try JSONEncoder().encode(authUser)
            let jsonString = String(data: jsonData, encoding: .utf8)
            UserDefaults.standard.set(jsonString, forKey: AUTH_USER)
        } catch {
            print("Error al guardar el usuario")
        }
      
    }
    
    func closeSession() {
        UserDefaults.standard.removeObject(forKey: AUTH_USER)
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
    
    
    func addGroupDetail(group: Group) {
        if let id = group.id {
            groupDetail[id] = group
        }
    }
    
    func getGroupDetail(groupId: Int) ->Group? {
        return groupDetail[groupId]
    }
    
}
