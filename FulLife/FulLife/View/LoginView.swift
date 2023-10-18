//
//  LoginViewModel.swift
//  FulLife
//
//  Created by Joie Mukamisha on 10/16/23.
//


import SwiftUI
import Firebase

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("FulLife")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
                    .padding(.top, 50)

                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.horizontal)

                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                if let error = viewModel.errorText {
                    Text(error)
                        .foregroundColor(.red)
                        .padding(.top, 5)
                }

                Button(action: viewModel.loginUser) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.top, 10)
                }
                .buttonStyle(PlainButtonStyle())

                Button(action: viewModel.registerUser) {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())

                NavigationLink(destination: HomeView(), isActive: $viewModel.isLoggedIn) {
                    EmptyView()
                }
                .isDetailLink(false)
            }
            .padding()
        }
        .navigationViewStyle(StackNavigationViewStyle())
       
    }
}
