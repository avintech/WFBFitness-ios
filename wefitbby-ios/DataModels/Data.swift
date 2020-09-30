//
//  Data.swift
//  wefitbby-ios
//
//  Created by avintech on 21/6/20.
//  Copyright © 2020 avintech. All rights reserved.
//

import SwiftUI

struct Status: Codable{
    var status: Bool
    var message: String
}

class UserApi{
    func getUsers(firebaseid: String, completion: @escaping ([User]) -> ()){
        let firebaseid = firebaseid
        guard let url = URL(string: "http://localhost/REST_API/authentication.php?actionName=readUser&firebaseid=\(firebaseid)") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let users = try! JSONDecoder().decode([User].self, from: data!)
            print(users)
            
            DispatchQueue.main.async {
                completion(users)
            }
        }.resume()
    }
    
    func insertUser(email: String, firebaseid: String,completion: @escaping (Status) -> ()){
        let email = email
        let firebaseid = firebaseid
        guard let url = URL(string: "http://localhost/REST_API/authentication.php?actionName=createUser&userEmail=\(email)&userFirebaseid=\(firebaseid)") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let users = try! JSONDecoder().decode(Status.self, from: data!)
            print(users)
            
            DispatchQueue.main.async {
                completion(users)
            }
        }.resume()
    }
    
    func updateUserToCreator(firebaseid: String, completion: @escaping (Status) -> ()){
        let firebaseid = firebaseid
        guard let url = URL(string: "http://localhost/REST_API/authentication.php?actionName=updateUserToCreator&firebaseid=\(firebaseid)") else {return}
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let users = try! JSONDecoder().decode(Status.self, from: data!)
            print(users)
            
            DispatchQueue.main.async {
                completion(users)
            }
        }.resume()
    }
}

class GoalsApi{
   func getGoals(completion: @escaping ([Goals]) -> ()){
        guard let url = URL(string: "http://localhost/REST_API/goals.php?actionName=selectGoals") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let goals = try! JSONDecoder().decode([Goals].self, from: data!)
            print(goals)
            
            DispatchQueue.main.async {
                completion(goals)
            }
        }.resume()
    }
    
    
}
