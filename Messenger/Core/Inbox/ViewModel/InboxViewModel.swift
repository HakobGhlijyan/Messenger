//
//  InboxViewModel.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 02.11.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Combine

@MainActor
final class InboxViewModel: ObservableObject {
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    @Published var recentMessages: [Message] = []
    private let service = InboxService()
    
    init() {
        setupSubscribers()
        service.observeRecentMessages()
    }
    
    private func setupSubscribers() {
        //User
        UserService
            .shared
            .$currentUser
            .sink { [weak self] user in
                self?.currentUser = user
            }
            .store(in: &cancellables)
        
        //Recent Message
        service
            .$docChanges
            .sink { [weak self] changes in
                self?.loadInitialMessages(fromeChange: changes)
            }
            .store(in: &cancellables)
    }
    
    //1.func kotoraya vizvetsya iz sluchtelya a fetchuser is service kotoraya escaping budet rabotat kogda poluchit user data, i proydet po ciklu masiva s indexami i vernet soobchenie s temuser kotorim obchalsya v recent otseke i ego posleduyu message
    //2. a v setup s pomoshyu combin subscriber budet vizivat uje etu func s poluchanimi danimi i soronyat ego v masive recent message , gde i budut oni , ix smojem is private var recentMessages: [Message] = [] -> smojem vzayt eti danie i pokozat na view
    //  EGO VIZIVAET setupSubscribers -> V SINK POLUCHENIE CHANGEES DANIE PETADYOM V ETU FUNC .. 1. POLUCHANIE NE OBROBOTANIE DANIE PREOBROZUEM V MASIM=V MESSAGES _> 2. V CICLE MI PROXODIM PO VSEM MESSAGE I POLUCHAEM USER OV PO IX SOOBCHENIYAM , KAJDIY RAZ VIZIVAYA IZ USER SERVICE FETCH FUNC POLUCHEM SOOBCHENIE, 3. ETA FUNC POLUCHAET USER OV.. A STROKA 4. NAZNACHET I SVYAZIVAET SOOBCHENIE I USER , BEZ NEGO USER NE BUDET VIDEN , TOLKO MESSAGE . TAKOM OBROZOM 4 STROKA POLUCHAET FROMID ID TOID I SVYAZIVAE IX , 5. V FUNC WITH ID UJE ISPOLZUYA ETO CHAT PARTENER ID BEREM TOLKO SOBESEDNIKA I VSAVLYAEM EGO NAME I POTOM EGO PHOTO
    private func loadInitialMessages(fromeChange changes: [DocumentChange]) {
        //1 // func kotoraya poluchit soobchenie
        var messages = changes.compactMap({ try? $0.document.data(as: Message.self)})
        
        //2
        for i in 0 ..< messages.count {
            let message = messages[i]
            // 3.
            UserService.fetchUser(withUid: message.chatPartnerId) { user in
               //4.
                messages[i].user = user
                self.recentMessages.append(messages[i])
            }
        }
    }
}
