//
//  Item.swift
//  TodoList
//
//  Created by 김용해 on 1/16/25.
//
import Foundation
import SwiftData

enum ScheduleCheck : Codable{
    case process
    case done
    
    static func allCase(input: ScheduleCheck) -> Bool {
        switch input {
        case .done:
            return true
        case .process:
            return false
        }
    }
}

@Model
final class Todo: Hashable {
    var message: String
    var scheduleCheck: ScheduleCheck
    var timestamp: Date
    
    
    init(message: String, timestamp: Date, scheduleCheck: ScheduleCheck = .process) {
        self.message = message
        self.timestamp = timestamp
        self.scheduleCheck = scheduleCheck
    }
}
