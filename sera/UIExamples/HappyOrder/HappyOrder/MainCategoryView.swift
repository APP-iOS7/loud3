//
//  MainCategoryView.swift
//  HappyOrder
//
//  Created by 박세라 on 1/18/25.
//

import SwiftUI

struct MainCategoryView: View {
    var body: some View {
        GeometryReader { geometry in
            let spacing = geometry.size.width / 40 // 화면 너비에 따라 spacing 값 조정
            Grid {
                GridRow {
                    ForEach(0...4, id: \.self) { index in
                        CategoryCellContent(index: index)
                            .padding(.horizontal, spacing / 2)
                    }
                }
                GridRow {
                    ForEach(5...9, id: \.self) { index in
                        CategoryCellContent(index: index)
                            .padding(.horizontal, spacing / 2)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 200)
        }

    }
}

struct CategoryCellContent: View {
    var categoryImageNameList = [ "bakery-removebg-preview",
                                  "dessert-removebg-preview",
                                  "cafe-Photoroom",
                                  "salad-removebg-preview",
                                  "sandwich-removebg-preview",
                                  "buger-Photoroom",
                                  "chicken-Photoroom",
                                  "pasteFija-removebg-preview",
                                  "binsicHansic-removebg-preview",
                                  "Constore-removebg-preview"
    ]
    var categoryNameList = ["베이커리", "디저트", "카페", "샐러드", "샌드위치",
                        "버거", "치킨", "파스타/피자", "분식/한식", "편의점"]
    var index: Int
    
    var body: some View {
        VStack {
            Image(categoryImageNameList[index])
                .resizable()
                .scaleEffect(CGSize(width: 1.5, height: 1.5))
                .padding()
                .background( Color(red: 238 / 255, green: 244 / 255, blue: 236 / 255))
                .frame(width: 54, height: 54)
                .cornerRadius(8)
            Text(categoryNameList[index])
                .font(.system(size: 14))
        }
    }
}

#Preview {
    MainCategoryView()
}
