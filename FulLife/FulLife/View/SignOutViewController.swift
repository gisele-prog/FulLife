//
//  SignOutViewController.swift
//  FulLife
//
//  Created by Consultant on 10/15/23.
//

import UIKit
import Firebase
import SwiftUI

class UIKitSettingsViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .white
        setupSignOutButton()
       
    }
  

    private func setupSignOutButton() {
        let signOutButton = UIButton(type: .system)
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.setTitleColor(.black, for: .normal)
        signOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)

        view.addSubview(signOutButton)

        signOutButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc private func signOutButtonTapped() {
        do {
            try Auth.auth().signOut()
          

          
            let loginView = LoginView()

           
            let hostingController = UIHostingController(rootView: loginView)

          
            navigationController?.pushViewController(hostingController, animated: true)
           
        } catch {
           
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

