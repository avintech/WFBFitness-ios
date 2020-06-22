//
//  LoginView.swift
//  wefitbby-ios
//
//  Created by avintech on 22/6/20.
//  Copyright © 2020 avintech. All rights reserved.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State private var navigateLogin = false
    @State private var navigateToRegister = false
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                //Image
                //Shadow Overlay
                VStack{
                    VStack(alignment: .leading){
                    Text("Email Address")
                        TextField("Enter your Email Address", text: self.$email)
                                      .cornerRadius(20)
                                      .background(Color.white)
                    }
                    .padding()
                    VStack(alignment: .leading){
                    Text("Password")
                        SecureField("Enter your Password", text: self.$password)
                                      .cornerRadius(20)
                                      .background(Color.white)
                    }
                    .padding()
                    
                    Button(action: {
                        //Login to account
                        //if successful
                        Auth.auth().signIn(withEmail: self.email, password: self.password) { authResult, error in
                            if error != nil {
                                print("Error")
                            } else {
                                //if create successful
                                if Auth.auth().currentUser != nil{
                                    self.navigateLogin = true
                                }
                            }
                        }
                        self.navigateLogin = true
                        //else show error
                    }) {
                        Text("Login")
                    }
                    
                    Button(action: {
                        self.navigateToRegister = true
                    }) {
                        Text("Register")
                    }
                    
                    NavigationLink( destination: UserList(), isActive: self.$navigateLogin){EmptyView()}
                    
                    NavigationLink( destination: SignUpView(), isActive: self.$navigateToRegister){EmptyView()}
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
