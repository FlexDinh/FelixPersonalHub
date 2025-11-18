//
//  DashboardView.swift
//  FelixPersonalHub
//
//  Created on 2024
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var persistenceService: PersistenceService
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // IELTS Card
                    DashboardCard(
                        title: "IELTS Progress",
                        progress: viewModel.ieltsProgress,
                        target: "7.0",
                        color: .blue,
                        action: {
                            // Navigate to IELTS
                        }
                    )
                    
                    // HSK Card
                    DashboardCard(
                        title: "HSK Progress",
                        progress: viewModel.hskProgress,
                        target: "Level 4",
                        color: .red,
                        action: {
                            // Navigate to HSK
                        }
                    )
                    
                    // Graduation Card
                    DashboardCard(
                        title: "Graduation",
                        progress: viewModel.graduationProgress,
                        target: "2026",
                        color: .green,
                        action: {
                            // Navigate to Graduation
                        }
                    )
                    
                    // Sleep Card
                    DashboardCard(
                        title: "Sleep Recovery",
                        progress: viewModel.sleepRecovery,
                        target: "100%",
                        color: .purple,
                        action: {
                            // Navigate to Health
                        }
                    )
                    
                    // Quick Actions
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Quick Actions")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        HStack(spacing: 12) {
                            QuickActionButton(title: "Log Sleep", icon: "moon.fill", color: .purple)
                            QuickActionButton(title: "Add Expense", icon: "dollarsign.circle.fill", color: .green)
                            QuickActionButton(title: "Start Study", icon: "book.fill", color: .blue)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
            .navigationTitle("Dashboard")
            .onAppear {
                viewModel.loadData(persistenceService: persistenceService)
            }
        }
    }
}

struct DashboardCard: View {
    let title: String
    let progress: Double
    let target: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(title)
                        .font(.headline)
                    Spacer()
                    Text(target)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                ProgressView(value: progress, total: 100)
                    .tint(color)
                
                Text("\(Int(progress))%")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(color)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct QuickActionButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 1)
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(PersistenceService.shared)
}

