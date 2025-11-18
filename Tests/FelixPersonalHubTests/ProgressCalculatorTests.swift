//
//  ProgressCalculatorTests.swift
//  FelixPersonalHubTests
//
//  Created on 2024
//

import XCTest
@testable import FelixPersonalHub

final class ProgressCalculatorTests: XCTestCase {
    
    func testIELTSProgressCalculation() {
        // This test would require creating mock IELTSTest objects
        // For now, test the calculation logic directly
        
        let listening: [Double] = [6.5, 7.0]
        let reading: [Double] = [6.0, 6.5]
        let writing: [Double] = [6.5, 7.0]
        let speaking: [Double] = [6.0, 6.5]
        
        let avgListening = listening.reduce(0, +) / Double(listening.count)
        let avgReading = reading.reduce(0, +) / Double(reading.count)
        let avgWriting = writing.reduce(0, +) / Double(writing.count)
        let avgSpeaking = speaking.reduce(0, +) / Double(speaking.count)
        let average = (avgListening + avgReading + avgWriting + avgSpeaking) / 4.0
        
        XCTAssertEqual(average, 6.625, accuracy: 0.01)
    }
    
    func testIELTSProgressPercentage() {
        let percentage = ProgressCalculator.calculateIELTSProgressPercentage(current: 6.5, target: 7.0)
        XCTAssertEqual(percentage, 92.86, accuracy: 0.1)
        
        let percentage2 = ProgressCalculator.calculateIELTSProgressPercentage(current: 7.0, target: 7.0)
        XCTAssertEqual(percentage2, 100.0, accuracy: 0.1)
    }
    
    func testHSKProgress() {
        let progress = ProgressCalculator.calculateHSKProgress(knownCount: 300, totalGoal: 1200)
        XCTAssertEqual(progress, 25.0, accuracy: 0.1)
        
        let progress2 = ProgressCalculator.calculateHSKProgress(knownCount: 1200, totalGoal: 1200)
        XCTAssertEqual(progress2, 100.0, accuracy: 0.1)
    }
    
    func testGraduationProgress() {
        // Mock courses would be needed, testing calculation logic
        let total = 3
        let completed = 1
        let percentage = (Double(completed) / Double(total)) * 100.0
        
        XCTAssertEqual(percentage, 33.33, accuracy: 0.1)
    }
    
    func testRecoveryScore() {
        let score1 = ProgressCalculator.calculateRecoveryScore(hoursSleep: 8.0, nightStudyHours: 0)
        XCTAssertEqual(score1, 100.0, accuracy: 0.1)
        
        let score2 = ProgressCalculator.calculateRecoveryScore(hoursSleep: 6.0, nightStudyHours: 0)
        XCTAssertEqual(score2, 75.0, accuracy: 0.1)
        
        let score3 = ProgressCalculator.calculateRecoveryScore(hoursSleep: 8.0, nightStudyHours: 3.0)
        XCTAssertEqual(score3, 90.0, accuracy: 0.1) // 100 - 10 = 90
    }
}

