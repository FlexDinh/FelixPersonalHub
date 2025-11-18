//
//  FlashcardListView.swift
//  FelixPersonalHub
//
//  Created on 2024
//

import SwiftUI

struct FlashcardListView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var persistenceService: PersistenceService
    
    let module: String
    @State private var flashcards: [Flashcard] = []
    @State private var showingAddCard = false
    @State private var showingStudy = false
    @State private var studyCards: [Flashcard] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                if flashcards.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "rectangle.stack")
                            .font(.system(size: 60))
                            .foregroundColor(.secondary)
                        Text("No flashcards yet")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Button("Create First Card") {
                            showingAddCard = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    List {
                        ForEach(flashcards, id: \.id) { card in
                            FlashcardRowView(card: card, persistenceService: persistenceService)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                persistenceService.deleteFlashcard(flashcards[index])
                            }
                            loadFlashcards()
                        }
                    }
                }
            }
            .navigationTitle("\(module) Flashcards")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    HStack {
                        Button(action: {
                            studyCards = flashcards.filter { $0.status != "Known" }
                            if !studyCards.isEmpty {
                                showingStudy = true
                            }
                        }) {
                            Label("Study", systemImage: "play.fill")
                        }
                        .disabled(flashcards.filter { $0.status != "Known" }.isEmpty)
                        
                        Button(action: { showingAddCard = true }) {
                            Label("Add", systemImage: "plus")
                        }
                    }
                }
            }
            .onAppear {
                loadFlashcards()
            }
            .sheet(isPresented: $showingAddCard) {
                AddFlashcardView(module: module) {
                    loadFlashcards()
                }
            }
            .sheet(isPresented: $showingStudy) {
                FlashcardStudyView(cards: studyCards, persistenceService: persistenceService) {
                    loadFlashcards()
                }
            }
        }
    }
    
    private func loadFlashcards() {
        flashcards = persistenceService.fetchFlashcards(module: module)
    }
}

struct FlashcardRowView: View {
    let card: Flashcard
    let persistenceService: PersistenceService
    @State private var isFlipped = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(card.front ?? "")
                    .font(.headline)
                Spacer()
                Text(card.status ?? "New")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(statusColor(card.status ?? "New"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            if isFlipped {
                Text(card.back ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Text("Seen: \(Int(card.knownCount)) times")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                if let lastSeen = card.lastSeen {
                    Text(lastSeen, style: .relative)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                isFlipped.toggle()
            }
        }
    }
    
    private func statusColor(_ status: String) -> Color {
        switch status {
        case "Known": return .green
        case "Learning": return .orange
        default: return .blue
        }
    }
}

#Preview {
    FlashcardListView(module: "IELTS")
        .environmentObject(PersistenceService.shared)
}

