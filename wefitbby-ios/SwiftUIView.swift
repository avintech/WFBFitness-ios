//
//  SwiftUIView.swift
//  wefitbby-ios
//
//  Created by Avin Tech on 15/10/20.
//  Copyright © 2020 avintech. All rights reserved.
//

import SwiftUI

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

struct SwiftUIView: View {

@State private var emailString  : String = ""
@State private var textEmail    : String = ""
@State private var isEmailValid : Bool   = true

var body: some View {
    VStack {
        TextField("email...", text: $textEmail, onEditingChanged: { (isChanged) in
            if !isChanged {
                if self.textFieldValidatorEmail(self.textEmail) {
                    self.isEmailValid = true
                } else {
                    self.isEmailValid = false
                    self.textEmail = ""
                }
            }
        })
            //.modifier(ClearButton(text: $email))
            .font(.headline)
            .padding(10)
            .foregroundColor(.black)
            .background(Color.white)
            .frame(width: 300, height: 40, alignment: .center)
            .cornerRadius(20)
            .autocapitalization(.none)

        if !self.isEmailValid {
            Text("Email is Not Valid")
                .font(.callout)
                .foregroundColor(Color.red)
        }
    }
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
