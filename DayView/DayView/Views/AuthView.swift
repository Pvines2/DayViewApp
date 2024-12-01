//
//  AuthView.swift
//  DayView
//
//  Created by Parker Vines on 11/17/24.
//

import Foundation
import SwiftUI

struct AuthView: View {
    @ObservedObject var authViewModel = AuthViewModel()

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoginMode = true

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Picker(selection: $isLoginMode, label: Text("Mode")) {
                    Text("Log In").tag(true)
                    Text("Sign Up").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                if let errorMessage = authViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button(action: {
                    if isLoginMode {
                        authViewModel.logIn(email: email, password: password)
                    } else {
                        authViewModel.signUp(email: email, password: password)
                    }
                }) {
                    Text(isLoginMode ? "Log In" : "Sign Up")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top)

                if authViewModel.user != nil {
                    Text("Logged in as \(authViewModel.user?.email ?? "Unknown")")
                        .foregroundColor(.green)
                }

                Spacer()
            }
            .padding()
            .navigationTitle(isLoginMode ? "Log In" : "Sign Up")
        }
    }
}

