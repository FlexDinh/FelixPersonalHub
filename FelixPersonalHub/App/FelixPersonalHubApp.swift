//
//  FelixPersonalHubApp.swift
//  FelixPersonalHub
//
//  Created on 2024
//

import SwiftUI

@main
struct FelixPersonalHubApp: App {
    @StateObject private var persistenceService = PersistenceService.shared
    
    init() {
        // Generate seed data on first launch (development only)
        // Remove this in production!
        #if DEBUG
        let hasSeeded = UserDefaults.standard.bool(forKey: "hasSeededData")
        if !hasSeeded {
            let generator = SeedDataGenerator(persistenceService: persistenceService)
            generator.generateSeedData()
            UserDefaults.standard.set(true, forKey: "hasSeededData")
        }
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceService.container.viewContext)
                .environmentObject(persistenceService)
        }
    }
}
