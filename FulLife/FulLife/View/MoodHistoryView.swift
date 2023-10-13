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

           }
                }
                .onDelete(perform: deleteItems) //  to enable deletion
            }
            .navigationBarTitle("My Journal")
            .navigationBarItems(trailing: EditButton()) // Enable Edit mode
        }
    }

    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let item = moodHistory[index]
            viewContext.delete(item)
        }
        try? viewContext.save()
    }
}
