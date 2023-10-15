//
//  QuoteServiceLayer.swift
//  FulLife
//
//  Created by Joie Mukamisha on 10/13/23.
//

import Foundation


class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchRandomQuote(completion: @escaping ([Quote]?) -> Void) {
        let url = URL(string: "https://zenquotes.io/api/random")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received from the server.")
                completion(nil)
                return
            }
            
            do {
                let quotes = try JSONDecoder().decode([Quote].self, from: data)
                completion(quotes)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
