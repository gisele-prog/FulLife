//
//  MoodTrackingView.swift
//  FulLife
//
//  Created by Joie Mukamisha on 10/11/23.
//


import SwiftUI
import CoreData


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    @State private var isShowingMoodTracking = false

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
                    Button(action: {
                        isShowingMoodTracking = true
                    }) {
                        Label("Add Mood", systemImage: "plus")
                    }
                }
                ToolbarItem {
                    NavigationLink("Mood History", destination: MoodHistoryView())
                }
            }
            Text("Select a mood")
        }
        .sheet(isPresented: $isShowingMoodTracking) {
            MoodTrackingView().environment(\.managedObjectContext, viewContext)
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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
