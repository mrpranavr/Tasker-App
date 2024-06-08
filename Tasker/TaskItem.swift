//
//  TaskItem.swift
//  Tasker
//
//  Created by Pranav R on 03/06/24.
//

import SwiftUI

struct TaskItem: View {
    
    @Bindable var task: Task
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            Circle()
                .fill(indicatorColor)
                .frame(width: 10, height: 10)
                .padding(4)
                .background(.white.shadow(.drop(color: .black.opacity(0.1), radius: 3)), in: .circle)
                .overlay {
                    Circle()
                        .frame(width: 50, height: 50)
                        .blendMode(.destinationOver)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                task.isComplete.toggle()
                            }
                        }
                }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack() {
                    Text(task.title)
                        .font(.system(size: 20, weight: .semibold))
                    
                    Spacer()
                    
                    Label(
                        "\(task.date.format("hh:mm a"))",
                        systemImage: "clock"
                    )
                    .font(.callout)
                }
                .hSpacing(.leading)
                
                Text(task.caption)
                    .font(.callout)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(task.tintColor.opacity(0.2))
            .clipShape(.rect(cornerRadius: 20))
            
        }
        .padding(.horizontal)
    }
    
    var indicatorColor: Color {
        if task.isComplete {
            return .green
        }
        
        return task.date.isSameTime ? .indigo : (task.date.isPast ? .red : .black)
    }
}

#Preview {
    ContentView()
}
