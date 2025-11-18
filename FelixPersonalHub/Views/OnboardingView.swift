//
//  OnboardingView.swift
//  FelixPersonalHub
//
//  Created on 2024
//

import SwiftUI

struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var currentPage = 0
    @StateObject private var notificationService = NotificationService.shared
    
    var body: some View {
        TabView(selection: $currentPage) {
            OnboardingPage(
                title: "Welcome to Felix Personal Hub",
                description: "Your all-in-one personal dashboard for IELTS, HSK, graduation tracking, health, workouts, and finance.",
                systemImage: "star.fill",
                color: .blue
            )
            .tag(0)
            
            OnboardingPage(
                title: "Stay Organized",
                description: "Track your progress, set goals, and achieve your targets with personalized reminders and insights.",
                systemImage: "chart.line.uptrend.xyaxis",
                color: .green
            )
            .tag(1)
            
            PermissionsPage(hasCompletedOnboarding: $hasCompletedOnboarding)
                .tag(2)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct OnboardingPage: View {
    let title: String
    let description: String
    let systemImage: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: systemImage)
                .font(.system(size: 80))
                .foregroundColor(color)
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding()
    }
}

struct PermissionsPage: View {
    @Binding var hasCompletedOnboarding: Bool
    @StateObject private var notificationService = NotificationService.shared
    @State private var notificationPermissionGranted = false
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "bell.badge.fill")
                .font(.system(size: 80))
                .foregroundColor(.orange)
            
            Text("Enable Notifications")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Get reminders for study sessions, sleep wind-down, and workouts to stay on track.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button(action: {
                notificationService.requestAuthorization { granted in
                    notificationPermissionGranted = granted
                }
            }) {
                Text(notificationPermissionGranted ? "Notifications Enabled" : "Enable Notifications")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(notificationPermissionGranted ? Color.green : Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 40)
            .disabled(notificationPermissionGranted)
            
            Button(action: {
                hasCompletedOnboarding = true
                UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
            }) {
                Text("Get Started")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 40)
        }
        .padding()
    }
}

#Preview {
    OnboardingView(hasCompletedOnboarding: .constant(false))
}

