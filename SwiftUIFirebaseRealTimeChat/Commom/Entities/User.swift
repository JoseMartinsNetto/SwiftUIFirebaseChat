//
//  User.swift
//  SwiftUIFirebaseRealTimeChat
//
//  Created by Jose Martins on 09/03/23.
//

import Foundation

struct User {
    let uid: String
    let email: String
    let imageUrl: String
    
    func asDictionary() -> [String: Any] {
        return [
            "uid": self.uid,
            "email": self.email,
            "imageUrl": self.imageUrl
        ]
    }
}
