//
//  DashboardViewModel.swift
//  FelixPersonalHub
//
//  Created on 2024
//

import Foundation
import Combine

@MainActor
class DashboardViewModel: ObservableObject {
    @Published var ieltsProgress: Double = 0.0
    @Published var hskProgress: Double = 0.0
    @Published var graduationProgress: Double = 0.0
    @Published var sleepRecovery: Double = 0.0
    
    func loadData(persistenceService: PersistenceService) {
        // IELTS Progress
        let tests = persistenceService.fetchIELTSTests()
        if !tests.isEmpty {
            let progress = ProgressCalculator.calculateIELTSProgress(tests: tests)
            let user = persistenceService.getOrCreateUser()
            ieltsProgress = ProgressCalculator.calculateIELTSProgressPercentage(
                current: progress.average,
                target: user.ieltsTarget
            )
        }
        
        // HSK Progress
        let hskCards = persistenceService.fetchFlashcards(module: "HSK")
        let knownCount = hskCards.filter { $0.status == "Known" }.count
        let user = persistenceService.getOrCreateUser()
        hskProgress = ProgressCalculator.calculateHSKProgress(
            knownCount: knownCount,
            totalGoal: Int(user.hskLevel) * 300 // Approximate vocab per level
        )
        
        // Graduation Progress
        let courses = persistenceService.fetchCourses()
        let gradProgress = ProgressCalculator.calculateGraduationProgress(courses: courses)
        graduationProgress = gradProgress.percentage
        
        // Sleep Recovery (latest)
        let sleepLogs = persistenceService.fetchSleepLogs()
        if let latest = sleepLogs.first {
            sleepRecovery = latest.recoveryScore
        }
    }
}

