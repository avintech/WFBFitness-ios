//
//  ContentView.swift
//  wefitbby-ios
//
//  Created by avintech on 19/6/20.
//  Copyright © 2020 avintech. All rights reserved.
//

import SwiftUI
import Firebase
import Combine
//Get Started Page
struct ContentView: View  {
    //var loggedIn = Auth.auth().currentUser
    var loggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
    var body: some View {
        VStack{
            if loggedIn{
                //UserList()
                HomeTabView()
            }
            else{
                GetStartedView()
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
 }
