//
//  MoodTrackingView.swift
//  FulLife
//
//  Created by Joie Mukamisha on 10/11/23.
//

import SwiftUI

struct MoodTrackingView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedMood: String = ""
    @State private var selectedDate = Date()
    @State private var additionalNotes = ""

    let moodOptions = ["Happy", "Sad", "Anger", "Fear", "Excited", "I don't know"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Mood Tracking")) {
                    Picker("Mood", selection: $selectedMood) {
                        ForEach(moodOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle()) // Use MenuPickerStyle to allow for more options

                    DatePicker("Date and Time", selection: $selectedDate, in: ...Date(), displayedComponents: [.date, .hourAndMinute])
                        .labelsHidden()

                    TextField("Additional Notes or Tags", text: $additionalNotes)
                }

                Button(action: {
                    // Create a new item in Core Data
                    let newItem = Item(context: viewContext)
                    newItem.mood = selectedMood
                    newItem.timestamp = selectedDate
                    newItem.notes = additionalNotes

                    // Save the changes
                    do {
                        try viewContext.save()
                    } catch {
                        // Handle the error appropriately
                        print("Error saving: \(error)")
                    }
                }) {
                    Text("Save Mood")
                }


                NavigationLink("View Mood History", destination: MoodHistoryView())
            }
            .navigationBarTitle("Mood Tracking")
        }
    }
}

struct MoodTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        MoodTrackingView()
    }
}
