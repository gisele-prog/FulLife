//
//  MoodHistoryViewModel.swift
//  FulLife
//
//  Created by Consultant on 10/12/23.
//

import SwiftUI
import CoreData

class MoodHistoryViewModel: ObservableObject {
    @Published var moodHistory: FetchedResults<Item>
    private var managedObjectContext: NSManagedObjectContext

    init(moodHistory: FetchedResults<Item>, managedObjectContext: NSManagedObjectContext) {
        self.moodHistory = moodHistory
        self.managedObjectContext = managedObjectContext
    }

    func deleteMoodEntry(at offsets: IndexSet) {
        for index in offsets {
            let item = moodHistory[index]
            managedObjectContext.delete(item)
        }
        do {
            try managedObjectContext.save()
        } catch {
            
            print("Error deleting item: \(error)")
        }
    }
}


