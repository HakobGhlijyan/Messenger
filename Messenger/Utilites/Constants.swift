//
//  Constants.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 06.11.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct FirestoreConstants {
    static let userCollection = Firestore.firestore().collection("users")
    static let messagesCollection = Firestore.firestore().collection("messages")
}
