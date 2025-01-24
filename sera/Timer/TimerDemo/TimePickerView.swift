//
//  TimePickerView.swift
//  TimerDemo
//
//  Created by 박세라 on 1/24/25.
//

import SwiftUI

// 타이머 시간 설정 화면
struct TimePickerView: View {
    @Binding var selectedTime: Date
    var onTimeSelected: (Int) -> Void // 선택한 시간 전달
    
    // 분과 초 배열 생성
    let seconds = Array(0..<60) // 00~59
    let minutes = Array(0..<60) // 00~59
    
    var body: some View {
        VStack {
            Text("시간설정")
                .font(.title)
                .padding()
            
            HStack {
                // 시간 선택 Picker
                Picker("Minute", selection: Binding(
                    get: {
                        Calendar.current.component(.minute, from: selectedTime)
                    },
                    set: { newValue in
                        var components = Calendar.current.dateComponents([.minute, .second], from: selectedTime)
                        components.minute = newValue
                        selectedTime = Calendar.current.date(from: components) ?? Date()
                    }
                )) {
                    ForEach(minutes, id: \.self) { minute in
                        Text(String(format: "%02d", minute))
                    }
                }
                .pickerStyle(.automatic)
                .frame(width: 100)
                
                Text(":")
                    .font(.title)
                
                // 초 선택 Picker
                Picker("Second", selection: Binding(
                    get: {
                        Calendar.current.component(.second, from: selectedTime)
                    },
                    set: { newValue in
                        var components = Calendar.current.dateComponents([.minute, .second], from: selectedTime)
                        components.second = newValue
                        selectedTime = Calendar.current.date(from: components) ?? Date()
                    }
                )) {
                    ForEach(seconds, id: \.self) { second in
                        Text(String(format: "%02d", second))
                    }
                }
                .pickerStyle(.automatic)
                .frame(width: 100)
            }
            .padding()
            
            Button("설정") {
                let calendar = Calendar.current
                let components = calendar.dateComponents([.minute, .second], from: selectedTime)
                print("selectedTime:\(selectedTime), minute:\((components.minute ?? 0)), seconds:\((components.second ?? 0))")
                
                let totalMinutes = (components.minute ?? 0) * 60 + (components.second ?? 0)
                onTimeSelected(totalMinutes)
            }
            .padding()
        }
    }
}

#Preview {
    TimePickerView(
        selectedTime: .constant(Date()), // 현재 시간을 기본값으로 설정
        onTimeSelected: { selectedMinutes in
            print("Selected time in minutes: \(selectedMinutes)") // 더미 동작
        }
    )
}
