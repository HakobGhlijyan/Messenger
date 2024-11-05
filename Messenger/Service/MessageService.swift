//
//  MessageService.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 05.11.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct MessageService {
    static let messageCollection = Firestore.firestore().collection("messages")
    
    static func sendMessage(_ messageText: String, toUser user: User) {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        let chatPartnerUID = user.id
        let currentUserRef = messageCollection
            .document(currentUID)
            .collection(chatPartnerUID)
            .document()
        
        let chatPartnerRef = messageCollection
            .document(chatPartnerUID)
            .collection(currentUID)

        let messageID = currentUserRef.documentID
        
        let message = Message(
            messageId: messageID,
            fromId: currentUID,
            toId: chatPartnerUID,
            messageText: messageText,
            timestamp:  Date()                    
        )

        guard let messageData = try? Firestore.Encoder().encode(message) else { return }

        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageID).setData(messageData)
    }
    
    // func kororoy budem poluchat vse message kotorie est u user ..
    // on budet v ivde s escaping
    static func observeMessages(chatPartner: User, completion: @escaping ( [Message]) -> Void ) {
        // 1. c User id
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        //2. sdes dobavim ego id , vmesto polusheniya tolko id
        let chatPartnerUID = chatPartner.id
        //3. Zapros v DB
        let query = messageCollection                       // zapros k DB
            .document(currentUID)                           // k doc user po id
            .collection(chatPartnerUID)                     // k ego collection po id sobisednica
            .order(by: "timestamp", descending: false)      // Sortirovka po vremeni , i v obratnom poryadke -> false
        // 4. poluchenie danix soobcheniya momnetalno , a esli bilo bi async await to eto bilo bi ne srazu a v ruchnuyu.
        // podpisivaemsya k sluchatelu ... kotoriy budet vsegda sledit za dobaleniem soobsheniy
//        query.addSnapshotListener(<#T##listener: (QuerySnapshot?, (any Error)?) -> Void##(QuerySnapshot?, (any Error)?) -> Void#>)
//        query.addSnapshotListener { <#QuerySnapshot?#>, <#(any Error)?#> in
//            <#code#>
//        }
        query.addSnapshotListener { snapshot, _ in
            // 5. prosluchivaem vse add -> dobavlenie message
            guard let changes = snapshot?.documentChanges.filter( { $0.type == .added } ) else { return }
            //6. Arrray messenge...  cherez compact map mi probuem try , potomu chri data as s throw error, i preobrazuem v tip message
            var messages = changes.compactMap( { try? $0.document.data(as: Message.self) } )
            //proydemsya po masivu soobshenoiy
            // v kororom est index ego i samo soobshenie , enumerated kotory sdelaet ego tipa Int i String ( 0 , "message ) , chtob mokno bilo nasnachit im
            // 7. Pomenyame na user vmesto id chtob poluchit vse danie
            for (index, message) in messages.enumerated() where !message.isfromeCurrentUser {
                // ili -> !message.isFromCurrentUser  , ili  message.fromId != currentUID
                messages[index].user = chatPartner
            }
        //8.
            completion(messages)
        }
    }
    
    /*
     1. poluchaem id current user a
     2. poluchaem id user kotormu chlem message
     3. delaem zapros
     4. pluchaem danie novie message s pomochyu sluchatelya nemedlenno
     5. ubejdaemsya chro poluchaem tolko novie add message
     6. componuem soobsheniya po titu i decodiruem
     7. proxodya po poluchenomu masivu numeruem i nasnachem po indexu user am
     8. vozrochaem array
     */
}

//MARK: - Ex
/*
 1. Mi berem nachu collection iz firebase , 2. tam berem id ko otpravil, 3. togo kto polushit
 4. berem puth po kotorimu user tot kot otpravit sozdast collection po id togo kto poludhit , i ego doci
 5. i naoborot , collection togo kto poluchit.
 6. sozdadim v collectcii togo kto poluchit message po id
 7. sozdadim soobshenie kotoroe otpravit user
 8. zakadiruem soobchenie kotoroe otpravim
 9. naznachim v document po puti current user a eto soobshenie.
 10. i v collecction togo user kotoriy poluchit message po id togo user kotoriy otpravil
 
 struct MessageService {
     //1. M Collection
     let messageCollection = Firestore.firestore().collection("messages")
     
     func sendMessage(_ messageText: String, toUser user: User) {
         //2. proverka na to chto u nas est user
         guard let currentUID = Auth.auth().currentUser?.uid else { return }
         //3. chat partner , tot user kotoromu mi otpravlyaem message
         let chatPartnerUID = user.id
         //4. user for send - curent user
         let currentUserRef = messageCollection         // global collection        //12. PATH OT CURRENT USER KOTRIY OTPRAVLYAETSYA ILI SOZDAYOTSYA
             .document(currentUID)                      // in document for user
             .collection(chatPartnerUID)                // and collection current user for message to user
             .document()                                // documennt forsendable user message
         //5. user for message in
         let chatPartnerRef = messageCollection         // global collection
             .document(chatPartnerUID)                   // in document for user
             .collection(currentUID)                    // and collection current user for message to user
         //6. message id
         let messageID = currentUserRef.documentID     //13. ID SOOBSHENIYA KOTOROE USER OTPRAVIL POLUSHILO ID, I EGO JE...
         //7. message
         let message = Message(
             messageId: messageID,       // id soobcheniya
             fromId: currentUID,         // id kto opravil    //14. SDES POLUCHIT ID
             toId: chatPartnerUID,       // id kto poluchit
             messageText: messageText,   // text soobcheniya
             timestamp: Timestamp()      // i vremya kogda eto bilo
         )
         //8. Endode - > codiruem message chtob otpravit na server firebase
         guard let messageData = try? Firestore.Encoder().encode(message) else { return }
         //9. - 10. teper naznachaem eto soobchenie k tomu kto otpravil , i k tomu kto poluchit
         currentUserRef.setData(messageData) // kto otpravil
         chatPartnerRef.document(messageID).setData(messageData) // 15. I SDES TOJE ID POLUCHIT POLUCHATEL... CHTOB ETI ID SOVPODALI.
         // a eto toli kto poluchit. po tomu documentu kotooruya svyazna s tem kto otpravil
     }
 }
 
 
 
 */

//MARK: - Ex 2
