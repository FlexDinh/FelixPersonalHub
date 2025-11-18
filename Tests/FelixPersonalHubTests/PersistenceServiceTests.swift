//
//  PersistenceServiceTests.swift
//  FelixPersonalHubTests
//
//  Created on 2024
//

import XCTest
import CoreData
@testable import FelixPersonalHub

final class PersistenceServiceTests: XCTestCase {
    var persistenceService: PersistenceService!
    
    override func setUp() {
        super.setUp()
        // Use in-memory store for tests
        persistenceService = PersistenceService(inMemory: true)
    }
    
    override func tearDown() {
        persistenceService = nil
        super.tearDown()
    }
    
    func testCreateAndFetchIELTSTest() {
        let test = persistenceService.createIELTSTest(
            date: Date(),
            listening: 7.0,
            reading: 6.5,
            writing: 7.0,
            speaking: 6.5,
            notes: "Test note"
        )
        
        XCTAssertNotNil(test.id)
        XCTAssertEqual(test.listening, 7.0)
        XCTAssertEqual(test.reading, 6.5)
        
        let fetchedTests = persistenceService.fetchIELTSTests()
        XCTAssertEqual(fetchedTests.count, 1)
        XCTAssertEqual(fetchedTests.first?.id, test.id)
    }
    
    func testCreateAndFetchFlashcard() {
        let card = persistenceService.createFlashcard(
            module: "IELTS",
            front: "Test Front",
            back: "Test Back"
        )
        
        XCTAssertNotNil(card.id)
        XCTAssertEqual(card.module, "IELTS")
        XCTAssertEqual(card.front, "Test Front")
        XCTAssertEqual(card.status, "New")
        
        let fetchedCards = persistenceService.fetchFlashcards(module: "IELTS")
        XCTAssertEqual(fetchedCards.count, 1)
        XCTAssertEqual(fetchedCards.first?.id, card.id)
    }
    
    func testUpdateFlashcard() {
        let card = persistenceService.createFlashcard(
            module: "HSK",
            front: "你好",
            back: "Hello"
        )
        
        persistenceService.updateFlashcard(card, status: "Known", knownCount: 5)
        
        XCTAssertEqual(card.status, "Known")
        XCTAssertEqual(card.knownCount, 5)
    }
    
    func testCreateAndFetchExpense() {
        let expense = persistenceService.createExpense(
            date: Date(),
            amount: 100000,
            category: "Food",
            note: "Lunch"
        )
        
        XCTAssertNotNil(expense.id)
        XCTAssertEqual(expense.amount, 100000)
        XCTAssertEqual(expense.category, "Food")
        
        let fetchedExpenses = persistenceService.fetchExpenses()
        XCTAssertEqual(fetchedExpenses.count, 1)
    }
    
    func testGetOrCreateUser() {
        let user1 = persistenceService.getOrCreateUser()
        let user2 = persistenceService.getOrCreateUser()
        
        // Should return the same user
        XCTAssertEqual(user1.id, user2.id)
        XCTAssertEqual(user1.locale, "vi")
        XCTAssertEqual(user1.ieltsTarget, 7.0)
    }
}

