//
//  UserModel.swift
//  Sqlite-Users
//
//  Created by Qingchen on 2022/4/18.
//

import Foundation

class UserModel: Identifiable {
    public var id: Int64 = 0
    public var name: String = ""
    public var email: String = ""
    public var age: Int64 = 0
}
