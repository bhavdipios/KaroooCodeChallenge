//
//  Validator.swift
//  Karoooo Test
//
//  Created by Sevenbits on 27/08/22.
//

import Foundation


// MARK: - Email Validation Method
func isValidEmailAddress(value: String) -> Bool {
    
    let email = value.trimmingCharacters(in: .whitespacesAndNewlines)
    var returnValue = true
    
    let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    
    do {
        
        let regex = try NSRegularExpression(pattern: emailRegEx)
        let nsString = email as NSString
        let results = regex.matches(in: email, range: NSRange(location: 0, length: nsString.length))
        
        if results.count == 0
        {
            returnValue = false
        }
        
    } catch let error as NSError {
        print("invalid regex: \(error.localizedDescription)")
        returnValue = false
    }
    
    return  returnValue
}

// MARK: - Phone Validation Method
func isValidPhone(value: String) -> Bool {
    let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
    return phoneTest.evaluate(with: value)
}

// MARK: - Phone Validation Method
func isEmpty(value: String) -> Bool {
    
    let lenght = value.trimmingCharacters(in: .whitespacesAndNewlines)
    if lenght.count > 0 {
        return false
    }else {
        return true
    }
    
}
