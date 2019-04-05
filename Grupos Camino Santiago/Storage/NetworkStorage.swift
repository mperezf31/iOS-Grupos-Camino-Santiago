//
//  NetworkStorage.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 05/04/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import Foundation
import Alamofire


class NetworkStorage {
    
    let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    
    func getGroups(userId: Int, completion: @escaping ((Result<UserGroups>) -> ())) {
        
        AF.request(baseUrl + "groups", method: .get,headers: self.getHeaders(userId: userId))
            .responseDecodable{ (response: DataResponse<UserGroups>) in
                
            if let userGroups = response.value {
                completion(.success(userGroups))
            }else{
                completion(.error(StorageError.networkError("Se ha producido un error al intentar recuperar los grupos")))
            }
                
        }
        
    }
    
    
    func addGroup(userId: Int, groupToAdd: Group,  completion: @escaping ((Result<Group>) -> ())) {
        
        do{
            let parameters = try groupToAdd.toDictionary()
            
            AF.request(baseUrl + "group", method: .post, parameters : parameters, encoding: JSONEncoding.default , headers: self.getHeaders(userId: userId)).responseDecodable{ (response: DataResponse<Group>) in

                if let group = response.value {
                    completion(.success(group))
                }else{
                    completion(.error(StorageError.networkError("Se ha producido un error al intentar crear el grupo")))
                }
            }
        }
        catch
        {
            completion(.error(StorageError.invalidData("Los datos introducidos no son correctos")))
        }
        
    }
    
    
    func getHeaders(userId: Int) -> HTTPHeaders {
        var headers = HTTPHeaders()
        headers["Authentication"] = "\(userId)"
        return headers
    }
    
}
