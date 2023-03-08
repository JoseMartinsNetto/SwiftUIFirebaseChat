//
//  FirebaseManager.swift
//  SwiftUIFirebaseRealTimeChat
//
//  Created by Jose Martins on 06/03/23.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseStorage

class FirebaseManager: NSObject {
    
    static let shared = FirebaseManager()
    
    let auth: Auth
    let storage: Storage
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        
        super.init()
    }
}
