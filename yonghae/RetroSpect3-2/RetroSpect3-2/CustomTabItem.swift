//
//  CustomTabItem.swift
//  RetroSpect3-2
//
//  Created by 김용해 on 1/19/25.
//

import SwiftUI

struct CustomTabItem<Content: View>: View {
    var image: String?
    var tabItemName: String?
    var isSelection: PageChangeType
    @Binding var navigationSelection: PageChangeType
    let content: Content?
    
    
    // content가 있는 생성자
    init(navigationSelection: Binding<PageChangeType> ,isSelection: PageChangeType ,@ViewBuilder content: @escaping () -> Content) {
        self.isSelection = isSelection
        self._navigationSelection = navigationSelection
        self.content = content()
    }
    
    // content가 없는 생성자
    init(image: String, tabItemName: String,isSelection: PageChangeType, navigationSelection: Binding<PageChangeType>) where Content == EmptyView {
        self.image = image
        self.tabItemName = tabItemName
        self.isSelection = isSelection
        self._navigationSelection = navigationSelection
        self.content = nil
    }
    
    var body: some View {

        if let content = content {
            content
                .onTapGesture {
                    // 클로저 함수 content 가 있을 경우 이 두개의 PageChangetype이 다를 때 페이지 이동
                    withAnimation {
                        // 이 두개의 PageChangetype이 다를 때 페이지 이동
                        if navigationSelection != isSelection {
                            navigationSelection = isSelection
                        }
                    }
                }
        } else {
            VStack(spacing: 5) {
                Image(image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 30, maxHeight: 30)
                Text(tabItemName!)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(red: 181/255, green: 224/255, blue: 188/255))
            }
            .padding(5)
            .frame(maxWidth: 70, maxHeight: 70)
            .onTapGesture {
                withAnimation {
                    // 이 두개의 PageChangetype이 다를 때 페이지 이동
                    if navigationSelection != isSelection {
                        navigationSelection = isSelection
                    }
                }
            }
        }
    }
}



