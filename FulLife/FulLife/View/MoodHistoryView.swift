//
//  MoodTrackingView.swift
//  FulLife
//
//  Created by Joie Mukamisha on 10/11/23.
//



import SwiftUI
import CoreData

struct MoodHistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        animation: .default) private var moodHistory: FetchedResults<Item>

    @State private var selectedItem: Item?
    @State private var isEditViewPresented = false

    var body: some View {
        NavigationView {
            List {
                ForEach(moodHistory, id: \.self) { item in
                    VStack(alignment: .leading) {
                        Text("Mood: \(item.mood ?? "")")
                        Text("Date and Time: \(item.timestamp!, formatter: ItemFormatter.dateFormatter)")
                        if let notes = item.notes {
                            Text("Notes: \(notes)")
                        }

                        HStack {
                            Button(action: {
                                selectedItem = item
                                isEditViewPresented = true
                            }) {
                                Text("Edit")
                            }

                            Button(action: {
                                viewContext.delete(item)
                                try? viewContext.save()
                            }) {
                                Text("Delete")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Mood History")
        }
        .sheet(isPresented: $isEditViewPresented) {
            MoodEditView(item: $selectedItem, isEditViewPresented: $isEditViewPresented)
        }
    }
}

struct MoodEditView: View {
    @Binding var item: Item?
    @Binding var isEditViewPresented: Bool

    @State private var editedMood: String = ""
    @State private var editedNotes: String = ""

    var body: some View {
        VStack {
            TextField("Mood", text: $editedMood)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextEditor(text: $editedNotes)
                .frame(minHeight: 100)
                .padding()

            Button("Save") {
                if let item = item, !editedMood.isEmpty {
                    item.mood = editedMood
                    item.notes = editedNotes
                    try? item.managedObjectContext?.save()
                }
                isEditViewPresented = false
            }
            .padding()

            Button("Delete") {
                if let item = item {
                    item.managedObjectContext?.delete(item)
                    try? item.managedObjectContext?.save()
                }
                isEditViewPresented = false
            }
            .foregroundColor(.red)
            .padding()
        }
        .onAppear {
            if let item = item {
                editedMood = item.mood ?? ""
                editedNotes = item.notes ?? ""
            }
        }
    }
}
