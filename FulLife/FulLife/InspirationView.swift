//
//  InspirationView.swift
//  FulLife
//
//  Created by Consultant on 10/13/23.
//

import SwiftUI

struct Inspiration: View {
    @State private var quotes: [Quote] = []

    var body: some View {
        NavigationView {
            List(quotes, id: \.q) { quote in
                VStack(alignment: .leading) {
                    Text("Quote: \(quote.q)")
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
        }
    }
}

struct Inspiration_Previews: PreviewProvider {
    static var previews: some View {
        Inspiration()
    }
}
