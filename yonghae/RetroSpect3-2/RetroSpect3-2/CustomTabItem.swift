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
    let content: Content?
    
    // content가 있는 생성자
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    // content가 없는 생성자
    init(image: String, tabItemName: String) where Content == EmptyView {
        self.image = image
        self.tabItemName = tabItemName
        self.content = nil
    }
    
    var body: some View {

        if let content = content {
            content
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
        }
    }
}



