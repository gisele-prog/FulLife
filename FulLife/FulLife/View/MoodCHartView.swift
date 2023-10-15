//
//  MoodCHartView.swift
//  FulLife
//
//  Created by Joie Mukamisha on 10/14/23.
//


import SwiftUI
import CoreData
import SwiftUICharts

struct MoodPieChartView: View {
    @ObservedObject var chartViewModel = MoodPieChartViewModel()
    
    var body: some View {
        VStack {
            Text("Mood Distribution")
                .font(.title)
                .padding(.top, 16)
            
            PieChartView(data: chartViewModel.moodData.map { $0.count }, title: "Mood Distribution", legend: "Mood")
                .aspectRatio(1, contentMode: .fit)
                .padding()
                .accessibility(label: Text("Mood Distribution Chart"))

            ForEach(chartViewModel.moodData) { moodCount in
                HStack {
                    Text(moodCount.mood)
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("\(Int(moodCount.count))")
                        .font(.headline)
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            chartViewModel.fetchMoodData()
        }
        .navigationBarTitle("Mood Chart")
        .navigationBarTitleDisplayMode(.inline)
    }
}
