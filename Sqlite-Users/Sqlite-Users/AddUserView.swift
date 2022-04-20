//
//  AddUserView.swift
//  Sqlite-Users
//
//  Created by Qingchen on 2022/4/18.
//

import SwiftUI

struct AddUserView: View {
    
    @State var name: String = ""
    @State var email: String = ""
    @State var age: String = ""
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            TextField("Enter name", text: $name)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            TextField("Enter email", text: $email)
                .padding(10)
                .background(Color(.systemGray6))
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            TextField("Enter age", text: $age)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
            
            Button(action: {
                DB_Manager().addUser(nameValue: self.name, emailValue: self.email, ageValue: Int64(self.age) ?? 0)
                
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("Add User")
            })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                .padding(.bottom, 10)
        }.padding()
        Spacer()
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView()
    }
}
