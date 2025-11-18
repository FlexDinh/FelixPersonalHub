//
//  FlashcardStudyView.swift
//  FelixPersonalHub
//
//  Created on 2024
//

import SwiftUI

struct FlashcardStudyView: View {
    @Environment(\.dismiss) var dismiss
    let cards: [Flashcard]
    let persistenceService: PersistenceService
    let onComplete: () -> Void
    
    @State private var currentIndex = 0
    @State private var isFlipped = false
    @State private var showingCompletion = false
    
    private var currentCard: Flashcard? {
        guard currentIndex < cards.count else { return nil }
        return cards[currentIndex]
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                if let card = currentCard, !showingCompletion {
                    // Progress
                    VStack(spacing: 8) {
                        Text("Card \(currentIndex + 1) of \(cards.count)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        ProgressView(value: Double(currentIndex), total: Double(cards.count))
                    }
                    .padding()
                    
                    // Card
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                        
                        VStack(spacing: 20) {
                            Text(isFlipped ? "Back" : "Front")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .textCase(.uppercase)
                            
                            Text(isFlipped ? (card.back ?? "") : (card.front ?? ""))
                                .font(.title2)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    }
                    .frame(height: 300)
                    .padding()
                    .rotation3DEffect(
                        .degrees(isFlipped ? 180 : 0),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    .onTapGesture {
                        withAnimation {
                            isFlipped.toggle()
                        }
                    }
                    
                    // Actions
                    if isFlipped {
                        HStack(spacing: 16) {
                            Button(action: {
                                markCard(card, status: "New")
                            }) {
                                Label("Again", systemImage: "xmark.circle")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                            
                            Button(action: {
                                markCard(card, status: "Learning")
                            }) {
                                Label("Learning", systemImage: "arrow.clockwise")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                            
                            Button(action: {
                                markCard(card, status: "Known")
                            }) {
                                Label("Known", systemImage: "checkmark.circle")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal)
                    } else {
                        Button(action: {
                            withAnimation {
                                isFlipped = true
                            }
                        }) {
                            Text("Show Answer")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                } else {
                    // Completion
                    VStack(spacing: 20) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.green)
                        Text("Study Session Complete!")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding()
                }
            }
            .navigationTitle("Study Flashcards")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func markCard(_ card: Flashcard, status: String) {
        let newKnownCount = card.knownCount + 1
        persistenceService.updateFlashcard(card, status: status, knownCount: Int(newKnownCount))
        
        if currentIndex < cards.count - 1 {
            currentIndex += 1
            isFlipped = false
        } else {
            showingCompletion = true
            onComplete()
        }
    }
}

#Preview {
    FlashcardStudyView(cards: [], persistenceService: PersistenceService.shared) {}
}

