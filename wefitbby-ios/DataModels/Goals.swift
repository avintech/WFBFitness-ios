//
//  Goals.swift
//  wefitbby-ios
//
//  Created by avintech on 23/6/20.
//  Copyright © 2020 avintech. All rights reserved.
//

import SwiftUI

struct Goals: Codable,Identifiable{
    let id = UUID()
    
    var goals_id: String
    var goals_name: String
    var goals_short_description: String
    var goals_image_asset_name: String
}
