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
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Date and Time: \(item.timestamp!, formatter: ItemFormatter.dateFormatter)")
                            .font(.subheadline)
                        Text("Mood: \(item.mood ?? "Unknown")")
                            .font(.headline)
                        
                        if let notes = item.notes {
                            Text("Notes: \(notes)")
                                .font(.body)
                        }
                    }
                    .padding(8)
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(10)
                }
                .onDelete(perform: deleteItems)
                .listRowSeparator(.hidden) // Remove list separators
            }
            .navigationBarTitle("My Journal")
            .navigationBarItems(trailing: EditButton())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitleDisplayMode(.inline)

        NavigationLink(destination: Inspiration()) {
            Text("Explore Inspirations")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
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
