//
//  AddFlashcardView.swift
//  FelixPersonalHub
//
//  Created on 2024
//

import SwiftUI

struct AddFlashcardView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var persistenceService: PersistenceService
    
    let module: String
    let onSave: () -> Void
    
    @State private var front: String = ""
    @State private var back: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Front") {
                    TextEditor(text: $front)
                        .frame(height: 100)
                }
                
                Section("Back") {
                    TextEditor(text: $back)
                        .frame(height: 100)
                }
            }
            .navigationTitle("New Flashcard")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        guard !front.isEmpty && !back.isEmpty else { return }
                        persistenceService.createFlashcard(module: module, front: front, back: back)
                        onSave()
                        dismiss()
                    }
                    .disabled(front.isEmpty || back.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddFlashcardView(module: "IELTS") {}
        .environmentObject(PersistenceService.shared)
}

