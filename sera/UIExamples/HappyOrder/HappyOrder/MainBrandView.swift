//
//  MainBrandView.swift
//  HappyOrder
//
//  Created by 박세라 on 1/22/25.
//

import SwiftUI

struct MainBrandView: View {
    var body: some View {
        GeometryReader { geometry in
            let spacing = geometry.size.width / 40 // 화면 너비에 따라 spacing 값 조정
            Grid {
                GridRow {
                    ForEach(0...4, id: \.self) { index in
                        BrandCellContent(index: index)
                            .padding(.horizontal, spacing / 2)
                    }
                }
                GridRow {
                    ForEach(5...9, id: \.self) { index in
                        BrandCellContent(index: index)
                            .padding(.horizontal, spacing / 2)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 200)
        }
        .background( Color(red: 238 / 255, green: 244 / 255, blue: 236 / 255))
        .clipShape(.rect(cornerRadius: 8))
    }
}

struct BrandCellContent: View {
    var brandImageNameList = [ "ParisBaguette",
                                  "baskinlabins",
                                  "Dunkin-removebg-preview",
                                  "pascuchi-removebg-preview",
                                  "shakeshck-removebg-preview",
                                  "McDonald",
                                  "papajons",
                                  "pijaHat",
                                  "DDchicken-removebg-preview"
    ]
    var brandNameList = ["파리바게트", "배스킨라빈스", "던킨", "파스쿠찌", "쉐이크쉑",
                        "맥도날드", "파파존스", "피자헛", "디디치킨", "더보기"]
    var index: Int
    
    var body: some View {
        VStack {
            if index < 9 {
                Image(brandImageNameList[index])
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding()
                    .background(.white)
                    .frame(width: 54, height: 54)
                    .cornerRadius(8)
            } else {
                Image(systemName: "chevron.down")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding(24)
                    .background(.white)
                    .frame(width: 54, height: 54)
                    .cornerRadius(8)
            }
            Text(brandNameList[index])
                .font(.system(size: 14))
        }
    }
}

#Preview {
    MainBrandView()
}
