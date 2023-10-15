//
//  HomeView.swift
//  FulLife
//
//  Created by Consultant on 10/15/23.
//




import SwiftUI
import Firebase

struct HomeView: View {
    @State private var selectedTab = 0
    @State private var isSettingsPresented = false

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                MoodTrackingView()
            }
            .tabItem {
                Label("Track Mood", systemImage: "square.and.pencil")
            }
            .tag(0)

            NavigationView {
                MoodHistoryView()
            }
            .tabItem {
                Label("Mood History", systemImage: "book")
            }
            .tag(1)

            NavigationView {
                Inspiration()
            }
            .tabItem {
                Label("Inspiration", systemImage: "heart.text.square")
            }
            .tag(2)

            NavigationView {
                MoodPieChartView()
            }
            .tabItem {
                Label("Mood Chart", systemImage: "chart.pie.fill")
            }
            .tag(3)

            NavigationView {
                UIKitSettingsView(isSettingsPresented: $isSettingsPresented) // Add the UIKitSettingsView to your tab
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
            .tag(4)
        }
        
    }
    
}
