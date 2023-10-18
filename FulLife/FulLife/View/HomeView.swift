//
//  HomeView.swift
//  FulLife
//
//  Created by Joie Mukamisha on 10/15/23.
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

        }
        
    }
    
}
