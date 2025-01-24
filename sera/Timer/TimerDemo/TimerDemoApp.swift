//
//  TimerDemoApp.swift
//  TimerDemo
//
//  Created by 박세라 on 1/24/25.
//

import SwiftUI

@main
struct TimerDemoApp: App {
    var body: some Scene {
        MenuBarExtra("Tomato Timer", systemImage: "fitness.timer") {
            ContentView()
            /*
                .onAppear {
                    makeWindowAlwaysOnTop()
                }
             */
        }
        .menuBarExtraStyle(.window)
        .keyboardShortcut("m", modifiers: .command, localization: .automatic)
        
    }
    
    func makeWindowAlwaysOnTop() {
        // 현재 활성화된 윈도우 가져오기
        if let window = NSApplication.shared.windows.first {
            window.level = .floating // 창을 "Always on Top"으로 설정
        }
    }
}
