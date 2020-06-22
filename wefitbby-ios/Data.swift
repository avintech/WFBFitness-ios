//
//  Data.swift
//  wefitbby-ios
//
//  Created by avintech on 21/6/20.
//  Copyright © 2020 avintech. All rights reserved.
//

import SwiftUI

struct User: Codable,Identifiable{
    var id: String
    
    var email: String
    var password: String
    var firebase_id: String
    var usertype_id: String
}

class Api{
    func getUsers(completion: @escaping ([User]) -> ()){
        guard let url = URL(string: "http://localhost/REST_API/") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let users = try! JSONDecoder().decode([User].self, from: data!)
            print(users)
            
            DispatchQueue.main.async {
                completion(users)
            }
        }.resume()
    }
}
