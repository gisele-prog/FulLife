//
//  InspirationViewModel.swift
//  FulLife
//
//  Created by Joie Mukamisha on 10/15/23.
//



import SwiftUI

class InspirationViewModel: ObservableObject {
    @Published var quotes: [Quote] = []
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchQuotes() {
        networkService.fetchRandomQuote { fetchedQuotes in
            if let fetchedQuotes = fetchedQuotes {
                DispatchQueue.main.async {
                    self.quotes = fetchedQuotes
                }
            }
        }
    }
}

