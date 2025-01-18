//
//  ContentView.swift
//  HappyOrder
//
//  Created by 박세라 on 1/18/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack { // (spacing: 0)
            // 메인 배너 뷰
            MainBannerView()
            // 탭바 뷰
            MainTabView()
        }
    }
}

#Preview {
    ContentView()
}
