//
//  ContentView.swift
//  TodoList
//
//  Created by 김용해 on 1/16/25.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var todoList: [Todo]
    @State private var schedule: String = ""
    @State private var schedule_is_empty: Bool = false
    
    var body: some View {
            NavigationStack {
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    VStack {
                        TextField(schedule_is_empty ? "일정을 넣어주셔야죠..😭" : "오늘은 뭐하지..🤔", text:$schedule)
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.black, lineWidth: 2)
                            }
                        HStack {
                            Spacer()
                            NavigationLink(destination: SearchTodo(todo: schedule)) {
                                Label("검색", systemImage: "magnifyingglass.circle")
                            }.tint(.black)
                                .font(.headline)
                                .fontWeight(.semibold)
                        }
                        List {
                            ForEach(todoList) { todo in
                                NavigationLink {
                                    DetailView(todo: todo) // 상세 페이지
                                } label: {
                                    HStack {
                                        Text(todo.message)
                                            .lineLimit(1)
                                        Spacer()
                                        Text(ScheduleCheck.allCase(input: todo.scheduleCheck) ? "완료" : "진행 중")
                                    }
                                    .frame(width: .infinity, height: 50)
                                    .padding()
                                }
                                .padding(.horizontal, 5)
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                                .background(.purple.opacity(0.3))
                            }
                            .onDelete(perform: deleteTodo)
                        }
                        .listStyle(PlainListStyle())
                        .scrollContentBackground(.hidden)
                        .navigationTitle("하루를 채우다")
                        .toolbar {
                            ToolbarItem {
                                Button(action: addTodo) {
                                        Label("Add", systemImage: "plus.circle")
                                            .font(.title)
                                }
                            }
                        }
                        .tint(.black)
                    }
                    .padding()
                }
            }
            .disabled(schedule_is_empty)
    }
    
    private func addTodo() {
        if schedule.isEmpty {
            return emptyTextChastisement()
        }
        
        withAnimation {
            /// 내가 생성할 data 필드이다
            let todo = Todo(message: schedule, timestamp: Date.now)
            modelContext.insert(todo)
        }
        
        // 입력한 필드를 지운다
        schedule = ""
    }

    private func deleteTodo(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(todoList[index])
            }
        }
    }
    
    /// 빈 공간을 놓고.. 추가할려는 당신을 응징하기 위한 함수입니다
    /// 3초간 아무 작업 하지 마세요
    private func emptyTextChastisement() {
        schedule_is_empty = true
            Task {
                try? await Task.sleep(nanoseconds: 3_000_000_000) // 5초 대기
                schedule_is_empty = false
            }
    }
    
    private func findTodo() {}
}

#Preview {
    ContentView()
        .modelContainer(for: Todo.self, inMemory: true)
}
