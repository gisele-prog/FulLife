//
//  FulLifeApp.swift
//  FulLife
//
//  Created by Consultant on 10/11/23.
//

import SwiftUI

@main
struct FulLifeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
