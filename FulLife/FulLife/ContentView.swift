
//  ContentView.swift
//  FulLife
//
//  Created by Consultant on 10/11/23.


import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Mood: \(item.mood ?? "")")
                        Text("Timestamp: \(item.timestamp!, formatter: itemFormatter)")
                        Text("Notes: \(item.notes ?? "")")
                    } label: {
                        Text("Mood: \(item.mood ?? "")")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    NavigationLink(destination: MoodTrackingView().environment(\.managedObjectContext, viewContext)) {
                        Label("Add Mood", systemImage: "plus")
                    }
                }
            }
            Text("Select a mood")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private var itemFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}
