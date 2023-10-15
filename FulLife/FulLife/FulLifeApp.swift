//
//  FulLifeApp.swift
//  FulLife
//
//  Created by Joie Mukamisha on 10/11/23.
//

import SwiftUI
import Firebase


@main
struct FulLifeApp: App {
    let persistenceController = PersistenceController.shared
    init() {
            FirebaseApp.configure()
     }

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
