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

    let dataSource: MoodTrackingDataSource

    init(dataSource: MoodTrackingDataSource) {
        self.dataSource = dataSource
    }

    func saveMoodItem(viewContext: NSManagedObjectContext) -> Result<Void, Error> {
        return dataSource.saveMoodItem(selectedMood: selectedMood, selectedDate: selectedDate, additionalNotes: additionalNotes, viewContext: viewContext)
    }
}
