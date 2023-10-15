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
                        Text("My mood:")
                            .font(.headline)
                            .foregroundColor(.blue)

                        Text(item.mood ?? "Unknown")
                            .font(.title)
                        
                        if let notes = item.notes {
                            Text("My mood description:")
                                .font(.headline)
                                .foregroundColor(.blue)
                            Text(notes)
                                .font(.body)
                        }
                        
                        Text("Date and Time:")
                            .font(.headline)
                            .foregroundColor(.blue)

                        Text("\(item.timestamp!, formatter: ItemFormatter.dateFormatter)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(8)
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 1)
                    )
                }
                .onDelete(perform: deleteItems)
            }
            .listRowSeparator(.hidden)
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
