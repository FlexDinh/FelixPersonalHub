//
//  IELTSViewModel.swift
//  FelixPersonalHub
//
//  Created on 2024
//

import Foundation
import Combine

@MainActor
class IELTSViewModel: ObservableObject {
    @Published var tests: [IELTSTest] = []
    @Published var averageScore: Double = 0.0
    @Published var listeningScore: Double = 0.0
    @Published var readingScore: Double = 0.0
    @Published var writingScore: Double = 0.0
    @Published var speakingScore: Double = 0.0
    @Published var targetScore: Double = 7.0
    @Published var progressPercentage: Double = 0.0
    
    func loadData(persistenceService: PersistenceService) {
        tests = persistenceService.fetchIELTSTests()
        
        if !tests.isEmpty {
            let progress = ProgressCalculator.calculateIELTSProgress(tests: tests)
            averageScore = progress.average
            listeningScore = progress.listening
            readingScore = progress.reading
            writingScore = progress.writing
            speakingScore = progress.speaking
        }
        
        let user = persistenceService.getOrCreateUser()
        targetScore = user.ieltsTarget
        progressPercentage = ProgressCalculator.calculateIELTSProgressPercentage(
            current: averageScore,
            target: targetScore
        )
    }
}

