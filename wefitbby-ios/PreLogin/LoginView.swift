//
//  LoginView.swift
//  wefitbby-ios
//
//  Created by avintech on 22/6/20.
//  Copyright © 2020 avintech. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack{
            //Image
            //Shadow Overlay
            VStack{
                VStack(alignment: .leading){
                Text("Email Address")
                TextField("Enter your Email Address", text: $email)
                                  .cornerRadius(20)
                                  .background(Color.white)
                }
                .padding()
                VStack(alignment: .leading){
                Text("Password")
                SecureField("Enter your Password", text: $password)
                                  .cornerRadius(20)
                                  .background(Color.white)
                }
                .padding()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
