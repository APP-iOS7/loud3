//
//  TodoListView.swift
//  TodoDemo
//
//  Created by 박세라 on 1/16/25.
//

import SwiftUI

struct TodoListView: View {
    @State var todo: Todo
    @State private var isEditModalPresented = false // 모달 표시 여부 상태
    
    var onDelete: () -> Void        // 삭제 동작을 처리하는 클로저
    var onUpdate: (Todo) -> Void    // 수정 동작을 처리하는 클로저
    var onUpdateCheck: () -> Void   // 체크박스 동작을 처리하는 클로저
    
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 5, height: 44)
                .foregroundColor(TodoCategory.from(string: todo.category)?.color)
            
            Image(systemName: todo.isChecked ? "checkmark.square" : "square") // squre
                .frame(width: 24, height: 24)
                .padding([.trailing])
                .onTapGesture {
                    onUpdateCheck()
                }
            
            if todo.isChecked {
                Text(todo.title)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .truncationMode(.tail)
                    .strikethrough(color: .black)
            } else {
                Text(todo.title)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .truncationMode(.tail)
            }
            
            
            Spacer()
            /*
            Text("삭제")
                .foregroundColor(.white)
                .font(.system(size: 12))
                .fontWeight(.bold)
                .onTapGesture {
                    onDelete()
                }
            .frame(width: 36, height: 20)
            .background(.red)
            .clipShape(.rect(cornerRadius: 10))
             */
            Image(systemName: "arrow.up.forward.app")
                .onTapGesture {
                    isEditModalPresented = true // 모달 표시
                }
                .sheet(isPresented: $isEditModalPresented) {
                    EditTodoView(todo: $todo, isPresented: $isEditModalPresented, onSave: { todo in
                        onUpdate(todo)
                    })
                }
            
        }
    }
}
