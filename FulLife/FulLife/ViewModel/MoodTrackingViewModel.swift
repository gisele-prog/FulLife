//
//  MoodTrackingViewModel.swift
//  FulLife
//
//  Created by Joie Mukamisha on 10/12/23.
//

import SwiftUI
import CoreData


class MoodTrackingViewModel: ObservableObject {
    @Published var selectedMood: String = ""
    @Published var selectedDate = Date()
    @Published var additionalNotes = ""

    let moodOptions = ["Happy", "Sad", "Angry", "Fear", "Excited", "Loved", "I don't know"]

    func saveMoodItem(viewContext: NSManagedObjectContext) {
        let newItem = Item(context: viewContext)
        newItem.mood = selectedMood
        newItem.timestamp = selectedDate
        newItem.notes = additionalNotes

        do {
            try viewContext.save()
        } catch {
            print("Error saving: \(error)")
        }
    }
}
