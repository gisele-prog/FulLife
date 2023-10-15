//
//  InspirationViewModel.swift
//  FulLife
//
//  Created by Consultant on 10/15/23.
//

import SwiftUI

class InspirationViewModel: ObservableObject {
    @Published var quotes: [Quote] = []

    func fetchQuotes() {
        NetworkManager.shared.fetchRandomQuote { fetchedQuotes in
            if let fetchedQuotes = fetchedQuotes {
                DispatchQueue.main.async {
                    self.quotes = fetchedQuotes
                }
            }
        }
    }
}
