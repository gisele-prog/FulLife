//
//  MoodTrackingDataModel.swift
//  FulLife
//
//  Created by Joie mukamisha on 10/17/23.
//

import Foundation
import CoreData

protocol MoodTrackingDataSource {
    var moodOptions: [String] { get }
    func saveMoodItem(selectedMood: String, selectedDate: Date, additionalNotes: String, viewContext: NSManagedObjectContext) -> Result<Void, Error>
}

class MoodTrackingDataManager: MoodTrackingDataSource {
    let moodOptions = ["Happy", "Sad", "Angry", "Scared", "Excited", "Loved", "Stressed","Fatigue","Hopeless","Anxious","I don't know"]

    func saveMoodItem(selectedMood: String, selectedDate: Date, additionalNotes: String, viewContext: NSManagedObjectContext) -> Result<Void, Error> {
        do {
            let newItem = Item(context: viewContext)
            newItem.mood = selectedMood
            newItem.timestamp = selectedDate
            newItem.notes = additionalNotes
            try viewContext.save()
            return .success(())
        } catch {
            return .failure(error)
        }
    }
}
