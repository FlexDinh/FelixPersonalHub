//
//  ProgressCalculator.swift
//  FelixPersonalHub
//
//  Created on 2024
//

import Foundation

struct ProgressCalculator {
    // MARK: - IELTS Progress
    
    static func calculateIELTSProgress(tests: [IELTSTest]) -> (average: Double, listening: Double, reading: Double, writing: Double, speaking: Double) {
        guard !tests.isEmpty else {
            return (0.0, 0.0, 0.0, 0.0, 0.0)
        }
        
        let listening = tests.map { $0.listening }.reduce(0, +) / Double(tests.count)
        let reading = tests.map { $0.reading }.reduce(0, +) / Double(tests.count)
        let writing = tests.map { $0.writing }.reduce(0, +) / Double(tests.count)
        let speaking = tests.map { $0.speaking }.reduce(0, +) / Double(tests.count)
        
        let average = (listening + reading + writing + speaking) / 4.0
        
        return (average, listening, reading, writing, speaking)
    }
    
    static func calculateIELTSProgressPercentage(current: Double, target: Double) -> Double {
        guard target > 0 else { return 0.0 }
        return min((current / target) * 100.0, 100.0)
    }
    
    // MARK: - HSK Progress
    
    static func calculateHSKProgress(knownCount: Int, totalGoal: Int) -> Double {
        guard totalGoal > 0 else { return 0.0 }
        return min((Double(knownCount) / Double(totalGoal)) * 100.0, 100.0)
    }
    
    // MARK: - Graduation Progress
    
    static func calculateGraduationProgress(courses: [Course]) -> (completed: Int, total: Int, percentage: Double) {
        let total = courses.count
        let completed = courses.filter { $0.completed }.count
        
        guard total > 0 else {
            return (0, 0, 0.0)
        }
        
        let percentage = (Double(completed) / Double(total)) * 100.0
        
        return (completed, total, percentage)
    }
    
    static func calculateGPA(courses: [Course]) -> Double {
        let completedCourses = courses.filter { $0.completed && $0.grade > 0 }
        guard !completedCourses.isEmpty else { return 0.0 }
        
        let totalPoints = completedCourses.map { $0.grade * Double($0.credits) }.reduce(0, +)
        let totalCredits = completedCourses.map { Double($0.credits) }.reduce(0, +)
        
        guard totalCredits > 0 else { return 0.0 }
        return totalPoints / totalCredits
    }
    
    // MARK: - Recovery Score
    
    static func calculateRecoveryScore(hoursSleep: Double, nightStudyHours: Double) -> Double {
        var score = (hoursSleep / 8.0) * 100.0
        score = max(0.0, min(100.0, score))
        
        if nightStudyHours > 2.0 {
            score = max(0.0, score - 10.0)
        }
        
        return score
    }
}

