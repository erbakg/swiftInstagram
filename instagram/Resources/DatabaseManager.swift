//
//  DatabaseManager.swift
//  instagram
//
//  Created by Erbol on 24.02.2022.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    ///check if username and email is available
    /// --Parameters:
    ///     --email: String representing email
    ///     --username: String representing username
    public func canCreateNewUser(with email: String, username:String, completion: (Bool)->Void){
        completion(true)
    }
    
    /// Inset new  users to database
    /// --Parameters:
    ///     --email: String representing email
    ///     --username: Async callback for result if database entry succeded
    
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool)->Void){
        let key = email.safeDatabaseKey()
        database.child(key) .setValue(["username":username]) { error, _ in
            if error == nil {
                 //succeeded
                completion(true)
                return
            }
            else {
                //failed
                completion(false)
                return
            }
        }
    }
    
    //Mark: - Private 

}
