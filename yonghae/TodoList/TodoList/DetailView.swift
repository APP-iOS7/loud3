//
//  DetailView.swift
//  TodoList
//
//  Created by 김용해 on 1/17/25.
//

import SwiftUI
struct DetailView: View {
    @Bindable var todo: Todo
        
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                HStack {
                    Text(formatDate(todo.timestamp))
                    Spacer()
                }
                .padding()
                .font(.headline)
                HStack {
                    Spacer()
                    Toggle(isOn: Binding(
                        get: { todo.scheduleCheck == .done },
                        set: { newValue in
                            todo.scheduleCheck = newValue ? .done : .process
                        }
                    ), label: {
                        Text(ScheduleCheck.allCase(input: todo.scheduleCheck) ? "완료" : "진행 중")
                    })
                }
                .padding(10)
                HStack {
                    Spacer()
                    Text(todo.message)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .font(.subheadline)
            }
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: date)
    }
}

