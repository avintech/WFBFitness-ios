//
//  LoginView.swift
//  wefitbby-ios
//
//  Created by avintech on 22/6/20.
//  Copyright © 2020 avintech. All rights reserved.
//

import SwiftUI
import Firebase

struct LoginView : View{
    @State var email: String = ""
    @State var password: String = ""
    @State private var navigateLogin = false
    @State private var navigateToRegister = false
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Color(.black)
                //Image of rounded rectangle
                Image("SignInRRectangle")
                    .resizable()
                    .scaledToFill()
                VStack{
                    //White Logo
                    Image("WFB-white-logo")
                    //Sign into Account Text
                    Text("Sign into your account")
                    //Email Address inc separator
                    VStack{
                        ZStack(alignment: .leading) {
                            if email.isEmpty { Text("Email Address").foregroundColor(.init(red: 102/255, green: 102/255, blue: 102/255)) }
                                TextField("", text: $email)
                        }
                        Image("Separator").padding(.top,10)
                    }
                    .foregroundColor(Color.white)
                    .padding()
                    //Password inc separator
                    VStack{
                        ZStack(alignment: .leading) {
                            if password.isEmpty { Text("Password").foregroundColor(.init(red: 102/255, green: 102/255, blue: 102/255)) }
                                SecureField("", text: $password)
                        }
                        Image("Separator").padding(.top,10)
                    }
                    .foregroundColor(Color.white)
                    .padding()
                    //Forget password
                    
                    //Sign in Button
                    Button(action: {
                        //Login to account
                        //if successful
                        Auth.auth().signIn(withEmail: self.email, password: self.password) { authResult, error in
                            if error != nil {
                                print(error)
                            } else {
                                //if create successful
                                if Auth.auth().currentUser != nil{
                                    UserDefaults.standard.set(true, forKey: "loggedIn")
                                    self.navigateLogin = true
                                }
                            }
                        }
                        //else show error
                    }) {
                        Text("Login")
                    }
                    NavigationLink( destination: UserList(), isActive: self.$navigateLogin){EmptyView()}
                    
                    //--OR--
                    //Sign In With Apple Button
                    //Sign In With Google Button
                    //Not WFB member yet? Click here to Sign Up
                    Button(action: {
                        self.navigateToRegister = true
                    }) {
                        Text("Register")
                    }
        
                    NavigationLink( destination: SignUpView(signupRouter: signupRouter()), isActive: self.$navigateToRegister){EmptyView()}
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
