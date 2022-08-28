//
//  UsersViewModel.swift
//  Karoooo Test
//
//  Created by Sevenbits on 28/08/22.
//

import UIKit

class UsersViewModel: NSObject {
    var id: Int?
    var userName: String?
    var name: String?
    var email: String?
    var address: Address?
    var phone: String?
    var website: String?
    var company: Company?
    
    
    init(user:UsersListModel){
        self.id = user.id
        self.userName = user.username
        self.name = user.name
        self.email = user.email
        self.address = user.address
        self.phone = user.phone
        self.website = user.website
        self.company = user.company
    }
    
}
