//
//  HomeView.swift
//  FulLife
//
//  Created by Consultant on 10/15/23.
//

import SwiftUI


struct HomeView: View {
    var body: some View {
        TabView {
            NavigationView {
                MoodTrackingView()
            }
            .tabItem {
                Label("Track Mood", systemImage: "square.and.pencil")
            }

            NavigationView {
                MoodHistoryView()
            }
            .tabItem {
                Label("Mood History", systemImage: "book")
            }

            NavigationView {
                Inspiration()
            }
            .tabItem {
                Label("Inspiration", systemImage: "heart.text.square")
            }

            NavigationView {
                MoodPieChartView()
            }
            .tabItem {
                Label("Mood Chart", systemImage: "chart.pie.fill")
            }
        }
    }
}
