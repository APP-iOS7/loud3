//
//  AddTodoView.swift
//  TodoDemo
//
//  Created by 박세라 on 1/16/25.
//

import SwiftUI

enum TodoCategory: String, CaseIterable {
    case `default` = "기본"
    case study = "학습"
    case shopping = "쇼핑"
    case health = "건강"
    case business = "업무"
    case holiday = "휴일"
    
    // 각 카테고리에 맞는 색상 반환
    var color: Color {
        switch self {
        case .default:
            return Color.purple // 기본: 보라색
        case .study:
            return Color.blue   // 학습: 파란색
        case .shopping:
            return Color.pink   // 쇼핑: 핑크색
        case .health:
            return Color.green  // 건강: 초록색
        case .business:
            return Color.gray   // 업무: 회색
        case .holiday:
            return Color.brown  // 휴일: 갈색
        }
    }
    
    // String 값을 받아서 TodoCategory로 변환
    static func from(string: String) -> TodoCategory? {
        return TodoCategory(rawValue: string)
    }
    
}

struct AddTodoView: View {
    @Binding var isPresented: Bool
    var onSave: (Todo) -> Void

    @State private var inputText: String = ""
    @State private var inputCategory: TodoCategory = .default
    @State private var inputDate: Date = Date()
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("할일 추가하기")
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
            
            Button("Save and Close") {
                let newItem = Todo()
                newItem.title = inputText
                newItem.category = inputCategory.rawValue
                newItem.date = inputDate
                onSave(newItem)
                isPresented = false
            }
        }.padding()
        
    }
}
/*
 #Preview {
 AddTodoView(todo: Todo(title: "Hello World"), isPresented: , onSave: {} todo: )
 }
 */
