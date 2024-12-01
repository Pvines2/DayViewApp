//
//  ContentView.swift
//  DayView
//
//  Created by Parker Vines on 11/14/24.
//


import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = DayViewViewModel()
    @ObservedObject var authViewModel = AuthViewModel()

    var body: some View {
        NavigationView {
            if authViewModel.user == nil {
                AuthView(authViewModel: authViewModel)
            } else {
                CalendarView(viewModel: viewModel)
                    .onAppear {
                        viewModel.fetchAllEvents()
                        viewModel.fetchPersonnelData()
                    }
            }
        }
        .navigationBarHidden(true)
    }
}

