//
//  Todo.swift
//  TodoDemo
//
//  Created by 박세라 on 1/16/25.
//

import Foundation
import SwiftData

@Model
final class Todo {
    let uuid: UUID = UUID()
    var title: String
    var isChecked: Bool
    var category: String
    var date: Date
    
    init(title: String = "할일을 입력하세요.", isChecked: Bool = false, category: String = TodoCategory.study.rawValue, date: Date = Date()) {
        self.title = title
        self.isChecked = isChecked
        self.category = category
        self.date = date // date 선택 안할 시 추가된 날짜 입력.
    }
}
