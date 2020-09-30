//
//  User.swift
//  wefitbby-ios
//
//  Created by avintech on 23/6/20.
//  Copyright © 2020 avintech. All rights reserved.
//

import SwiftUI

struct User: Codable,Identifiable{
    let id = UUID()
    var email: String
    var firebase_id: String
    var usertype_id: String
}
