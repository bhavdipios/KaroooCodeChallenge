//
//  UserModel.swift
//  Karoooo Test
//
//  Created by Sevenbits on 27/08/22.
//

import Foundation

class UserLoginModel
{
    var email: String = ""
    var password: String = ""
    var phone: String = ""
    
    init(email:String, password:String, phone:String)
    {
        self.email = email
        self.password = password
        self.phone = phone
    }
    
}
