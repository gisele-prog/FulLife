//
//  MoodCHartView.swift
//  FulLife
//
//  Created by Joie Mukamisha on 10/14/23.
//




import SwiftUI
import CoreData
import SwiftUICharts

struct MoodCount: Identifiable {
    var id = UUID()
    var mood: String
    var count: Double
}

struct MoodPieChartView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Item.entity(), sortDescriptors: []) var itemHistory: FetchedResults<Item>

    var body: some View {
        let moodData = countMoods()
        
        return VStack {
            PieChartView(data: moodData.map { $0.count }, title: "Mood Distribution", legend: "Moods")
                .aspectRatio(1, contentMode: .fit)
                .padding()

            // Display labels for each mood
            ForEach(moodData) { moodCount in
                HStack {
                    Text(moodCount.mood)
                    Spacer()
                    Text("\(Int(moodCount.count))")
                }
                .padding(.horizontal)
            }
        }
    }

    func countMoods() -> [MoodCount] {
        var moodData: [MoodCount] = []

        for item in itemHistory {
            if let mood = item.mood {
                if let index = moodData.firstIndex(where: { $0.mood == mood }) {
                    moodData[index].count += 1
                } else {
                    moodData.append(MoodCount(mood: mood, count: 1))
                }
            }
        }

        return moodData
    }
}
