//
//  HSKView.swift
//  FelixPersonalHub
//
//  Created on 2024
//

import SwiftUI

struct HSKView: View {
    @EnvironmentObject var persistenceService: PersistenceService
    @StateObject private var viewModel = HSKViewModel()
    @State private var showingQuiz = false
    @State private var showingFlashcards = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Progress Overview
                VStack(alignment: .leading, spacing: 12) {
                    Text("Vocabulary Progress")
                        .font(.headline)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Known Words")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("\(viewModel.knownCount)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("Target")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("\(viewModel.targetCount)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                        }
                    }
                    
                    ProgressView(value: viewModel.progressPercentage, total: 100)
                        .tint(.red)
                    
                    Text("\(Int(viewModel.progressPercentage))% Complete")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                // Actions
                HStack(spacing: 12) {
                    Button(action: { showingQuiz = true }) {
                        Label("Daily Quiz", systemImage: "questionmark.circle.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    Button(action: { showingFlashcards = true }) {
                        Label("Flashcards", systemImage: "rectangle.stack.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                // Quiz History
                VStack(alignment: .leading, spacing: 12) {
                    Text("Recent Quizzes")
                        .font(.headline)
                    
                    if viewModel.quizResults.isEmpty {
                        Text("No quizzes completed yet")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                    } else {
                        ForEach(viewModel.quizResults.prefix(5), id: \.id) { result in
                            QuizResultRowView(result: result)
                        }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
            }
            .padding()
        }
        .navigationTitle("HSK")
        .onAppear {
            viewModel.loadData(persistenceService: persistenceService)
        }
        .sheet(isPresented: $showingQuiz) {
            HSKQuizView(viewModel: viewModel)
        }
        .sheet(isPresented: $showingFlashcards) {
            FlashcardListView(module: "HSK")
        }
    }
}

struct QuizResultRowView: View {
    let result: HSKQuizResult
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(result.date ?? Date(), style: .date)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("\(Int(result.correct))/\(Int(result.total)) correct")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text("\(Int((result.correct / result.total) * 100))%")
                .font(.headline)
                .foregroundColor(scoreColor(result.correct, result.total))
        }
        .padding(.vertical, 4)
    }
    
    private func scoreColor(_ correct: Int32, _ total: Int32) -> Color {
        let percentage = Double(correct) / Double(total)
        if percentage >= 0.8 { return .green }
        if percentage >= 0.6 { return .orange }
        return .red
    }
}

#Preview {
    NavigationStack {
        HSKView()
            .environmentObject(PersistenceService.shared)
    }
}

