//
//  EditTodoView.swift
//  TodoDemo
//
//  Created by 박세라 on 1/17/25.
//

import SwiftUI

struct EditTodoView: View {
    @Binding var todo: Todo
    @Binding var isPresented: Bool
    var onSave: (Todo) -> Void

    @State private var inputText: String = ""
    @State private var inputCategory: TodoCategory = .default
    @State private var inputDate: Date = Date()
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("할일 수정하기")
            HStack {
                Image(systemName: "pencil.circle")
                    .frame(width: 44, height: 44)
                TextField("할일", text: $inputText)
            }
            HStack {
                Image(systemName: "tag")
                    .frame(width: 44, height: 44)
                Picker("카테고리", selection: $inputCategory) {
                    ForEach(TodoCategory.allCases, id: \.self) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .pickerStyle(.menu)
            }
            HStack {
                Image(systemName: "calendar.circle")
                    .frame(width: 44, height: 44)
                DatePicker(
                    "날짜 입력",
                    selection: $inputDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.automatic)
            }
            Spacer()
            
            Button("Edit and Close") {
                let newItem = Todo()
                newItem.title = inputText
                newItem.category = inputCategory.rawValue
                newItem.date = inputDate
                onSave(newItem)
                isPresented = false
            }
        }
        .onAppear {
            // 기존 Todo 데이터 초기화
            inputText = todo.title
            inputCategory = TodoCategory.from(string: todo.category) ?? .default
            inputDate = todo.date
        }
        .padding()
    }
}
