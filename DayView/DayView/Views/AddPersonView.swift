//
//  AddPersonView.swift
//  DayView
//
//  Created by Parker Vines on 11/26/24.
//


import SwiftUI

struct AddPersonView: View {
    @ObservedObject var viewModel: DayViewViewModel
    @Environment(\.dismiss) var dismiss

    @State private var personnelName: String = ""
    @State private var selectedColorName: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personnel Details")) {
                    TextField("Name", text: $personnelName)
                    
                    Picker("Color", selection: $selectedColorName) {
                        ForEach(viewModel.predefinedColors, id: \.name) { color in
                            Text(color.name).tag(color.name)
                        }
                    }
                }

                Section {
                    Button(action: {
                        guard !personnelName.isEmpty else {
                            print("Name is required.")
                            return
                        }
                        viewModel.addPersonnel(name: personnelName, colorName: selectedColorName)
                        dismiss()
                    }) {
                        Text("Add")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            .navigationTitle("Add Person")
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            })
        }
    }
}
