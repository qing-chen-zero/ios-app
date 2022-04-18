//
//  EditUserView.swift
//  Sqlite-Users
//
//  Created by Qingchen on 2022/4/18.
//

import SwiftUI

struct EditUserView: View {
    
    @Binding var id: Int64
    
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
                .cornerRadius(5)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            TextField("Enter age", text: $age)
                .padding(10)
                .cornerRadius(5)
                .background(Color(.systemGray6))
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
            
            Button(action:{
                DB_Manager().updateUser(idValue: self.id, nameValue: self.name, emailValue: self.email, ageValue: Int64(self.age) ?? 0)
                
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("Edit User")
            }).frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                .padding(.bottom, 10)
        }.padding()
            .onAppear(perform: {
                let userModel: UserModel = DB_Manager().getUser(idValue: self.id)
                
                self.name = userModel.name
                self.email = userModel.email
                self.age = String(userModel.age)
            })
    }
}

struct EditUserView_Previews: PreviewProvider {
    @State static var id: Int64 = 0
    static var previews: some View {
        EditUserView(id: $id)
    }
}
