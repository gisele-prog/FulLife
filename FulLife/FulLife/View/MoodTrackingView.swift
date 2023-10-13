//
//  MoodTrackingView.swift
//  FulLife
//
//  Created by Joie Mukamisha on 10/11/23.
//

import SwiftUI
import CoreData


struct MoodTrackingView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel = MoodTrackingViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Mood Tracking")) {
                    Picker("Mood", selection: $viewModel.selectedMood) {
                        ForEach(viewModel.moodOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())

                    DatePicker("Date and Time", selection: $viewModel.selectedDate, in: ...Date(), displayedComponents: [.date, .hourAndMinute])
                        .labelsHidden()

                    TextField("Additional Notes or Tags", text: $viewModel.additionalNotes)
                }

                Button(action: {
                    viewModel.saveMoodItem(viewContext: viewContext)
                }) {
                    Text("Save Mood")
                }

                NavigationLink("View Mood History", destination: MoodHistoryView())
            }
            .navigationBarTitle("Mood Tracking")
        }
    }
}
