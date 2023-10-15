//
//  Representable.swift
//  FulLife
//
//  Created by Joie Mukamisha on 10/15/23.
//

import Foundation
import SwiftUI

struct UIKitSettingsView: UIViewControllerRepresentable {
    @Binding var isSettingsPresented: Bool

    init(isSettingsPresented: Binding<Bool>) {
        self._isSettingsPresented = isSettingsPresented
    }

    func makeUIViewController(context: Context) -> UIKitSettingsViewController {
        return UIKitSettingsViewController()
    }

    func updateUIViewController(_ uiViewController: UIKitSettingsViewController, context: Context) {
       
    }
}

