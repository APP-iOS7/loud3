//
//  SearchTodo.swift
//  TodoList
//
//  Created by 김용해 on 1/17/25.
//

import SwiftUI
import SwiftData

struct SearchTodo: View {
    var todo: String
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var matches: [Todo] = []
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            VStack {
                if !matches.isEmpty {
                    List {
                        ForEach(matches) { todo in
                            HStack {
                                Text(todo.message)
                                Spacer()
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .navigationTitle("검색 결과")
                }else {
                    Text("검색 결과가 없습니다🥲")
                        .font(.largeTitle)
                }
            }
            .task {
                let descriptor = FetchDescriptor<Todo>(
                    predicate: #Predicate<Todo> { $0.message == todo}
                )
                
                do {
                    matches = try modelContext.fetch(descriptor)
                } catch {
                    print("Error fetching Todo: \(error)")
                    matches = []
                }
            }
        }
    }
}

#Preview {
    SearchTodo(todo: "searchTodo")
        .modelContainer(for: Todo.self, inMemory: true)
}
