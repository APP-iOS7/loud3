//
//  MainTabView.swift
//  HappyOrder
//
//  Created by 박세라 on 1/18/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        HStack(spacing: 0) {
            TabView(selected: true)
            TabView(selected: false)
            TabView(selected: false)
            /* for-each문 사용
                ForEach(1...3, id: \.self) { _ in
                    TabView(selected: Bool)
                }
            */
        }
    }
}

struct TabView: View {
    var selected: Bool = false
    
    var body: some View {
        //ZStack(alignment: .bottom) {
        VStack {
            Text("바로 배달")
                .font(.system(size: 20))
                .fontWeight(selected ? .medium : .regular)
                .frame(maxWidth: .infinity)
            Rectangle()
                .fill(selected ? Color(red: 21 / 255, green: 154 / 255, blue: 22 / 255) : Color(red: 243 / 255, green: 245 / 255, blue: 246 / 255)) // RGB 값 설정
                .frame(width: .infinity, height: selected ? 5 : 2)//21 254 22
        }
        .frame(width: .infinity, height: 56)
    }
}

#Preview {
    MainTabView()
}
