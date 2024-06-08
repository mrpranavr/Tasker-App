//
//  NewTask.swift
//  Tasker
//
//  Created by Pranav R on 03/06/24.
//

import SwiftUI
import SwiftData

struct NewTask: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var taskTitle: String = ""
    @State private var taskCaption: String = ""
    @State private var taskDate: Date = .init()
    @State private var taskColor: String = "taskColor 1"
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Label("Add New Task", systemImage: "arrow.left")
                    .onTapGesture {
                        dismiss()
                    }
            }
            .hSpacing(.leading)
            .padding(30)
            .frame(maxWidth: .infinity)
            .background {
                Rectangle()
                    .fill(.gray.opacity(0.1))
                    .clipShape(.rect(bottomLeadingRadius: 30, bottomTrailingRadius: 30))
                    .ignoresSafeArea()
            }
            
            // Task Details
            VStack(alignment: .leading, spacing: 30) {
                VStack(spacing: 20) {
                    TextField("Your Task Title", text: $taskTitle)
                    Divider()
                }
                
                VStack(spacing: 20) {
                    TextField("Your Task Caption", text: $taskCaption)
                    Divider()
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Timeline")
                        .font(.title3)
                    
                    DatePicker("", selection: $taskDate)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                }
                VStack(alignment: .leading, spacing: 20) {
                    Text("Task Color")
                        .font(.title3)
                    
                    let colors: [String] = (1...7).compactMap { color in
                        return "taskColor \(color)"
                    }
                    
                   // let colors: [Color] = [.yellow, .gray, .green, .blue, .indigo, .red]
                    
                    HStack(spacing: 10) {
                        ForEach(colors, id: \.self) {color in
                            Circle()
                                .fill(Color(color).opacity(0.4))
                                .background {
                                    Circle()
                                        .stroke(lineWidth: 3)
                                        .foregroundStyle(.black)
                                        .opacity(taskColor == color ? 1 : 0)
                                }
                                .hSpacing(.center)
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        taskColor = color
                                    }
                                }
                        }
                    }
                }
            }
            .padding(30)
            .vSpacing(.top)
            
            Button(action: {
                // Creating new task
                let task = Task(title: taskTitle, caption: taskCaption, date: taskDate, tint: taskColor)
                do {
                    print(task)
                    context.insert(task)
                    try context.save()
                    
                    dismiss()
                } catch {
                    print(error.localizedDescription)
                }
                
            }, label: {
                Text("Create Task")
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.black)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 20))
                    .padding(.horizontal, 30)
            })
        }
        .vSpacing(.top)
        
    }
}

#Preview {
    NewTask()
}
