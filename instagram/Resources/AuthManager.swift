//
//  AuthManager.swift
//  instagram
//
//  Created by Erbol on 24.02.2022.
//

import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    //Mark: - Public
    
    public func registerNewUser(userName: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        /*
         -- check is username is available
         -- check is email is available
         */
        
        DatabaseManager.shared.canCreateNewUser(with: email, username: userName){ canCreate in
            if canCreate {
                /*
                    -- create account
                    -- insert account in database
                */
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {
                        //Firebase Auth could not create an account
                        completion(false)
                         return 
                    }
                    // Insert to database
                    DatabaseManager.shared.insertNewUser(with: email, username: userName){ inserted in
                        if inserted {
                            completion(true)
                            return
                        } else {
                            //failed to insert to database
                            completion(false)
                            return
                        }
                    }
                }
            }
            else {
                // either username or email does not exist
                completion(false)
            }
            
        }
        
    }
    
    public func loginUser(userName: String?, email: String?, password:String, completion: @escaping (Bool) -> Void){
        if let email = email {
            //email login
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                     completion(false)
                    return
                }
                completion(true) 
            }
        }
        else if let userName = userName {
            // username login
            print(userName)
        }
    }
    ///Attemp log out firebase user
    public func logout(completion:(Bool)-> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch {
            completion(false)
            print(error)
            return
        }
    }
    
}
