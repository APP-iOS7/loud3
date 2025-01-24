//
//  ContentView.swift
//  TimerDemo
//
//  Created by 김용해 on 1/24/25.
//

import SwiftUI

struct ContentView: View {
    @State private var timeReminding: Int = 0 // 시간 설정
    @State private var maxTime: Int = 0 // 최대 시간
    @State private var isStart: Bool = false // 시작 여부
    @State private var selectedColor: Color = .red
    // Double(현재시간) / Double(최대시간)
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack {
            ZStack {
                customExit
                
                customColorPicker
                
                customProgressView
                
                timerCategory
                
                timeCheckView
                
                timerActionButtons
            }
            .padding()
        }
        .padding()
        .onReceive(timer) { _ in
            if isStart {
                if timeReminding > 0 {
                    timeReminding -= 1
                }
            }
        }
    }
    
    // 종료 버튼 View
    private var customExit: some View {
        Image(systemName: "power")
        .offset(x: 130, y: -130)
        .onTapGesture {
            // 프로그램 종료
            NSApplication.shared.terminate(nil)
        }
    }
    
    // ColorPicker
    private var customColorPicker: some View {
        ColorPicker("", selection: $selectedColor)
            .offset(x: -120, y: -130)
    }
    
    // 커스텀 ProgressView
    private var customProgressView: some View {
        ProgressView(
            value: Double(1.0 - Double(timeReminding) / Double(maxTime))) // 0.0 ~ 1.0
        .progressViewStyle(CustomCircularProgressViewStyle(selectedColor: $selectedColor))
    }
    
    // 타이머 1분 , 5분, 10 분 빨리 감기
    private var timerCategory: some View {
        HStack {
            Button("+1분"){
                NSSound.beep()
                timeReminding += 60
                maxTime += 60
            }
            .disabled(isStart)
            Button("+5분") {
                NSSound.beep()
                timeReminding += 300
                maxTime += 300
            }
            .disabled(isStart)
            Button("+10분") {
                NSSound.beep()
                timeReminding += 600
                maxTime += 600
            }
            .disabled(isStart)
        }
        .offset(y: -50)
    }
    
    // 시간을 보여주는 View
    private var timeCheckView : some View {
        Text(timeFormat(time: timeReminding))
            .font(.largeTitle)
        .padding()
    }
    
    // 시작 버튼 , 초기화 버튼
    private var timerActionButtons: some View {
        HStack {
            Image(systemName: isStart ?  "stop.fill" : "play.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .padding()
                .onTapGesture {
                    NSSound.beep()
                    isStart.toggle()
                }
                .disabled(timeReminding == 0)
                
            Image(systemName: "arrow.clockwise.circle")
                .resizable()
                .frame(width: 20, height: 20)
                .padding()
                .onTapGesture {
                    NSSound.beep()
                    timeReminding = 0
                    maxTime = 0
                    isStart = false
                }
        }
        .offset(y: 50)
    }
    
    
    // 시 * 분 * 초를 다 계산해서 형식에 맞추는 함수
    private func timeFormat(time second: Int) -> String {
        let secondOfTime = String(format: "%02d",second % 60)
        let minuteOfTime = String(format: "%02d",(second % 3600) / 60)
        let hourOfTime = String(format: "%02d",second / 3600)
        
        return "\(hourOfTime) : \(minuteOfTime) : \(secondOfTime)"
    }
    
}




struct CustomCircularProgressViewStyle: ProgressViewStyle {
    @Binding var selectedColor: Color
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 15)
                .foregroundColor(.gray.opacity(0.3)) // 배경 원

            Circle()
                .trim(from: 0.0, to: CGFloat(configuration.fractionCompleted ?? 0.0))
                .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round))
                .foregroundColor(selectedColor)
                .rotationEffect(.degrees(-90)) // 시작점 조정
        }
        .frame(width: 250, height: 250) // 크기 조정
    }
}

#Preview {
    ContentView()
}
