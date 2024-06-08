//
//  TasksView.swift
//  Tasker
//
//  Created by Pranav R on 08/06/24.
//

import SwiftUI
import SwiftData

struct TasksView: View {
    
    @Binding var date: Date
    
    // Swift Data Dynamic Query
    @Query private var tasks: [Task]
    init(date: Binding<Date>) {
        self._date = date
        
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: date.wrappedValue)
        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startOfDate)!
        let predicate = #Predicate<Task> {
            return $0.date > startOfDate && $0.date < endOfDate
        }
        
        let sortDescriptor = [
            SortDescriptor(\Task.date, order: .reverse)
        ]
        
        self._tasks = Query(filter: predicate,sort: sortDescriptor, animation: .snappy)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(tasks) {
                task in
                TaskItem(task: task)
                    .background(alignment: .leading, content: {
                        if tasks.last?.id != task.id {
                            Rectangle()
                                .foregroundStyle(.gray)
                                .clipShape(.rect(cornerRadius: 5))
                                .padding(.vertical, 12)
                                .frame(width: 2)
                                .offset(x: 24, y: 45)
                               
                        }
                    })
            }
        }
        .overlay {
            if tasks.isEmpty {
                Text("No Tasks added for the day!")
                    .font(.callout)
                    .frame(width: 250)
            }
        }
    }
}

#Preview {
    ContentView()
}
