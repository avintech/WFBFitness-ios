//
//  LoginView.swift
//  wefitbby-ios
//
//  Created by avintech on 22/6/20.
//  Copyright © 2020 avintech. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import Firebase
import GoogleSignIn

class loginRouter: ObservableObject{
    let objectWillChange = PassthroughSubject<loginRouter,Never>()
    var loggedIn: Bool = UserDefaults.standard.bool(forKey: "loggedIn")
    {
        didSet {
            objectWillChange.send(self)
        }
    }
}

struct LoginView: View {
    @ObservedObject var loginRouter: loginRouter

    var body: some View {
        if loginRouter.loggedIn == false {
            LoginFakeView(loginRouter: loginRouter)
        } else if loginRouter.loggedIn == true {
            UserList().navigationBarBackButtonHidden(true)
        }
    }
}

struct LoginFakeView : View{
    @ObservedObject var loginRouter: loginRouter
    @State var email: String = ""
    @State var password: String = ""
    @State var navigateLogin = false
    @State private var navigateToSignup = false
    @State private var alertItem: AlertItem? = nil
    var loggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
    @State private var isPresentingSheet = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(.black)
                
                Image("SignInRRectangle")
                    .resizable()
                    .scaledToFill()
                
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
                    }
                    Group{
                        HStack{
                            Spacer()
                            Button(action: {
                                let actionCodeSettings = ActionCodeSettings()
                                actionCodeSettings.url = URL(
                                  string: "https://wefitbbyv1.page.link/sign-in"    // 1
                                )
                                actionCodeSettings.handleCodeInApp = true
                                actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)

                                Auth.auth().sendSignInLink(toEmail: self.email,
                                                           actionCodeSettings: actionCodeSettings)
                                { error in   // 2
                                  if let error = error {
                                    alertItem = AlertItem(
                                      title: "The sign in link could not be sent.",
                                      message: error.localizedDescription
                                    )
                                  }
                                  else if error == nil {
                                    alertItem = AlertItem(
                                      title: "Email Sent~",
                                        message: "Check yo email dumbass"
                                    )
                                  }
                                }
                            }) {
                                 LoginViewButton(btnText: "Sign In with Email")
                            }
                            Spacer()
                        }.frame(height: 56, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 10).fill(LinearGradient(gradient: Gradient(colors: [Color("wfb-blue"), Color("wfb-pink")]), startPoint: .leading, endPoint: .trailing)))
                        .padding(.top,10)
                       
                        Image("ORDivider")
                            .padding(.top, 10)

                        
                        HStack{
                            Spacer()
                            SignInWithAppleToFirebase(
                                { response in
                                   if response == .success {
                                       //self.text = "Success"
                                    print("successful in loggin in w apple")
                                    print(Auth.auth().currentUser!.uid)
                                   } else if response == .error {
                                       //self.text = "Error"
                                    print("fail")
                                   }
                                }
                            )
                            Spacer()
                        }.frame(height: 56, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.init(red: 64/255, green: 181/255, blue: 230/255), lineWidth: 1.5))
                        .padding([.top,.bottom], 10)
                        .padding(.bottom, 10)
                        
                         HStack{
                             Spacer()
                             Button(action: {
                                //Insert Sign in with Google
                                GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
                                GIDSignIn.sharedInstance()?.signIn()
                                
                             }) {
                               LoginViewButton(btnText: "Sign In With Google", imgName: "googlesignin-icon")
                             }
                             Spacer()
                         }.frame(height: 56, alignment: .center)
                         .background(RoundedRectangle(cornerRadius: 10).stroke(Color.init(red: 64/255, green: 181/255, blue: 230/255), lineWidth: 1.5))
                         .padding(.bottom, 10)
                         
                    }
                    
                    HStack{
                        Text("Not WFB member yet?").background(Color.blue)
                        Button(action: {
                            self.navigateToSignup = true
                        }) {
                            Text("Sign Up")
                        }
                        NavigationLink(destination: SignUpView(signupRouter: signupRouter()), isActive: $navigateToSignup, label: { EmptyView() })
                    }
                    
                }.padding()
                .padding()
            }
        }
        .edgesIgnoringSafeArea([.top,.trailing,.leading])
        .foregroundColor(Color.white)
        .alert(item: $alertItem) { alert -> Alert in    // *
          Alert(
            title: Text(alert.title),
            message: Text(alert.message)
          )
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginRouter: loginRouter())
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

struct AlertItem: Identifiable {    // *
  var id = UUID()
  var title: String
  var message: String
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
