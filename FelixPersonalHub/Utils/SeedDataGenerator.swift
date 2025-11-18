//
//  SeedDataGenerator.swift
//  FelixPersonalHub
//
//  Created on 2024
//

import Foundation
import CoreData

class SeedDataGenerator {
    let persistenceService: PersistenceService
    
    init(persistenceService: PersistenceService) {
        self.persistenceService = persistenceService
    }
    
    func generateSeedData() {
        // Clear existing data (optional - for dev only)
        // In production, check if data exists first
        
        // 1. IELTS Tests (2 tests)
        let test1 = persistenceService.createIELTSTest(
            date: Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date(),
            listening: 6.5,
            reading: 6.0,
            writing: 6.5,
            speaking: 6.0,
            notes: "First practice test"
        )
        
        let test2 = persistenceService.createIELTSTest(
            date: Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date(),
            listening: 7.0,
            reading: 6.5,
            writing: 7.0,
            speaking: 6.5,
            notes: "Recent improvement"
        )
        
        // 2. HSK Flashcards (50 cards)
        let hskWords = [
            ("你好", "Hello"),
            ("谢谢", "Thank you"),
            ("再见", "Goodbye"),
            ("请", "Please"),
            ("对不起", "Sorry"),
            ("是的", "Yes"),
            ("不", "No"),
            ("我", "I/Me"),
            ("你", "You"),
            ("他", "He/Him"),
            ("她", "She/Her"),
            ("我们", "We/Us"),
            ("他们", "They/Them"),
            ("这", "This"),
            ("那", "That"),
            ("什么", "What"),
            ("哪里", "Where"),
            ("谁", "Who"),
            ("为什么", "Why"),
            ("怎么", "How"),
            ("今天", "Today"),
            ("明天", "Tomorrow"),
            ("昨天", "Yesterday"),
            ("现在", "Now"),
            ("以后", "Later"),
            ("学校", "School"),
            ("学生", "Student"),
            ("老师", "Teacher"),
            ("书", "Book"),
            ("学习", "Study"),
            ("工作", "Work"),
            ("家", "Home"),
            ("朋友", "Friend"),
            ("吃", "Eat"),
            ("喝", "Drink"),
            ("去", "Go"),
            ("来", "Come"),
            ("看", "See/Look"),
            ("听", "Listen"),
            ("说", "Speak"),
            ("读", "Read"),
            ("写", "Write"),
            ("喜欢", "Like"),
            ("爱", "Love"),
            ("好", "Good"),
            ("大", "Big"),
            ("小", "Small"),
            ("新", "New"),
            ("老", "Old"),
            ("多", "Many")
        ]
        
        for (front, back) in hskWords {
            persistenceService.createFlashcard(module: "HSK", front: front, back: back)
        }
        
        // 3. IELTS Flashcards (sample)
        let ieltsCards = [
            ("Acquire", "To gain or obtain something"),
            ("Analyze", "To examine in detail"),
            ("Assess", "To evaluate or estimate"),
            ("Benefit", "An advantage or profit"),
            ("Consequence", "A result or effect"),
            ("Consider", "To think carefully about"),
            ("Contribute", "To give or add something"),
            ("Demonstrate", "To show clearly"),
            ("Determine", "To decide or establish"),
            ("Develop", "To grow or progress")
        ]
        
        for (front, back) in ieltsCards {
            persistenceService.createFlashcard(module: "IELTS", front: front, back: back)
        }
        
        // 4. HSK Quiz Results (sample)
        persistenceService.createHSKQuizResult(
            date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(),
            correct: 8,
            total: 10
        )
        
        persistenceService.createHSKQuizResult(
            date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(),
            correct: 9,
            total: 10
        )
        
        // 5. Courses (remaining courses)
        persistenceService.createCourse(name: "Bơi", credits: 2, completed: false, grade: nil)
        persistenceService.createCourse(name: "Kỹ năng sống", credits: 2, completed: false, grade: nil)
        persistenceService.createCourse(name: "Tự chọn 2", credits: 3, completed: false, grade: nil)
        
        // 6. Expenses (5 expenses)
        let categories = ["Food", "Transport", "Entertainment", "Shopping", "Education"]
        let amounts: [Double] = [150000, 50000, 200000, 300000, 500000]
        
        for i in 0..<5 {
            persistenceService.createExpense(
                date: Calendar.current.date(byAdding: .day, value: -(i * 2), to: Date()) ?? Date(),
                amount: amounts[i],
                category: categories[i],
                note: "Sample expense \(i + 1)"
            )
        }
        
        // 7. Sleep Logs (sample)
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        let sleepStart = Calendar.current.date(bySettingHour: 23, minute: 0, second: 0, of: yesterday) ?? yesterday
        let sleepEnd = Calendar.current.date(bySettingHour: 7, minute: 0, second: 0, of: Date()) ?? Date()
        let hoursSleep = sleepEnd.timeIntervalSince(sleepStart) / 3600.0
        
        persistenceService.createSleepLog(
            date: yesterday,
            start: sleepStart,
            end: sleepEnd,
            recoveryScore: ProgressCalculator.calculateRecoveryScore(hoursSleep: hoursSleep, nightStudyHours: 0)
        )
        
        print("Seed data generated successfully!")
    }
}

