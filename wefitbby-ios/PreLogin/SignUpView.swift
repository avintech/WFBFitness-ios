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
    var step: String = "1"
    var email: String = ""
    var name: String = ""
    var password: String = ""
}

struct SignUpView: View {
    @ObservedObject var signupRouter: signupRouter

    var body: some View {
        if signupRouter.loggedIn == false {
            SignupStep1View(signupRouter: signupRouter)
        } else if signupRouter.loggedIn == true {
            GoalList().navigationBarBackButtonHidden(true)
        }
    }
}

struct SignupStep1View: View {
    @ObservedObject var signupRouter: signupRouter
    @State var email: String = ""
    @State var name: String = ""
    @State private var status: Status = Status(status: true, message: "")
    @State private var emailString  : String = ""
    @State private var isEmailValid : Bool   = false
    @State private var navigateToRegister : Bool = false
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Color(.black)
                VStack{
                    SignupTopView(count: signupRouter.step)
                    Group{
                        VStack(alignment: .leading){
                            Text("Name").foregroundColor(.init(red: 102/255, green: 102/255, blue: 102/255))
                            ZStack(alignment: .leading) {
                                if name.isEmpty { Text("Name").foregroundColor(.init(red: 102/255, green: 102/255, blue: 102/255)) }
                                TextField("", text: $name)
                            }
                            ExDivider().padding(.bottom, 15)
                            
                            Text("Email Address").foregroundColor(.init(red: 102/255, green: 102/255, blue: 102/255))
                            ZStack(alignment: .leading) {
                                if email.isEmpty { Text("Email Address").foregroundColor(.init(red: 102/255, green: 102/255, blue: 102/255)) }
                                TextField("", text: $email, onEditingChanged: { (isChanged) in
                                    if !isChanged {
                                        if self.textFieldValidatorEmail(self.email) {
                                            self.isEmailValid = true
                                        } else {
                                            self.isEmailValid = false
                                            self.email = ""
                                        }
                                    }
                                })
                            }
                            ExDivider()
                        }
                    }
                    if !self.isEmailValid {
                        Text("Email is Not Valid")
                            .font(.callout)
                            .foregroundColor(Color.red)
                    }
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            signupRouter.email = self.email
                            signupRouter.name = self.name
                            signupRouter.step = "2"
                            self.navigateToRegister = true
                        }) {
                            LoginViewButton(imgName: "SignupArrow")
                        }.disabled(!isEmailValid)
                        Spacer()
                    }.background(RoundedRectangle(cornerRadius: 10).fill(LinearGradient(gradient: Gradient(colors: [Color("wfb-blue"), Color("wfb-pink")]), startPoint: .leading, endPoint: .trailing)))
                    NavigationLink( destination: SignupStep2View(signupRouter: signupRouter, name: signupRouter.name , email: signupRouter.email), isActive: self.$navigateToRegister){EmptyView()}
                }.padding()
            }
            .foregroundColor(.white)
        }.edgesIgnoringSafeArea(.all)
    }
    func textFieldValidatorEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
}

struct SignupStep2View : View{
    @ObservedObject var signupRouter: signupRouter
    var name: String
    var email: String
    
    var body: some View{
        GeometryReader{ geo in
            ZStack{
                Color(.black)
                VStack{
                    SignupTopView(count: signupRouter.step)
                }
            }.foregroundColor(.white)
        }.onAppear(){
            print(signupRouter.email)
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


struct ExDivider: View {
    let color: Color = .white
    let width: CGFloat = 1.5
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
    }
}

struct SignupTopView : View{
    @State var count : String = "0"
    var body: some View{
        HStack{
            VStack(alignment: .leading){
                Image("WFB-white-logo")
                HStack{
                    Group{
                        Text("Make the most of your ") + Text("fitness").foregroundColor(.init(red: 64/255, green: 181/255, blue: 242/255)) + Text(" life. Join now!")
                    }.font(Font.custom("Inter-Regular_Bold", size: 20))
                    .padding()
                    Spacer()
                    //Counter
                    Group{
                        VStack{
                            HStack(spacing: 1){
                                Text(count).bold()
                                Text("/2")
                            }
                            Text("STEPS")
                        }
                    }
                }
            }.padding()
            Spacer()
        }
    }
}
