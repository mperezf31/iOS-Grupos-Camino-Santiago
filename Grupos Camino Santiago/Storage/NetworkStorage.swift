//
//  NetworkStorage.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 05/04/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import Alamofire


class NetworkStorage {
    
    let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    
    func getGroups(userId: Int, completion: @escaping ((Result<UserGroups>) -> ())) {
        
        AF.request(baseUrl + "groups", method: .get,headers: self.getHeaders(userId: userId))
            .responseDecodable{ (response: DataResponse<UserGroups>) in
                
                switch response.response?.statusCode {
                case 200:
                    if let userGroups = response.value {
                        completion(.success(userGroups))
                    }else{
                        completion(.error(StorageError(code: .networkError, msgError: "Se ha producido un error al intentar obtener los grupos")))
                    }
                    
                default:
                    completion(.error(StorageError(code: .networkError, msgError: "Error de conexión internet")))
                    
                }
        }
        
    }
    
    
    func deleteGroup(userId: Int, goupId: Int, completion: @escaping ((Result<Bool>) -> ())) {
        
        AF.request(baseUrl + "group/\(goupId)", method: .delete,headers: self.getHeaders(userId: userId)).responseDecodable{ (response: DataResponse<String>) in
            
            switch response.response?.statusCode {
            case 200:
                completion(.success(true))
            case 404:
                completion(.error(StorageError(code: .networkError, msgError: "El grupo a eliminar no existe")))
            default:
                completion(.error(StorageError(code: .networkError, msgError: "Error de conexión internet")))
                
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
                    completion(.error(StorageError(code: .networkError, msgError: "Se ha producido un error al intentar crear el grupo")))
                }
            }
        }
        catch
        {
            completion(.error(StorageError(code: .invalidData, msgError: "Los datos introducidos no son correctos")))
        }
        
    }
    
    func getGroup(userId: Int, groupId: Int,  completion: @escaping ((Result<Group>) -> ())){
        
        AF.request(baseUrl + "group/\(groupId)", method: .get, headers: self.getHeaders(userId: userId)).responseDecodable{ (response: DataResponse<Group>) in
            
            if let group = response.value {
                completion(.success(group))
            }else{
                completion(.error(StorageError(code: .networkError, msgError: "Se ha producido un error al intentar obtener la información del grupo")))
            }
            
        }
    }
    
    
    func addGroupPost(userId: Int, groupId: Int, message: String, completion: @escaping ((Result<Group>) -> ())){
        
        AF.request(baseUrl + "group/\(groupId)/post", method: .post, parameters : ["content": message, "whenSent": Int64((Date().timeIntervalSince1970).rounded())], encoding: JSONEncoding.default, headers: self.getHeaders(userId: userId)).responseDecodable{ (response: DataResponse<Group>) in
            
            if let group = response.value {
                completion(.success(group))
            }else{
                completion(.error(StorageError(code: .networkError, msgError: "Error de conexión internet")))
            }
        }
        
    }
    
    func joinGroup(userId: Int, groupId: Int , completion: @escaping ((Result<Group>) -> ())) {
        
        AF.request(baseUrl + "group/\(groupId)/pilgrim", method: .post, headers: self.getHeaders(userId: userId)).responseDecodable{ (response: DataResponse<Group>) in
            
            if let group = response.value {
                completion(.success(group))
            }else{
                completion(.error(StorageError(code: .networkError, msgError: "Se ha producido un error al intentar unirse al grupo")))
            }
            
        }
    }
    
    
    func leaveGroup(userId: Int, groupId: Int , completion: @escaping ((Result<Group>) -> ())) {
        
        AF.request(baseUrl + "group/\(groupId)/pilgrim", method: .delete, headers: self.getHeaders(userId: userId)).responseDecodable{ (response: DataResponse<Group>) in
            
            if let group = response.value {
                completion(.success(group))
            }else{
                completion(.error(StorageError(code: .networkError, msgError: "Se ha producido un error al intentar dejar al grupo")))
            }
            
        }
    }
    
    func login(email: String, password: String, completion: @escaping ((Result<User>) -> ())){
        
        let user  = User(email: email, password: password)
        
        do{
            let parameters = try user.toDictionary()
            
            AF.request(baseUrl + "login", method: .post, parameters : parameters, encoding: JSONEncoding.default , headers: HTTPHeaders()).responseDecodable{ (response: DataResponse<User>) in
                
                
                switch response.response?.statusCode {
                case 200:
                    if let user = response.value {
                        completion(.success(user))
                    }else{
                        completion(.error(StorageError(code: .networkError, msgError: "Se ha producido un error al intentar iniciar sesión")))
                    }
                    
                case 404:
                    completion(.error(StorageError(code: .networkError, msgError: "Usuario o contraseña incorrectos")))
                    
                default:
                    completion(.error(StorageError(code: .networkError, msgError: "Error de conexión internet")))
                    
                }
            }
        }
        catch
        {
            completion(.error(StorageError(code: .invalidData, msgError: "Los datos introducidos no son correctos")))
        }
        
    }
    
    
    func register(user: User, completion: @escaping ((Result<User>) -> ())){
        
        do{
            let parameters = try user.toDictionary()
            
            AF.request(baseUrl + "user", method: .post, parameters : parameters, encoding: JSONEncoding.default , headers: HTTPHeaders()).responseDecodable{ (response: DataResponse<User>) in
                
                switch response.response?.statusCode {
                case 200:
                    if let user = response.value {
                        completion(.success(user))
                    }else{
                        completion(.error(StorageError(code: .networkError, msgError: "Se ha producido un error al intentar crear la cuenta")))
                    }
                    
                case 400:
                    completion(.error(StorageError(code: .networkError, msgError: "Ya existe otra cuenta con ese email")))
                    
                default:
                    completion(.error(StorageError(code: .networkError, msgError: "Error de conexión internet")))
                    
                }
            }
        }
        catch
        {
            completion(.error(StorageError(code: .invalidData, msgError: "Los datos introducidos no son correctos")))
        }
        
    }
    
    
    func getHeaders(userId: Int) -> HTTPHeaders {
        var headers = HTTPHeaders()
        headers["Authentication"] = "\(userId)"
        return headers
    }
    
}
