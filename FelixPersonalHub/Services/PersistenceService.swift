//
//  PersistenceService.swift
//  FelixPersonalHub
//
//  Created on 2024
//

import CoreData
import Foundation

class PersistenceService: ObservableObject {
    static let shared = PersistenceService()
    
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "CoreDataModel")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        } else {
            // Configure for CloudKit sync (stub - can be enabled later)
            let description = container.persistentStoreDescriptions.first
            description?.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
            description?.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
            // Uncomment to enable CloudKit:
            // description?.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.felix.personalhub")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - User Management
    
    func getOrCreateUser() -> User {
        let context = container.viewContext
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.fetchLimit = 1
        
        if let user = try? context.fetch(request).first {
            return user
        }
        
        let user = User(context: context)
        user.id = UUID()
        user.name = "Felix"
        user.locale = "vi"
        user.studyFreeTimes = "morning,evening"
        user.excludedDays = "Thursday,Sunday"
        user.ieltsTarget = 7.0
        user.hskLevel = 4
        user.graduationDate = Calendar.current.date(from: DateComponents(year: 2026, month: 10, day: 10))
        
        save()
        return user
    }
    
    // MARK: - IELTS
    
    func fetchIELTSTests() -> [IELTSTest] {
        let request: NSFetchRequest<IELTSTest> = IELTSTest.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \IELTSTest.date, ascending: false)]
        
        return (try? container.viewContext.fetch(request)) ?? []
    }
    
    func createIELTSTest(date: Date, listening: Double, reading: Double, writing: Double, speaking: Double, notes: String?) -> IELTSTest {
        let test = IELTSTest(context: container.viewContext)
        test.id = UUID()
        test.date = date
        test.listening = listening
        test.reading = reading
        test.writing = writing
        test.speaking = speaking
        test.notes = notes
        
        save()
        return test
    }
    
    // MARK: - Flashcards
    
    func fetchFlashcards(module: String) -> [Flashcard] {
        let request: NSFetchRequest<Flashcard> = Flashcard.fetchRequest()
        request.predicate = NSPredicate(format: "module == %@", module)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Flashcard.lastSeen, ascending: true)]
        
        return (try? container.viewContext.fetch(request)) ?? []
    }
    
    func createFlashcard(module: String, front: String, back: String) -> Flashcard {
        let card = Flashcard(context: container.viewContext)
        card.id = UUID()
        card.module = module
        card.front = front
        card.back = back
        card.status = "New"
        card.knownCount = 0
        card.lastSeen = Date()
        
        save()
        return card
    }
    
    func updateFlashcard(_ card: Flashcard, status: String, knownCount: Int) {
        card.status = status
        card.knownCount = Int32(knownCount)
        card.lastSeen = Date()
        save()
    }
    
    func deleteFlashcard(_ card: Flashcard) {
        container.viewContext.delete(card)
        save()
    }
    
    // MARK: - HSK Quiz
    
    func fetchHSKQuizResults() -> [HSKQuizResult] {
        let request: NSFetchRequest<HSKQuizResult> = HSKQuizResult.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \HSKQuizResult.date, ascending: false)]
        
        return (try? container.viewContext.fetch(request)) ?? []
    }
    
    func createHSKQuizResult(date: Date, correct: Int, total: Int) -> HSKQuizResult {
        let result = HSKQuizResult(context: container.viewContext)
        result.id = UUID()
        result.date = date
        result.correct = Int32(correct)
        result.total = Int32(total)
        
        save()
        return result
    }
    
    // MARK: - Courses
    
    func fetchCourses() -> [Course] {
        let request: NSFetchRequest<Course> = Course.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Course.name, ascending: true)]
        
        return (try? container.viewContext.fetch(request)) ?? []
    }
    
    func createCourse(name: String, credits: Int16, completed: Bool, grade: Double?) -> Course {
        let course = Course(context: container.viewContext)
        course.id = UUID()
        course.name = name
        course.credits = credits
        course.completed = completed
        course.grade = grade ?? 0.0
        
        save()
        return course
    }
    
    // MARK: - Sleep
    
    func fetchSleepLogs() -> [SleepLog] {
        let request: NSFetchRequest<SleepLog> = SleepLog.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \SleepLog.date, ascending: false)]
        
        return (try? container.viewContext.fetch(request)) ?? []
    }
    
    func createSleepLog(date: Date, start: Date, end: Date, recoveryScore: Double) -> SleepLog {
        let log = SleepLog(context: container.viewContext)
        log.id = UUID()
        log.date = date
        log.start = start
        log.end = end
        log.recoveryScore = recoveryScore
        
        save()
        return log
    }
    
    // MARK: - Night Study
    
    func fetchNightStudySessions() -> [NightStudySession] {
        let request: NSFetchRequest<NightStudySession> = NightStudySession.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \NightStudySession.date, ascending: false)]
        
        return (try? container.viewContext.fetch(request)) ?? []
    }
    
    func createNightStudySession(date: Date, start: Date, end: Date?, pomodoros: Int, focusedMinutes: Int) -> NightStudySession {
        let session = NightStudySession(context: container.viewContext)
        session.id = UUID()
        session.date = date
        session.start = start
        session.end = end
        session.pomodoros = Int32(pomodoros)
        session.focusedMinutes = Int32(focusedMinutes)
        
        save()
        return session
    }
    
    // MARK: - Workout
    
    func fetchWorkoutSessions() -> [WorkoutSession] {
        let request: NSFetchRequest<WorkoutSession> = WorkoutSession.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \WorkoutSession.date, ascending: false)]
        
        return (try? container.viewContext.fetch(request)) ?? []
    }
    
    func createWorkoutSession(date: Date, type: String, duration: Int, distance: Double, reps: Int, notes: String?) -> WorkoutSession {
        let session = WorkoutSession(context: container.viewContext)
        session.id = UUID()
        session.date = date
        session.type = type
        session.duration = Int32(duration)
        session.distance = distance
        session.reps = Int32(reps)
        session.notes = notes
        
        save()
        return session
    }
    
    // MARK: - Expenses
    
    func fetchExpenses() -> [Expense] {
        let request: NSFetchRequest<Expense> = Expense.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Expense.date, ascending: false)]
        
        return (try? container.viewContext.fetch(request)) ?? []
    }
    
    func createExpense(date: Date, amount: Double, category: String, note: String?) -> Expense {
        let expense = Expense(context: container.viewContext)
        expense.id = UUID()
        expense.date = date
        expense.amount = amount
        expense.category = category
        expense.note = note
        
        save()
        return expense
    }
    
    func deleteExpense(_ expense: Expense) {
        container.viewContext.delete(expense)
        save()
    }
}

