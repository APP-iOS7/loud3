//
//  FinishedView.swift
//  TimerDemo
//
//  Created by 박세라 on 1/24/25.
//

import SwiftUI

// 종료화면
struct FinishedView: View {
    var closeAction: () -> Void // 완료화면 닫는 closure
    
    var body: some View {
        ZStack {
            Image("ketchup-splash")
                .resizable()
                .frame(width: 340, height: 300)
            VStack {
                Text("끝!")
                    .foregroundStyle(Color("BackgroundColor"))
                    .font(.system(size: 72))
                    .fontWeight(.bold)
                Button(action: closeAction) {
                    Image(systemName: "xmark")
                        .frame(width: 24, height: 24)
                        .background(.clear)
                }
            }
        }
    }
}

#Preview {
    FinishedView(closeAction: {})
}
