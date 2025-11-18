//
//  IELTSView.swift
//  FelixPersonalHub
//
//  Created on 2024
//

import SwiftUI

struct IELTSView: View {
    @EnvironmentObject var persistenceService: PersistenceService
    @StateObject private var viewModel = IELTSViewModel()
    @State private var showingAddTest = false
    @State private var showingFlashcards = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Progress Overview
                VStack(alignment: .leading, spacing: 12) {
                    Text("Overall Progress")
                        .font(.headline)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Average")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(String(format: "%.1f", viewModel.averageScore))
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("Target")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(String(format: "%.1f", viewModel.targetScore))
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                        }
                    }
                    
                    ProgressView(value: viewModel.progressPercentage, total: 100)
                        .tint(.blue)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                // Skill Breakdown
                VStack(alignment: .leading, spacing: 12) {
                    Text("Skills")
                        .font(.headline)
                    
                    SkillRow(name: "Listening", score: viewModel.listeningScore)
                    SkillRow(name: "Reading", score: viewModel.readingScore)
                    SkillRow(name: "Writing", score: viewModel.writingScore)
                    SkillRow(name: "Speaking", score: viewModel.speakingScore)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                // Actions
                HStack(spacing: 12) {
                    Button(action: { showingAddTest = true }) {
                        Label("Add Test Result", systemImage: "plus.circle.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    Button(action: { showingFlashcards = true }) {
                        Label("Flashcards", systemImage: "rectangle.stack.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                // Test History
                VStack(alignment: .leading, spacing: 12) {
                    Text("Test History")
                        .font(.headline)
                    
                    if viewModel.tests.isEmpty {
                        Text("No tests recorded yet")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                    } else {
                        ForEach(viewModel.tests.prefix(5), id: \.id) { test in
                            TestRowView(test: test)
                        }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
            }
            .padding()
        }
        .navigationTitle("IELTS")
        .onAppear {
            viewModel.loadData(persistenceService: persistenceService)
        }
        .sheet(isPresented: $showingAddTest) {
            AddIELTSTestView(viewModel: viewModel)
        }
        .sheet(isPresented: $showingFlashcards) {
            FlashcardListView(module: "IELTS")
        }
    }
}

struct SkillRow: View {
    let name: String
    let score: Double
    
    var body: some View {
        HStack {
            Text(name)
                .font(.subheadline)
            Spacer()
            Text(String(format: "%.1f", score))
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(scoreColor(score))
        }
    }
    
    private func scoreColor(_ score: Double) -> Color {
        if score >= 7.0 { return .green }
        if score >= 6.0 { return .orange }
        return .red
    }
}

struct TestRowView: View {
    let test: IELTSTest
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(test.date ?? Date(), style: .date)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text(String(format: "%.1f", averageScore))
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            
            HStack(spacing: 16) {
                Label(String(format: "%.1f", test.listening), systemImage: "ear")
                Label(String(format: "%.1f", test.reading), systemImage: "book")
                Label(String(format: "%.1f", test.writing), systemImage: "pencil")
                Label(String(format: "%.1f", test.speaking), systemImage: "mic")
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
    
    private var averageScore: Double {
        (test.listening + test.reading + test.writing + test.speaking) / 4.0
    }
}

#Preview {
    NavigationStack {
        IELTSView()
            .environmentObject(PersistenceService.shared)
    }
}

