//
//  DBHelper.swift
//  Karoooo Test
//
//  Created by Sevenbits on 27/08/22.
//

import Foundation
import SQLite3

class DBHelper
{
    init()
    {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "Karooo.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS person(email TEXT,password TEXT, phone TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(email:String, password:String, phone:String)
    {
        let persons = read(email: email, password: password, phone:phone)
        for p in persons
        {
            if p.email == email
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO person (email, password, phone) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (password as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (phone as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func isValidUser(email: String, password: String, phone: String) -> Bool {
        let queryStatementString = "SELECT * from person where email='\(email)' and password='\(password)' and phone='\(phone)'"
        var queryStatement: OpaquePointer? = nil
        var psns : [UserLoginModel] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let phone = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                psns.append(UserLoginModel(email: email, password: password, phone: phone))
                print("Query Result:")
                print("\(email) | \(password) | \(phone)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        if psns.count > 0 {
            return true
        }
        return false
    }
    
    func read(email: String, password: String, phone: String) -> [UserLoginModel] {
        let queryStatementString = "SELECT * from person where email='\(email)' and password='\(password)' and phone='\(phone)'"
        var queryStatement: OpaquePointer? = nil
        var psns : [UserLoginModel] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let phone = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                psns.append(UserLoginModel(email: email, password: password, phone: phone))
                print("Query Result:")
                print("\(email) | \(password) | \(phone)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    
}
