//
//  UsersListModel.swift
//  Karoooo Test
//
//  Created by Sevenbits on 28/08/22.
//

import UIKit

// MARK: - UserElement
class UsersListModel: Decodable {
    var id: Int?
    var name, username, email: String?
    var address: Address?
    var phone, website: String?
    var company: Company?

    init(id: Int?, name: String?, username: String?, email: String?, address: Address?, phone: String?, website: String?, company: Company?) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }
}

// MARK: - Address
class Address: Decodable {
    var street, suite, city, zipcode: String?
    var geo: Geo?

    init(street: String?, suite: String?, city: String?, zipcode: String?, geo: Geo?) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
    }
}

// MARK: - Geo
class Geo: Decodable {
    var lat, lng: String?

    init(lat: String?, lng: String?) {
        self.lat = lat
        self.lng = lng
    }
}

// MARK: - Company
class Company: Decodable {
    var name, catchPhrase, bs: String?

    init(name: String?, catchPhrase: String?, bs: String?) {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
}
