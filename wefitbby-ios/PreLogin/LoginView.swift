//
//  LoginView.swift
//  wefitbby-ios
//
//  Created by avintech on 22/6/20.
//  Copyright © 2020 avintech. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct LoginView : View{
    @State var email: String = ""
    @State var password: String = ""
    @State var navigateLogin = false
    @State private var navigateToRegister = false
    var loggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(.black)
                
                Image("SignInRRectangle")
                    .resizable()
                    .scaledToFill()
                HStack{
                    VStack{
                        HStack{
                            VStack(alignment: .leading){
                                Image("WFB-white-logo")
                                
                                Text("Sign into your account")
                                    .padding()
                            }
                            Spacer()
                        }
                        
                        Group{
                            ZStack(alignment: .leading) {
                                if email.isEmpty { Text("Email Address").foregroundColor(.init(red: 102/255, green: 102/255, blue: 102/255)) }
                                TextField("", text: $email)
                            }
                            .padding(.top,10)
                            Image("Separator")
                                .padding(.top,5)
                            
                            ZStack(alignment: .leading) {
                                if password.isEmpty { Text("Password").foregroundColor(.init(red: 102/255, green: 102/255, blue: 102/255)) }
                                SecureField("", text: $password)
                            }
                            .padding(.top,10)
                            Image("Separator")
                                .padding(.top,5)
                        }
                        HStack{
                            Spacer()
                            NavigationLink( destination: OneForgetPasswordView()){
                                Text("Forgot Password")
                            }
                        }.padding()
                        
                        Group{
                            HStack{
                                Spacer()
                                Button(action: {
                                    Auth.auth().signIn(withEmail: self.email, password: self.password) { authResult, error in
                                        if error != nil {
                                            print(error)
                                        } else {
                                            if Auth.auth().currentUser != nil{
                                                UserDefaults.standard.set(true, forKey: "loggedIn")
                                                self.navigateLogin = true
                                            }
                                        }
                                    }
                                }) {
                                     LoginViewButton(btnText: "Sign In With Apple")
                                }
                                Spacer()
                            }.background(RoundedRectangle(cornerRadius: 10).fill(LinearGradient(gradient: Gradient(colors: [Color("wfb-blue"), Color("wfb-pink")]), startPoint: .leading, endPoint: .trailing)))
                           
                            Image("ORDivider")
                                .padding(.top, 10)

                            
                            HStack{
                                 Spacer()
                                 Button(action: {
                                    //Insert Sign in with Apple
                                 }) {
                                   LoginViewButton(btnText: "Sign In With Apple", imgName: "applesignin-icon")
                                 }
                                 Spacer()
                            }
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.init(red: 64/255, green: 181/255, blue: 230/255), lineWidth: 1.5))
                            .padding([.top,.bottom], 10)
                            .padding(.bottom, 10)
                            
                             
                             HStack{
                                 Spacer()
                                 Button(action: {
                                    //Insert Sign in with Google
                                    GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
                                    GIDSignIn.sharedInstance()?.signIn()
                                    /*
                                    if UserDefaults.standard.bool(forKey: "loggedIn") == true{
                                        //self.navigateLogin = true
                                    }*/
                                    if Auth.auth().currentUser != nil{
                                        self.navigateLogin = true
                                    }
                                 }) {
                                   LoginViewButton(btnText: "Sign In With Google", imgName: "googlesignin-icon")
                                 }
                                 Spacer()
                             }
                             .background(RoundedRectangle(cornerRadius: 10).stroke(Color.init(red: 64/255, green: 181/255, blue: 230/255), lineWidth: 1.5))
                             .padding(.bottom, 10)
                             
                        }
                        
                        HStack{
                            Text("Not WFB member yet?").background(Color.blue)
                            NavigationLink( destination: SignUpView(signupRouter: signupRouter())){Text("Sign Up")}
                        }
                        NavigationLink( destination: UserList(), isActive: self.$navigateLogin){EmptyView()}
                        
                    }
                    .padding(.trailing, 20)                    //Spacer()
                }
                .padding()
            }
            .edgesIgnoringSafeArea(.all)
            .padding(.bottom, 20)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .foregroundColor(Color.white)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


struct LoginViewButton: View {

    @State var btnText: String = ""
    @State var imgName: String = ""
    var body: some View {
        HStack{
            if imgName.isEmpty {}
            else{
                Image(imgName)//Figure out how to offset to same place
            }
            Text(btnText)
        }
        .padding()
    }
}

struct google : UIViewRepresentable{
    func makeUIView(context: UIViewRepresentableContext<google>) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.colorScheme = .dark
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        return button
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<google>) {
        
    }
    
}

struct SocialLogin: UIViewRepresentable {

    func makeUIView(context: UIViewRepresentableContext<SocialLogin>) -> UIView {
        return UIView()
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<SocialLogin>) {
    }

    func attemptLoginGoogle() {
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        GIDSignIn.sharedInstance()?.signIn()
    }
}
