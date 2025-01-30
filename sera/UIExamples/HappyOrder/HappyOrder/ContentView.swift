//
//  ContentView.swift
//  HappyOrder
//
//  Created by 박세라 on 1/18/25.
//

import SwiftUI

struct ContentView: View {
    init() {
            // UITabBar의 배경색을 변경
            UITabBar.appearance().backgroundColor = happyOrderGreenUiColor
        }
    
    var body: some View {
        TabView {
            TestView()
                .tabItem {
                    VStack(spacing: 4) {
                        Image("brand-Photoroom")
                            .resizable()
                            .scaledToFit()  // 비율에 맞게 이미지 크기 조정
                            .frame(width: 30, height: 30)  // 아이콘 크기 제한
                        Text("브랜드")
                            .font(.system(size: 14))
                    }
                    .frame(maxWidth: .infinity, maxHeight: 60)
                }
            
            TestView()
                .tabItem {
                    VStack {
                        Image("star")
                        Text("이벤트")
                    }
                }
            MainView()
                .tabItem {
                    Text("오")
                        .foregroundStyle(.white)
                        .font(.system(size: 50))
                }
            TestView()
                .tabItem {
                    VStack {
                        Image("order")
                        Text("주문내역")
                    }
                }
            TestView()
                .tabItem {
                    VStack {
                        Image("myprofile")
                        Text("마이")
                    }
                }
            

        }
        .tint(happyOrderGreenTextColor)
    }
}

#Preview {
    ContentView()
}
