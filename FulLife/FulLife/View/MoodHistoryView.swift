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
                .onDelete(perform: deleteItems)
            }
            .navigationBarTitle("My Journal")
            .navigationBarItems(trailing: EditButton())
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Use this if you want to support older devices
        .navigationBarTitleDisplayMode(.inline) // Use this to display the title inline

        NavigationLink(destination: Inspiration()) {
            Text("Go to Inspiration")
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
