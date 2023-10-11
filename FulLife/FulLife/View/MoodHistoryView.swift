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
        animation: .default)
    private var moodHistory: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(moodHistory) { item in
                    VStack(alignment: .leading) {
                        Text("Mood: \(item.mood ?? "")")
                        Text("Date and Time: \(item.timestamp!, formatter: ItemFormatter.dateFormatter)")
                        if let notes = item.notes {
                            Text("Notes: \(notes)")
                        }
                    }
                }

            }
            .navigationBarTitle("Mood History")
        }
    }
}

struct MoodHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        MoodHistoryView()
    }
}

