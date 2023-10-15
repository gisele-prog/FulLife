//
//  InspirationView.swift
//  FulLife
//
//  Created by Joie Mukamisha on 10/13/23.
//


import SwiftUI



struct Inspiration: View {
    @StateObject private var viewModel = InspirationViewModel()
    @State private var isMoodPieChartViewPresented = false

    var body: some View {
        NavigationView {
            List(viewModel.quotes, id: \.q) { quote in
                VStack(alignment: .leading, spacing: 8) {
                    Text("Quote:")
                        .font(.headline)
                        .foregroundColor(.blue)

                    Text(quote.q)
                        .font(.body)
                    
                    Text("Author:")
                        .font(.headline)
                        .foregroundColor(.blue)

                    Text(quote.a)
                        .font(.body)
                }
                .padding(8)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(10)
            }
            .onAppear {
                viewModel.fetchQuotes()
            }
            .navigationBarTitle("Inspirational Quotes")
            .navigationBarItems(trailing:
                Button(action: {
                    isMoodPieChartViewPresented = true
                }) {
                    Text("View Mood Chart")
                }
            )
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $isMoodPieChartViewPresented) {
            MoodPieChartView()
        }
    }
}

