//
//  MainView.swift
//  HappyOrder
//
//  Created by 박세라 on 1/30/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        //ScrollView {
            VStack { // (spacing: 0)
                // 메인 배너 뷰
                MainBannerView()
                // 탭바 뷰
                MainTabView()
                // 메인 메뉴카테고리 뷰
                MainCategoryView()
                // 브랜드 뷰
                MainBrandView()
                    .padding(8)
            }
        //}
    }
}

#Preview {
    MainView()
}
