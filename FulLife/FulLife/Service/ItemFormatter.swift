//
//  ItemFormatter.swift
//  FulLife
//
//  Created by Joie Mukamisha on 10/11/23.
//

import Foundation

struct ItemFormatter {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}
