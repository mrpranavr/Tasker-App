//
//  Task.swift
//  Tasker
//
//  Created by Pranav R on 02/06/24.
//

import SwiftUI

struct Task: Identifiable {
    var id: UUID = .init()
    var title: String
    var caption: String
    var date: Date = .init()
    var isComplete = false
    var tint: Color
}

// Sample Task
var sampleTask: [Task] = [
    .init(title: "Standup", caption: "Everyday meeting", date: Date.now, tint: .yellow),
    .init(title: "KickOff", caption: "New Task 2", date: Date.now, tint: .gray),
    .init(title: "Task 3", caption: "New Task 3", date: Date.now, tint: .green),
    .init(title: "Task 4", caption: "New Task 4", date: Date.now, tint: .purple),
    .init(title: "Task 5", caption: "New Task 5", date: Date.now, tint: .yellow),
]

// Date Extension
extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
