//
//  UserList.swift
//  wefitbby-ios
//
//  Created by avintech on 21/6/20.
//  Copyright © 2020 avintech. All rights reserved.
//

import SwiftUI
import Firebase

struct UserList: View {
    @State var users: [User] = []
    
    var body: some View {
        
        List(users){ user in
            Text(user.email)
        }
        .onAppear(){
            let user = Auth.auth().currentUser
            UserApi().getUsers(firebaseid: user!.uid) { (users) in
                    self.users = users
                }
        }
        
    }
}

struct UserList_Previews: PreviewProvider {
    static var previews: some View {
        UserList()
    }
}
