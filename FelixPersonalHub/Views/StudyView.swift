//
//  StudyView.swift
//  FelixPersonalHub
//
//  Created on 2024
//

import SwiftUI

struct StudyView: View {
    @State private var selectedModule: StudyModule = .ielts
    
    enum StudyModule {
        case ielts, hsk
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Module", selection: $selectedModule) {
                    Text("IELTS").tag(StudyModule.ielts)
                    Text("HSK").tag(StudyModule.hsk)
                }
                .pickerStyle(.segmented)
                .padding()
                
                if selectedModule == .ielts {
                    IELTSView()
                } else {
                    HSKView()
                }
            }
            .navigationTitle("Study")
        }
    }
}

#Preview {
    StudyView()
        .environmentObject(PersistenceService.shared)
        .environment(\.managedObjectContext, PersistenceService.shared.container.viewContext)
}

