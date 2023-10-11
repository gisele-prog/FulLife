//
//  MoodTrackingView.swift
//  FulLife
//
//  Created by Joie Mukamisha on 10/11/23.
//

import SwiftUI

struct MoodTrackingView: View {
    @State private var selectedMood: String = ""
    @State private var selectedDate = Date()
    @State private var additionalNotes = ""

    let moodOptions = ["Happy", "Sad", "Anger", "Scared", "Excited", "Tender"]

    var body: some View {
        Form {
            Section(header: Text("Mood Tracking")) {
                Picker("How are you feeling?", selection: $selectedMood) {
                    ForEach(moodOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(MenuPickerStyle())

                DatePicker("Date and Time", selection: $selectedDate, in: ...Date(), displayedComponents: [.date, .hourAndMinute])
                    .labelsHidden()

                TextField("Additional Notes or Tags", text: $additionalNotes)
            }

            Button(action: {
                // Handle saving the mood data here
                print("Mood: \(selectedMood)")
                print("Date: \(selectedDate)")
                print("Additional Notes: \(additionalNotes)")
            }) {
                Text("Save Mood")
            }
        }
    }
}

struct MoodTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        MoodTrackingView()
    }
}



