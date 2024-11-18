//
//  AuthViewModel.swift
//  DayView
//
//  Created by Parker Vines on 11/17/24.
//

import Foundation
import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var errorMessage: String? = nil

    // Sign Up
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else {
                self?.user = result?.user
                self?.errorMessage = nil
            }
        }
    }

    // Log In
    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else {
                self?.user = result?.user
                self?.errorMessage = nil
            }
        }
    }

    // Log Out
    func logOut() {
        do {
            try Auth.auth().signOut()
            user = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
