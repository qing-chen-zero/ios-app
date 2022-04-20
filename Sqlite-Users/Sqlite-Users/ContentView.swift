//
//  ContentView.swift
//  Sqlite-Users
//
//  Created by Qingchen on 2022/4/18.
//

import SwiftUI

struct ContentView: View {
    
    @State var userModels: [UserModel] = []
    @State var userSelected: Bool = false
    @State var selectedUserId: Int64 = 0
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink(destination: AddUserView(), label: {Text("Add user")})
                }
                
                NavigationLink (destination: EditUserView(id: self.$selectedUserId), isActive: self.$userSelected) {
                    EmptyView()
                }
                
                List(self.userModels) { (model) in
                    HStack {
                        Text(model.name)
                        Spacer()
                        Text(model.email)
                        Spacer()
                        Text("\(model.age)")
                        
                        Button(action: {
                            self.selectedUserId = model.id
                            self.userSelected = true
                        }, label: {
                            Text("Edit")
                                .foregroundColor(Color.blue)
                        }).buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            let dbManager: DB_Manager = DB_Manager()
                            
                            dbManager.deleteUser(idValue: model.id)
                            self.userModels = dbManager.getUsers()
                        }, label: {
                            Text("Delete")
                                .foregroundColor(Color.red)
                        }).buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding()
            .onAppear(perform: {
                self.userModels = DB_Manager().getUsers()
            })
            .navigationBarTitle("Users")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
