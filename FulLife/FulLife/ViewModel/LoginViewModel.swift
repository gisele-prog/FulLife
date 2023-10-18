//
//  LoginViewModel.swift
//  FulLife
//
//  Created by Joie Mukamisha on 10/16/23.
//

import SwiftUI
import Firebase

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorText: String?
    @Published var isLoggedIn: Bool = false
    

    func handleError(_ error: Error?) {
        if let errorCode = (error as NSError?)?.code {
            switch errorCode {
            case AuthErrorCode.invalidEmail.rawValue:
                errorText = "Email format is invalid."
            case AuthErrorCode.wrongPassword.rawValue:
                errorText = "Password is incorrect."
            case AuthErrorCode.emailAlreadyInUse.rawValue:
                errorText = "Email already in use."
            case AuthErrorCode.weakPassword.rawValue:
                errorText = "Weak password."
            default:
                errorText = "An error occurred. Please try again."
            }
        }
    }

    func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { [self] authResult, error in
            if let error = error {
                handleError(error)
            } else {
                isLoggedIn = true
                errorText = nil
            }
        }
    }

    func registerUser() {
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            if let error = error {
                handleError(error)
            } else {
                isLoggedIn = true
                errorText = nil
            }
        }
    }
}

