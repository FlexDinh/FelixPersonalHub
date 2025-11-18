//
//  AddIELTSTestView.swift
//  FelixPersonalHub
//
//  Created on 2024
//

import SwiftUI

struct AddIELTSTestView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var persistenceService: PersistenceService
    @ObservedObject var viewModel: IELTSViewModel
    
    @State private var date = Date()
    @State private var listening: Double = 6.0
    @State private var reading: Double = 6.0
    @State private var writing: Double = 6.0
    @State private var speaking: Double = 6.0
    @State private var notes: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Test Date") {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
                
                Section("Scores") {
                    VStack(alignment: .leading, spacing: 16) {
                        ScoreSlider(label: "Listening", value: $listening)
                        ScoreSlider(label: "Reading", value: $reading)
                        ScoreSlider(label: "Writing", value: $writing)
                        ScoreSlider(label: "Speaking", value: $speaking)
                    }
                    .padding(.vertical, 8)
                }
                
                Section("Notes") {
                    TextEditor(text: $notes)
                        .frame(height: 100)
                }
            }
            .navigationTitle("Add Test Result")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        persistenceService.createIELTSTest(
                            date: date,
                            listening: listening,
                            reading: reading,
                            writing: writing,
                            speaking: speaking,
                            notes: notes.isEmpty ? nil : notes
                        )
                        viewModel.loadData(persistenceService: persistenceService)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ScoreSlider: View {
    let label: String
    @Binding var value: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(label)
                    .font(.subheadline)
                Spacer()
                Text(String(format: "%.1f", value))
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            Slider(value: $value, in: 0...9, step: 0.5)
        }
    }
}

#Preview {
    AddIELTSTestView(viewModel: IELTSViewModel())
        .environmentObject(PersistenceService.shared)
}

