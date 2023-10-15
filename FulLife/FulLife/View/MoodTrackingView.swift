//
//  MoodTrackingView.swift
//  FulLife
//
//  Created by Joie Mukamisha on 10/11/23.
//

import SwiftUI

struct MoodTrackingView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel = MoodTrackingViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("How are you feeling?")) {
                    Picker("Select your mood", selection: $viewModel.selectedMood) {
                        ForEach(viewModel.moodOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .accessibility(label: Text("Mood Selector"))
                }
                
                Section(header: Text("When did you feel this way?")) {
                    DatePicker("Date and Time", selection: $viewModel.selectedDate, in: ...Date(), displayedComponents: [.date, .hourAndMinute])
                        .labelsHidden()
                        .accessibility(label: Text("Date and Time Selector"))
                }

                Section(header: Text("Additional Notes or Tags")) {
                    TextField("Describe your mood or add tags", text: $viewModel.additionalNotes)
                        .accessibility(label: Text("Notes and Tags"))
                }

                Button(action: {
                    viewModel.saveMoodItem(viewContext: viewContext)
                }) {
                    Text("Save")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .accessibility(label: Text("Save Mood Entry"))
                }

                NavigationLink("View History", destination: MoodHistoryView())
                    .accessibility(label: Text("View Mood History"))
            }
            .navigationBarTitle("Mood Tracking")
        }
    }
}
