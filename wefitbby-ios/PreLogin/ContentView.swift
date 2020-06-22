//
//  ContentView.swift
//  wefitbby-ios
//
//  Created by avintech on 19/6/20.
//  Copyright © 2020 avintech. All rights reserved.
//

import SwiftUI
import Combine
//Get Started Page
struct ContentView: View  {
    var body: some View {
        NavigationView{
        NavigationLink(destination: UserList()) {
            Text("go!")
            }
            
        }
    }
}
struct SecondContentView: View{
    var body: some View{
        Text("hello world")
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
 }
