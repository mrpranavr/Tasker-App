//
//  TaskerApp.swift
//  Tasker
//
//  Created by Pranav R on 02/06/24.
//

import SwiftUI
import SwiftData

@main
struct TaskerApp: App {
    
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Task.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
}
