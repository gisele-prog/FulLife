//
//  MoodHistoryView.swift
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
                        Text("Date and Time: \(item.timestamp!, formatter: itemFormatter)")
                    }
                }
            }
            .navigationBarTitle("Mood History")
        }
    }
    
    Button(action: {
        // Navigate to the MoodHistoryView
        NavigationLink("Mood History", destination: MoodHistoryView())
    }) {
        Text("View Mood History")
    }

}




#Preview {
    MoodHistoryView()
}
