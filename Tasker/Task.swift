//
//  Task.swift
//  Tasker
//
//  Created by Pranav R on 02/06/24.
//

import SwiftUI
import SwiftData

@Model
class Task: Identifiable {
    var id: UUID
    var title: String
    var caption: String
    var date: Date
    var isComplete: Bool
    var tint: String
    
    init(id: UUID =  UUID(), title: String, caption: String, date: Date = .init(), isComplete: Bool = false, tint: String) {
        self.id = id
        self.title = title
        self.caption = caption
        self.date = date
        self.isComplete = isComplete
        self.tint = tint
    }
    
    var tintColor: Color {
        switch tint {
        case "taskColor 1": return .taskColor1
        case "taskColor 2": return .taskColor2
        case "taskColor 3": return .taskColor3
        case "taskColor 4": return .taskColor4
        case "taskColor 5": return .taskColor5
        case "taskColor 6": return .taskColor6
        case "taskColor 7": return .taskColor7
        default: return  .black
        }
    }
}

// Sample Task
//var sampleTask: [Task] = [
//    .init(title: "Standup", caption: "Everyday meeting", date: Date.now, tint: .yellow),
//    .init(title: "KickOff", caption: "New Task 2", date: Date.now, tint: .gray),
//    .init(title: "Task 3", caption: "New Task 3", date: Date.now, tint: .green),
//    .init(title: "Task 4", caption: "New Task 4", date: Date.now, tint: .purple),
//    .init(title: "Task 5", caption: "New Task 5", date: Date.now, tint: .yellow),
//]

// Date Extension
extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
