//
//  SignUpView.swift
//  wefitbby-ios
//
//  Created by avintech on 22/6/20.
//  Copyright © 2020 avintech. All rights reserved.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State private var navigateToRegister = false
    @State private var status: Status = Status(status: true, message: "")
    
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
                        //Create Account
                        Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
                            if error != nil {
                                print("Error")
                            } else {
                                //if create successful
                                if Auth.auth().currentUser != nil{
                                    let user  = Auth.auth().currentUser
                                    UserApi().insertUser(email: user!.email!, firebaseid: user!.uid) { (status) in
                                        self.status = status
                                        print(self.status.message)
                                    }
                                    self.navigateToRegister = true
                                }
                            }
                        }
                    }) {
                        Text("Register")
                    }
                    
                    NavigationLink( destination: UserList(), isActive: self.$navigateToRegister){EmptyView()}
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
