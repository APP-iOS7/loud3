//
//  ContentView.swift
//  TimerDemo
//
//  Created by 박세라 on 1/24/25.
//

import SwiftUI
import AVFoundation
import AVFAudio

struct ContentView: View {
    
    @State private var timeRemaining: Int = 60      // 초단위
    @State private var totalTime: Int = 60          // 설정한 전체 시간
    @State private var isRunning: Bool = false      // 타이머 작동중 확인 변수
    @State private var isShowingPicker: Bool = false // 시간 설정화면 표시 여부
    @State private var isImageOne: Bool = true      // 토마토 애니메이션을 위한 상태 변수
    @State private var isSoundOn: Bool = true         // 알람 소리 on/off 여부
    @State private var isTimeOverView: Bool = false // 시간 종료 뷰 표시 여부
    
    @State private var audioPlayer: AVAudioPlayer?  // 알림 울릴 Player 객체
    @State private var animationTimer: Timer? = nil // 애니메이션을 실행할 Timer 객체
    
    @State private var selectedTime: Date = Date()  // 사용자가 선택한 시간
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // 레알 타이머
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            
            // 토마토 사진 배경
            Image(isImageOne ? "icon-tomato-volume" : "icon-tomato-volume 2")
            
            VStack {
                // 초시간
                Text("\(String(format: "%02d", timeRemaining / 60)) : \(String(format: "%02d", timeRemaining % 60))")
                    .font(.system(size: 72))
                    .foregroundStyle(Color("BackgroundColor"))
                    .fontWeight(.bold)
                    .padding(.top, 80)
                
                // ProgressView에 timeRemaining 기반 값 전달
                ProgressView(value: Double(totalTime - timeRemaining), total: Double(totalTime))
                    .progressViewStyle(LinearWithImageProgressStyle())
                    .frame(height: 20)
                
                // 버튼s Stack
                HStack {
                    Button("Set Timer") {
                        isShowingPicker = true
                    }
                    
                    Button(action:{
                        isRunning.toggle()
                    }) {
                        Image(systemName: isRunning ? "pause.fill" : "play.fill")
                    }
                    
                    Button("RESET") {
                        timeRemaining = 60
                    }
                    
                    Toggle(isOn: $isSoundOn, label: {
                        Image(systemName: "speaker.fill")
                    })
                    .toggleStyle(.switch)
                    .tint(Color("ToggleTintColor"))
                }
            }
            .padding([.leading, .trailing], 80)
        }
        .sheet(isPresented: $isShowingPicker) { // 타이머 시간 설정 화면 show
            TimePickerView(selectedTime: $selectedTime) { totalSeconds in
                totalTime = totalSeconds
                timeRemaining = totalTime
                isShowingPicker = false
            }
        }
        .sheet(isPresented: $isTimeOverView) {  // 타임오버 뷰 show
            FinishedView(closeAction: {
                isTimeOverView = false
            })
        }
        .onAppear() {
            // 키보드 단축기 설정
            addKeyboardShortcuts()
        }
        .onReceive(timer) { tick in
            if isRunning && timeRemaining > 0 { // timer Start
                if timeRemaining <= 5 {
                    startAnimation()
                }
                timeRemaining -= 1
            } else if timeRemaining == 0 {      // timer Stop
                stopTimer()
                stopAnimation()
                if isSoundOn {
                    playSound()
                }
                isTimeOverView = true // FIXME: 버그 수정
            } else {
                // ignore
            }
        }
    }
    
    
    private func playSound() {
        guard let url = Bundle.main.url(forResource: "bebebep", withExtension: "mp3") else {
            print("Audio file not found.")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            
            //43초 뒤에 사운드 멈추기
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.audioPlayer?.stop()
                self.audioPlayer = nil // 메모리 정리
            }
        } catch {
            print("Failed to initialize audio player: \(error.localizedDescription)")
        }
    }
    
    private func addKeyboardShortcuts() {
        // macOS에서만 작동 >> 컴파일 이전에 실행
        #if os(macOS)
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            if event.modifierFlags.contains(.command) && event.characters == "s" {
                stopTimer()
                return nil
            }
            return event
        }
        #endif
    }
    
    private func runTimer() {
        isRunning = true
    }
    
    private func stopTimer() {
        isRunning = false
    }
    
    func startAnimation() {
        // 타이머가 이미 실행 중이면 다시 시작하지 않도록 방지
        if animationTimer == nil {
            animationTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                withAnimation {
                    isImageOne.toggle() // 0.1초마다 이미지 상태 변경
                }
            }
        }
    }
    
    func stopAnimation() {
        animationTimer?.invalidate() // 타이머 정지
        animationTimer = nil
        isImageOne = true
    }
}


private struct LinearWithImageProgressStyle: ProgressViewStyle {
    var tintColor: Color = .brown
    var backgroundColor: Color = Color("BackgroundColor").opacity(0.7)

    var markerImage: some View = Image("icon-carterpillar")
        .resizable()
        .frame(width: 24, height: 24)
    var goalImage: some View = Image(systemName: "flag.checkered")
        .foregroundColor(Color("BackgroundColor"))

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(backgroundColor)
                    .frame(height: geometry.size.height/2)
                    .overlay(alignment: .trailing, content: {
                        GeometryReader { imageGeo in
                            let frame = imageGeo.frame(in: .local)
                            goalImage
                                .position(CGPoint(x: frame.maxX, y: frame.midY))
                        }
                        .offset(y: -geometry.size.height/2)
                        .padding(.bottom, 8)

                    })

                Capsule()
                    .fill(tintColor)
                    .frame(width: fractionCompleted * geometry.size.width, height: geometry.size.height/2)
                    .overlay(alignment: .trailing, content: {
                        if fractionCompleted < 1 {
                            GeometryReader { imageGeo in
                                let frame = imageGeo.frame(in: .local)
                                markerImage
                                    .position(CGPoint(x: frame.maxX, y: frame.midY))
                            }
                            .offset(y: -geometry.size.height/2)
                            .padding(.bottom, 8)
                        }
                    })

            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

#Preview {
    ContentView()
}
