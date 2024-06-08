//
//  ContentView.swift
//  Tasker
//
//  Created by Pranav R on 02/06/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentDate: Date = .init()
    var todaysDate: Date = .init()
    
    
    // WeekSlider
    @State var weekSlider: [[Date.WeekDay]] = []
    @State var currentWeekIndex: Int = 1
    @State private var createWeek: Bool = false
    
    //Animation namespace
    @Namespace private var animation
    
    // SwiftData part to update
    //@State private var tasks : [Task] = sampleTask.sorted(by: {$1.date > $0.date })
    
    // Create Task Layout
    @State private var createNewTask: Bool = false
    
    var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading) {
                    Text("Calendar")
                        .font(.system(size: 36, weight: .semibold))
                    
                    // Week Slider
                    TabView(selection: $currentWeekIndex,
                            content:  {
                        ForEach(weekSlider.indices, id: \.self) {index in
                            let week = weekSlider[index]
                            
                            weekView(week)
                                .tag(index)
                        }
                    })
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 110)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background {
                   
                    Rectangle().fill(.gray.opacity(0.1))
                        .clipShape(.rect(bottomLeadingRadius: 30, bottomTrailingRadius: 30))
                        .ignoresSafeArea()
                    
                }
                .onChange(of: currentWeekIndex, initial: false) { oldValue, newValue in
                    if newValue == 0 || newValue == (weekSlider.count - 1 ) {
                        createWeek = true
                    }
                }
                
                ScrollView(.vertical) {
                    VStack {
                        // Task View
                        TasksView(date: $currentDate )
                    }
                    .padding(.top, 30)
                    .hSpacing(.center)
                    .vSpacing(.center)
                }
            }
            .vSpacing(.top)
            .frame(maxWidth: .infinity)
            .onAppear() {
                if weekSlider.isEmpty {
                    let currentWeek = Date().fetchWeek()
                    
                    if let firstDate = currentWeek.first?.date {
                        weekSlider.append(firstDate.createPreviousWeek())
                    }
                    
                    weekSlider.append(currentWeek)
                    
                    if let lastDate = currentWeek.last?.date {
                        weekSlider.append(lastDate.createNextWeek())
                    }
                }
        }
            .overlay(alignment: .bottomTrailing, content: {
                // Create New Task Button
                Button(action: {
                    createNewTask.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .padding(26)
                        .background(.black)
                        .clipShape(Circle())
                        .padding(.horizontal)
                        .foregroundStyle(.white)
                })
                .fullScreenCover(isPresented: $createNewTask, content: {
                    NewTask()
                })
            })
    }
    
    @ViewBuilder
    func weekView(_ week: [Date.WeekDay]) -> some View {
        HStack(spacing: 0, content: {
            ForEach(week) { day in
                VStack {
                    Text(day.date.format("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                    
                    Text(day.date.format("dd"))
                        .font(.system(size: 20))
                        .frame(width: 50, height: 55)
                        .foregroundStyle(
                            isSameDate(day.date, currentDate) ? .white : .black
                        )
                        .background {
                            if isSameDate(day.date, currentDate) {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.black)
                                    .offset(y: 3)
                                    .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
                            }
                            
                            if day.date.isToday {
                                Circle()
                                    .fill(currentDate.format("dd-MM-yyyy") == todaysDate.format("dd-MM-yyyy") ? .white : .black)
                                    .frame(width: 6, height: 5)
                                    .vSpacing(.bottom)
                            }
                        }
                }
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    withAnimation(.snappy) {
                        currentDate = day.date
                    }
                }
            }
        })
        .background {
            GeometryReader {
                let minX = $0.frame(in: .global).minX
                
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self, perform: { value in
                        if value.rounded() == 16 && createWeek {
                            paginateWeek()
                            createWeek = false
                        }
                    })
            }
        }
    }
    
    func paginateWeek() {
        if weekSlider.indices.contains(currentWeekIndex) {
            if let firstDate = weekSlider[currentWeekIndex].first?.date, currentWeekIndex == 0 {
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
            }
            
            if let lastDate = weekSlider[currentWeekIndex].last?.date, currentWeekIndex == (weekSlider.count - 1) {
                weekSlider.append(lastDate.createNextWeek())
                weekSlider.removeFirst()
                currentWeekIndex = weekSlider.count - 2
            }
        }
    }
    
}

#Preview {
    ContentView()
}
