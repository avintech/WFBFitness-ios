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
    var loggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
    
    var body: some View {
        NavigationView{
            List(users){ user in
                Text(user.email)
                Text(user.firebase_id)
            }
            .onAppear(){
                let user = Auth.auth().currentUser
                UserApi().getUsers(firebaseid: user!.uid) { (users) in
                        self.users = users
                    }
            }.navigationBarItems(trailing:
                                    Button("log out") {
                                        do {
                                                try Auth.auth().signOut()
                                            UserDefaults.standard.set(false, forKey: "loggedIn")
                                            } catch {
                                            }
                                    }
                                )
            
        }
    }
}


struct UserList_Previews: PreviewProvider {
    static var previews: some View {
        UserList()
    }
}
