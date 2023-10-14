//
//  InspirationView.swift
//  FulLife
//
//  Created by Consultant on 10/13/23.
//

import SwiftUI

struct Inspiration: View {
    @State private var quotes: [Quote] = []
    @State private var isChartViewPresented = false // State to control chart view presentation

    var body: some View {
        NavigationView {
            List(quotes, id: \.q) { quote in
                VStack(alignment: .leading) {
                    Text("\(quote.q)")
                    Text("Author: \(quote.a)")
                }
            }
            .onAppear {
                NetworkManager.shared.fetchRandomQuote { fetchedQuotes in
                    if let fetchedQuotes = fetchedQuotes {
                        quotes = fetchedQuotes
                    }
                }
            }
            .navigationBarTitle("Inspirational Quotes")
            .navigationBarItems(trailing:
                Button("View Mood Chart") {
                    // This action opens the MoodPieChartView
                    isChartViewPresented.toggle()
                }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitleDisplayMode(.inline)
        .background(
            NavigationLink(destination: MoodPieChartView(), isActive: $isChartViewPresented) {
                EmptyView()
            }
            .hidden()
        )
    }
}

struct Inspiration_Previews: PreviewProvider {
    static var previews: some View {
        Inspiration()
    }
}
