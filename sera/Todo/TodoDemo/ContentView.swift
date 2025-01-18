//
//  ContentView.swift
//  TodoDemo
//
//  Created by 박세라 on 1/16/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var todoItem: Todo = Todo()
    
    @Environment(\.modelContext) private var modelContext
    @State private var matches: [Todo] = []
    
    @Query private var todos: [Todo] = []
    
    @State private var searchText: String = "" // 검색어 상태
    
    @State private var isModalPresented = false
    @State private var showActionSheet = false
    @State private var selectedTodo: Todo? = nil // 선택된 Todo 항목을 저장
    
    var filteredTodos: [Todo] {
        if searchText.isEmpty {
            return todos
        } else {
            return todos.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        
        VStack {
            VStack {
                if todos.isEmpty {
                    if filteredTodos.isEmpty {
                        // todos가 비어 있을 때 표시할 뷰
                        VStack(alignment: .center) {
                            Text("할일이 없습니다.\n추가하기버튼으로 할일을 추가해보세요!")
                                .multilineTextAlignment(.center)
                                .font(.title2)
                                .background(.yellow)
                            
                            Button(action: {
                                isModalPresented = true
                            }) {
                                Text("할일 추가하기")
                                    .font(.system(size: 16))
                                    .fontWeight(.bold)
                            }
                            .sheet(isPresented: $isModalPresented) {
                                AddTodoView(isPresented: $isModalPresented, onSave: { receivedData in
                                    print(receivedData)
                                    todoItem.title = receivedData.title
                                    todoItem.category = receivedData.category
                                    todoItem.date = receivedData.date
                                    addTodo(todoItem)
                                })
                            }
                        }
                    } else {
                        // todos가 비어 있지 않을 때 표시할 List 뷰
                        List {
                            ForEach(todos, id: \.self) { todo in
                                ZStack(alignment: .leading) {
                                    TodoListView(todo: todo, onDelete: {
                                        // deleteTodo(todo: todo)
                                    }, onUpdate: { newTodo in
                                        updateTodo(todo: todo, newItem: newTodo)
                                    }, onUpdateCheck: {
                                        updateCheck(todo: todo)
                                    })
                                }
                            }
                            .onDelete(perform: deleteTodo) // onDelete 메서드를 ForEach에 연결
                        }
                    }
                } else {
                    // 검색 바
                    TextField("Search Todos", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    List {
                        ForEach(filteredTodos, id: \.self) { todo in
                            TodoListView(todo: todo, onDelete: {
                                //deleteTodo(todo: todo)
                            }, onUpdate: { newTodo in
                                updateTodo(todo: todo, newItem: newTodo)
                            }, onUpdateCheck: {
                                updateCheck(todo: todo)
                            })
                        }
                        .onDelete(perform: deleteTodo)
                    }
                    
                    // 추가 버튼
                    Button(action: {
                        isModalPresented = true
                    }) {
                        Text("일정 추가하기")
                            .padding()
                    }.sheet(isPresented: $isModalPresented) {
                        AddTodoView(isPresented: $isModalPresented, onSave: { receivedData in
                            todoItem.title = receivedData.title
                            todoItem.category = receivedData.category
                            todoItem.date = receivedData.date
                            addTodo(todoItem)
                        })
                    }
                }
            }
        }
    }
    
    private func addTodo(_ todo: Todo) {
        withAnimation {
            let newTodo = Todo()
            newTodo.title = todo.title
            newTodo.date = todo.date
            newTodo.category = todo.category
            modelContext.insert(newTodo)
            
            do {
                try modelContext.save()
            } catch {
                print("❌ Error: \(error)")
            }
        }
    }
    
    private func updateTodo(todo: Todo, newItem: Todo) {
        print("todo:\(todo.category)")
        
        if let index = todos.firstIndex(of: todo) {
            // 업데이트 할 Todo 데이터
            let todoItem = todos[index]
            
            // 업데이트
            todoItem.title = newItem.title
            todoItem.category = newItem.category
            todoItem.date = newItem.date
            
            print("todoItem:\(todoItem.category)")
            
            do {
                try modelContext.save() // 변경 사항을 저장
            } catch {
                print("❌ Error: \(error)")
            }
        }
    }
    
    
    private func updateCheck(todo: Todo) {
        withAnimation {
            todo.isChecked.toggle()
            do {
                try modelContext.save() // 변경 사항을 저장
            } catch {
                print("❌ Error: \(error)")
            }
        }
    }

    /*
    private func deleteTodo(todo: Todo) {
        withAnimation {
            if let index = todos.firstIndex(of: todo) {
                modelContext.delete(todos[index])
                do {
                    try modelContext.save()
                } catch {
                    print("❌ Error: \(error)")
                }
            }
        }
    }
     */
    
    private func deleteTodo(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let todo = todos[index]
                modelContext.delete(todo)
            }
            do {
                try modelContext.save()
            } catch {
                print("❌ Error: \(error)")
            }
        }
    }

}
/*
 
 // 추가 버튼
 Button(action: {
     isModalPresented = true
 }) {
     Spacer()
     Image(systemName: "plus.square.on.square")
         .frame(width: 80, height: 44)
         .foregroundColor(.black)
         .padding()
     
 }.sheet(isPresented: $isModalPresented) {
     AddTodoView(isPresented: $isModalPresented, onSave: { receivedData in
         todoItem.title = receivedData.title
         todoItem.category = receivedData.category
         todoItem.date = receivedData.date
         addTodo(todoItem)
     })
 }
 
 
 */
