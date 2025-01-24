//
//  TimerDemoApp.swift
//  TimerDemo
//
//  Created by 김용해 on 1/24/25.
//

import SwiftUI

@main
struct TimerDemoApp: App {
    var body: some Scene {
        MenuBarExtra("Timer", systemImage: "fitness.timer") {
            ContentView()
        }
        .menuBarExtraStyle(.window)
        .keyboardShortcut("m",modifiers: .command, localization: .automatic)
    }
}
