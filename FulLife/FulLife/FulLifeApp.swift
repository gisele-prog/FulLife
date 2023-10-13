//
//  FulLifeApp.swift
//  FulLife
//
//  Created by Consultant on 10/11/23.
//

import SwiftUI

//@main
//struct FulLifeApp: App {
//    let persistenceController = PersistenceController.shared
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        }
//    }
//}

//@main
//struct FulLifeApp: App {
//    var body: some Scene {
//        WindowGroup {
//            MoodTrackingView()
//        }
//    }
//}
//@main
//struct FulLifeApp: App {
//    let persistenceController = PersistenceController.shared
//
//    var body: some Scene {
//        WindowGroup {
//            NavigationView {
//                MoodTrackingView()
//                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            }
//        }
//    }
//}
@main
struct FulLifeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MoodTrackingView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
