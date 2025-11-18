//
//  HSKViewModel.swift
//  FelixPersonalHub
//
//  Created on 2024
//

import Foundation
import Combine

@MainActor
class HSKViewModel: ObservableObject {
    @Published var flashcards: [Flashcard] = []
    @Published var quizResults: [HSKQuizResult] = []
    @Published var knownCount: Int = 0
    @Published var targetCount: Int = 1200 // HSK4 approximate
    @Published var progressPercentage: Double = 0.0
    
    func loadData(persistenceService: PersistenceService) {
        flashcards = persistenceService.fetchFlashcards(module: "HSK")
        quizResults = persistenceService.fetchHSKQuizResults()
        
        knownCount = flashcards.filter { $0.status == "Known" }.count
        
        let user = persistenceService.getOrCreateUser()
        targetCount = Int(user.hskLevel) * 300 // Approximate vocab per level
        
        progressPercentage = ProgressCalculator.calculateHSKProgress(
            knownCount: knownCount,
            totalGoal: targetCount
        )
    }
}

