//
//  ContentView.swift
//  RetroSpect3-2
//
//  Created by 김용해 on 1/15/25.
//

import SwiftUI

struct ContentView: View {
    // Array 반복
    let gridItem = Array(repeating: GridItem(.flexible()), count: 5)

    // 분류를 위한 이미지 더미 데이터입니다
    
    /// 기존 원시타입이던 객체를 구조체를 통해 순서의 보장을 위해 바꿧습니다.
    let dumyCategoryImageData: [DetailFoodModel] = [
        DetailFoodModel(title: "베이커리", imageName: "bakery"),
        DetailFoodModel(title: "분식/한식", imageName: "bunsicHansic"),
        DetailFoodModel(title: "버거", imageName: "buger"),
        DetailFoodModel(title: "카페", imageName: "cafe"),
        DetailFoodModel(title: "치킨", imageName: "chicken"),
        DetailFoodModel(title: "편의점", imageName: "constore"),
        DetailFoodModel(title: "디저트", imageName: "dessert"),
        DetailFoodModel(title: "파스타/피자", imageName: "pasteFija"),
        DetailFoodModel(title: "샐러드", imageName: "salad"),
        DetailFoodModel(title: "샌드위치", imageName: "sandwich"),
    ]
    
    /// 구조체를 통해 데이터를 모델링
    /// 이렇게 안하면 data를 가공하기 힘듬..
    ///  초기에 [String : [Any]] 이렇게 사용할려 했지만 타입정의해주는게 너무 별로임
    ///  모델링 하는 이유가 있음
    let dumyBottomImageData: [DetailFoodModel] = [
        DetailFoodModel(title: "파리바게트", imageName: "parisBaguette", color: .white),
        DetailFoodModel(title: "베스킨라빈스", imageName: "baskinlabins", color: Color(red:218/255, green: 26/255, blue: 132/255)),
        DetailFoodModel(title: "던킨", imageName: "dunkin", color: .white),
        DetailFoodModel(title: "파스쿠찌", imageName: "pascuchi", color: .white),
        DetailFoodModel(title: "쉐이크쉑", imageName: "shakeshck", color: .white),
        DetailFoodModel(title: "파파존스", imageName: "papajons", color: .green),
        DetailFoodModel(title: "디디치킨", imageName: "DDchicken", color: .white),
        DetailFoodModel(title: "맥도날드", imageName: "McDonald", color: Color(red: 232/255, green: 32/255, blue: 18/255)),
        DetailFoodModel(title: "이삭토스트", imageName: "isaacToast", color: .white),
        DetailFoodModel(title: "피자헛", imageName: "pijaHat", color: .white)
    ]
    
    // 단순한 객체를 위한 상수 매너임
    let backgroundColor: Color = Color(red: 241/255, green: 246/255, blue: 240/255)
    
    /// category 바인딩 상태를 위해 부모에서 관리합니다
    @State private var categoryItemSelection: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                MainImageContentView()
                // 여기 하고 아래 뷰에 gap이 있어요
                MiddleTabBarView(categoryItemSelection: $categoryItemSelection)
                // 중앙 분류 View
                CategoryFoodView(
                    categoryItemSelection: $categoryItemSelection,
                    dumyCategoryImageData: dumyCategoryImageData,
                    backgroundColor: backgroundColor,
                    gridItem: gridItem
                )
                // 하단 상세 음식 View
                BottomDetailFoodView(gridItem: gridItem, backgroundColor: backgroundColor, dumyBottomImageData: dumyBottomImageData)
            }
            // bottom Navigation View
            CustomNavigationView()
        }
    }
}

// Category 구조페를 동해 MiddleTabBarView 모델링
struct Category: Identifiable {
    var id = UUID()
    var categoryName: String
    var selection: Int
}

struct MainImageContentView: View {
    var body: some View {
        ZStack {
            Image("MainImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Rectangle()
                .foregroundStyle(.black.opacity(0.4))
            HStack {
                VStack(alignment: .leading) {
                    Text("배달 받으실 주소를 입력해주세요")
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity,alignment:.leading)
                        .padding([.top, .leading], 10)
                        .font(.caption)
                    Spacer()
                    Group {
                        Text("파리크라상")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Text("매주 수요일엔\n배달, 픽업 모두\n5천원 해택 챙겨요 :)")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.vertical, 10 / 2)
                    }
                    .padding([.leading], 10)
                    Spacer()
                    
                    Text("01.01 - 01.29")
                        .padding([.leading, .bottom], 10)
                        .font(.caption)
                        .fontWeight(.bold)
                }
                .foregroundStyle(.background)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack {
                    Spacer()
                    HStack {
                        Group {
                            Text("8 / 21")
                            Image(systemName: "plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 12, height: 12)
                                .fontWeight(.medium)
                        }
                        .padding(5)
                        .foregroundStyle(.white)
                        .font(.footnote)
                    }
                    .background(.white.opacity(0.4))
                    .clipShape(.rect(cornerRadius: 5))
                }
                .foregroundStyle(.background)
                .frame(maxWidth: 110,maxHeight: .infinity)
                .padding(.bottom, 10)
            }
        }
        .padding(.bottom, -8)
     }
}

struct MiddleTabBarView: View {
    @Binding var categoryItemSelection: Int
    let categoryList: [Category] = [
        Category(categoryName: "바로배달", selection: 0),
        Category(categoryName: "바로픽업", selection: 1),
        Category(categoryName: "예약", selection: 2)
    ]
    var body: some View {
        HStack(spacing:0) {
            ForEach(categoryList,id: \.id) { category in
                Text(category.categoryName)
                    .fontWeight(category.selection == categoryItemSelection ? .semibold : .regular)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .overlay(alignment: .bottom) {
                        if categoryItemSelection == category.selection {
                            Rectangle()
                                .frame(height: 4)
                                .foregroundStyle(.green)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            categoryItemSelection = category.selection
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct CategoryFoodView: View {
    
    @Binding var categoryItemSelection: Int
    
    var dumyCategoryImageData: [DetailFoodModel] // 구조체로 model 변경
    let backgroundColor: Color
    let gridItem: [GridItem]
    
    var body: some View {
        HStack {
            if categoryItemSelection == 0 {
                LazyVGrid(columns: gridItem, spacing: 10) {
                    ForEach(dumyCategoryImageData, id: \.self) { categoryData in // 내부 값도 변경
                        VStack {
                            Image(categoryData.imageName)
                                .resizable()
                                .frame(width: 40, height: 40, alignment: .center)
                                .aspectRatio(contentMode: .fit)
                                .padding(10)
                                .background(
                                    backgroundColor,
                                    in: RoundedRectangle(cornerRadius: 8)
                                )
                            Text(categoryData.title)
                                .font(.footnote)
                        }
                    }
                }
            }else if categoryItemSelection == 1 {
                Text("두번째 category 뷰 입니다.")
                    .frame(maxHeight: .infinity)
            }else if categoryItemSelection == 2 {
                Text("세번째 category 뷰 입니다")
                    .frame(maxHeight: .infinity)
            }
        }
        .padding(13)
    }
}

struct BottomDetailFoodView: View {
    let gridItem: [GridItem]
    let backgroundColor: Color
    var dumyBottomImageData : [DetailFoodModel]
    
    var body: some View {
        HStack {
            LazyVGrid(columns: gridItem, spacing: 20) {
                ForEach(dumyBottomImageData, id: \.self) { foodData in
                        VStack {
                            Image(foodData.imageName)
                                .resizable()
                                .frame(width: 40, height: 40, alignment: .center)
                                .aspectRatio(contentMode: .fill)
                                .padding(10)
                                .background(
                                    foodData.color!, // color 가 required에서 옵셔널이 되었기에 강제 언래핑 합니다
                                    in: RoundedRectangle(cornerRadius: 12)
                                )
                            Text(foodData.title)
                                .font(.caption2)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .padding()
                    .background(backgroundColor, in: RoundedRectangle(cornerRadius: 22))
            }
            .padding()
    }
}

struct CustomNavigationView: View {
    var body: some View {
        HStack {
            CustomTabItem(image: "Brand", tabItemName: "브랜드")
            CustomTabItem(image: "Star", tabItemName: "이벤트")
            CustomTabItem{
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .foregroundStyle(.white)
                    Text("오")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity ,maxHeight: .infinity)
                        .foregroundStyle(Color(red: 1/255, green: 167/255, blue: 65/255))
                }
                .padding(5)
                .frame(maxWidth: 70, maxHeight: 70)
            }
            CustomTabItem(image: "Order", tabItemName: "주문내역")
            CustomTabItem(image: "MyProfile", tabItemName: "마이")
        }
        .padding(.horizontal)
        .padding(.bottom, -20)
        .background(Color(red: 1/255, green: 167/255, blue: 65/255))
    }
}

#Preview {
    ContentView()
}
