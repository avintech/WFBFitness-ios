//
//  SignUpView.swift
//  wefitbby-ios
//
//  Created by avintech on 22/6/20.
//  Copyright © 2020 avintech. All rights reserved.
//
import Foundation
import Combine
import SwiftUI
import Firebase

class signupRouter: ObservableObject{
    let objectWillChange = PassthroughSubject<signupRouter,Never>()
    var loggedIn: Bool = UserDefaults.standard.bool(forKey: "loggedIn")
    {
            didSet {
                objectWillChange.send(self)
            }
        }
}

struct SignUpView: View {
    @ObservedObject var signupRouter: signupRouter

    var body: some View {
        if signupRouter.loggedIn == false {
            SignUpFakeView(signupRouter: signupRouter)
        } else if signupRouter.loggedIn == true {
            GoalList().navigationBarBackButtonHidden(true)
        }
    }
}

struct SignUpFakeView: View {
    @ObservedObject var signupRouter: signupRouter
    @State var email: String = ""
    @State var password: String = ""
    @State private var status: Status = Status(status: true, message: "")
    @State var goals: [Goals] = []
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                //Image
                Color(.black)
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
                                print(error)
                            } else {
                                //if create successful
                                if Auth.auth().currentUser != nil{
                                    let user  = Auth.auth().currentUser
                                    UserApi().insertUser(email: user!.email!, firebaseid: user!.uid) { (status) in
                                        self.status = status
                                        print(self.status.message)
                                    }
                                    UserDefaults.standard.set(true, forKey: "loggedIn")
                                    signupRouter.loggedIn = true
                                    //self.navigateToRegister = true
                                }
                            }
                        }
                    }) {
                        Text("Register")
                    }
                    
                    //NavigationLink( destination: GoalList(), isActive: self.$navigateToRegister){EmptyView()}
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(signupRouter: signupRouter())
    }
}

struct GoalList: View {
    //var goals: [Goals] = []
    var body: some View {
        NavigationView{
            ZStack{
                Color(.black)
                GeometryReader{ geo in
                    VStack{
                        HStack{
                            Button(action: {
                                
                            }){
                                Text("Gain Strength")
                            }
                            Button(action: {
                                
                            }){
                                Text("Build Muscle")
                            }
                        }
                        HStack{
                            Button(action: {
                                
                            }){
                                Text("Athletic Performance")
                            }
                            Button(action: {
                                
                            }){
                                Text("Lose Weight")
                            }
                        }
                        HStack{
                            Button(action: {
                                
                            }){
                                Text("Body Toning")
                            }
                            Button(action: {
                                
                            }){
                                Text("Diet Plan")
                            }
                        }
                        HStack{
                            Text("I will choose later,")
                            Button(action: {
                                
                            }){
                                Text("skip for now.")
                            }
                        }
                    }
                }
            }
        }
    }
}


