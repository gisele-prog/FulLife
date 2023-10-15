//
//  LoginView.swift
//  FulLife
//
//  Created by Joie Mukamisha on 10/15/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorText: String?
    @State private var navigateToHome: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                if let error = errorText {
                    Text(error)
                        .foregroundColor(.red)
                }

                Button(action: loginUser) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Button(action: registerUser) {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }

                NavigationLink("", destination: HomeView(), isActive: $navigateToHome).hidden()
            }
            .padding()
        }
    }

    func handleError(_ error: Error?) {
        if let errorCode = (error as NSError?)?.code {
            switch errorCode {
            case AuthErrorCode.invalidEmail.rawValue:
                errorText = "Invalid email format."
            case AuthErrorCode.wrongPassword.rawValue:
                errorText = "Incorrect password."
            case AuthErrorCode.emailAlreadyInUse.rawValue:
                errorText = "Email already in use."
            case AuthErrorCode.weakPassword.rawValue:
                errorText = "Password is too weak."
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
                navigateToHome = true
                errorText = nil
            }
        }
    }

    func registerUser() {
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            if let error = error {
                handleError(error)
            } else {
                navigateToHome = true
                errorText = nil
            }
        }
    }
}
