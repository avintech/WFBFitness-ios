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
    private var host : String = "http://localhost/REST_API/"
    func getUsers(firebaseid: String, completion: @escaping ([User]) -> ()){
        let firebaseid = firebaseid
        guard let url = URL(string: host + "authentication.php?actionName=readUser&firebaseid=\(firebaseid)") else {return}
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                    DispatchQueue.main.async {
                        completion(decodedResponse)
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")

        }.resume()
    }
    
    func insertUser(email: String, firebaseid: String,completion: @escaping (Status) -> ()){
        let email = email
        let firebaseid = firebaseid
        guard let url = URL(string: host + "authentication.php?actionName=createUser&userEmail=\(email)&userFirebaseid=\(firebaseid)") else {return}
        
        /*URLSession.shared.dataTask(with: url) { (data, _, error) in
            let users = try! JSONDecoder().decode(Status.self, from: data!)
            print(users)
            
            DispatchQueue.main.async {
                completion(users)
            }
        }.resume()*/
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Status.self, from: data) {
                    DispatchQueue.main.async {
                        completion(decodedResponse)
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")

        }.resume()
    }
    
    func updateUserToCreator(firebaseid: String, completion: @escaping (Status) -> ()){
        let firebaseid = firebaseid
        guard let url = URL(string: host + "authentication.php?actionName=updateUserToCreator&firebaseid=\(firebaseid)") else {return}
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
    private var host : String = "http://localhost/REST_API/"

   func getGoals(completion: @escaping ([Goals]) -> ()){
        guard let url = URL(string: host + "goals.php?actionName=selectGoals") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let goals = try! JSONDecoder().decode([Goals].self, from: data!)
            print(goals)
            
            DispatchQueue.main.async {
                completion(goals)
            }
        }.resume()
    }
    
    
}
