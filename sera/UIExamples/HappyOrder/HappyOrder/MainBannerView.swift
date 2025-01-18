//
//  MainBannerView.swift
//  HappyOrder
//
//  Created by 박세라 on 1/18/25.
//

import SwiftUI

struct MainBannerView: View {
    var body: some View {
        ZStack(alignment:.leading) {
            Image("MainHappyFoodImage")
                .resizable()
                .frame(width: .infinity, height: 300)
            VStack(alignment: .leading, spacing: 20) {
                // 배달 주소 안내문
                Text("배달 받으실 주소를 입력해주세요")
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                    .font(.system(size: 18))
                    .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 20) {
                    // brand name
                    Text("파리크라상")
                        .foregroundColor(.white)
                        .fontWeight(.black)
                        .font(.system(size: 21))
                    
                    // banner description
                    Text("매주 수요일엔\n배달, 픽업 모두\n5천원 혜택 챙겨요.")
                        .foregroundColor(.white)
                        .fontWeight(.black)
                        .font(.system(size: 24))
                        .lineSpacing(2)
                }
                .padding(.top, 4)
                
                HStack {
                    // 게시 날짜
                    Text("01.01 - 01.29")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 18))
                    Spacer()
                    
                    // 페이지 counter
                    HStack {
                        Text("8 / 21")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                            
                        
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                    }
                    .padding(8)
                    .background(.black.opacity(0.2))
                    .cornerRadius(10)
                }.padding(.top, 8)
                
                
                
            }.padding()
            
        }
    }
}

#Preview {
    MainBannerView()
}
