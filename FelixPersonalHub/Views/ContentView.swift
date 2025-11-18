//
//  ContentView.swift
//  FelixPersonalHub
//
//  Created on 2024
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    
    var body: some View {
        Group {
            if hasCompletedOnboarding {
                MainTabView(selectedTab: $selectedTab)
            } else {
                OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
            }
        }
    }
}

struct MainTabView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "house.fill")
                }
                .tag(0)
            
            StudyView()
                .tabItem {
                    Label("Study", systemImage: "book.fill")
                }
                .tag(1)
            
            HealthView()
                .tabItem {
                    Label("Health", systemImage: "heart.fill")
                }
                .tag(2)
            
            WorkoutView()
                .tabItem {
                    Label("Workout", systemImage: "figure.run")
                }
                .tag(3)
            
            FinanceView()
                .tabItem {
                    Label("Finance", systemImage: "dollarsign.circle.fill")
                }
                .tag(4)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(5)
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceService.shared.container.viewContext)
        .environmentObject(PersistenceService.shared)
}

