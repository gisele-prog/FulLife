//
//  MoodchartViewModel.swift
//  FulLife
//
//  Created by Consultant on 10/14/23.
//



import SwiftUI
import CoreData
import SwiftUICharts


class MoodPieChartViewModel: ObservableObject {
    @Published var moodData: [MoodCount] = []

    func fetchMoodData() {
        let context = PersistenceController.shared.container.viewContext

        do {
            let items = try context.fetch(Item.fetchRequest()) as [Item]
            var moodCounts: [MoodCount] = []

            for item in items {
                if let mood = item.mood {
                    if let index = moodCounts.firstIndex(where: { $0.mood == mood }) {
                        moodCounts[index].count += 1
                    } else {
                        moodCounts.append(MoodCount(mood: mood, count: 1))
                    }
                }
            }

            moodData = moodCounts
        } catch {
            
            print("Error fetching mood data: \(error)")
        }
    }
}
