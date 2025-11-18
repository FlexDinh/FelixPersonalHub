//
//  HSKQuizView.swift
//  FelixPersonalHub
//
//  Created on 2024
//

import SwiftUI

struct HSKQuizView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var persistenceService: PersistenceService
    @ObservedObject var viewModel: HSKViewModel
    
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: Int? = nil
    @State private var correctAnswers = 0
    @State private var showingResult = false
    
    private let totalQuestions = 10
    private var questions: [Flashcard] {
        Array(viewModel.flashcards.shuffled().prefix(totalQuestions))
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                if currentQuestionIndex < questions.count {
                    let question = questions[currentQuestionIndex]
                    
                    // Progress
                    VStack(spacing: 8) {
                        Text("Question \(currentQuestionIndex + 1) of \(totalQuestions)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        ProgressView(value: Double(currentQuestionIndex), total: Double(totalQuestions))
                            .tint(.red)
                    }
                    .padding()
                    
                    // Question Card
                    VStack(spacing: 20) {
                        Text(question.front ?? "")
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        if let selected = selectedAnswer {
                            VStack(spacing: 12) {
                                Text(selected == 0 ? "Correct!" : "Incorrect")
                                    .font(.headline)
                                    .foregroundColor(selected == 0 ? .green : .red)
                                
                                Text("Answer: \(question.back ?? "")")
                                    .font(.body)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    
                    // Answer Options (Simple: Show/Hide)
                    if selectedAnswer == nil {
                        Button(action: {
                            // Simple quiz: show answer immediately
                            selectedAnswer = 0
                        }) {
                            Text("Show Answer")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    } else {
                        Button(action: {
                            if selectedAnswer == 0 {
                                correctAnswers += 1
                            }
                            nextQuestion()
                        }) {
                            Text("Next Question")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                } else {
                    // Quiz Complete
                    VStack(spacing: 20) {
                        Text("Quiz Complete!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("\(correctAnswers)/\(totalQuestions) correct")
                            .font(.title)
                            .foregroundColor(.red)
                        
                        Text("\(Int((Double(correctAnswers) / Double(totalQuestions)) * 100))%")
                            .font(.system(size: 60))
                            .fontWeight(.bold)
                            .foregroundColor(scoreColor(correctAnswers, totalQuestions))
                    }
                    .padding()
                }
            }
            .padding()
            .navigationTitle("HSK Quiz")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        if currentQuestionIndex >= questions.count {
                            saveResult()
                        }
                        dismiss()
                    }
                }
            }
            .onAppear {
                if questions.isEmpty {
                    dismiss()
                }
            }
        }
    }
    
    private func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswer = nil
        } else {
            saveResult()
            showingResult = true
        }
    }
    
    private func saveResult() {
        persistenceService.createHSKQuizResult(
            date: Date(),
            correct: correctAnswers,
            total: totalQuestions
        )
        viewModel.loadData(persistenceService: persistenceService)
    }
    
    private func scoreColor(_ correct: Int, _ total: Int) -> Color {
        let percentage = Double(correct) / Double(total)
        if percentage >= 0.8 { return .green }
        if percentage >= 0.6 { return .orange }
        return .red
    }
}

#Preview {
    HSKQuizView(viewModel: HSKViewModel())
        .environmentObject(PersistenceService.shared)
}

