//
//  DetailFoodModel.swift
//  RetroSpect3-2
//
//  Created by 김용해 on 1/18/25.
//

import SwiftUI

struct DetailFoodModel: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var imageName: String
    var color: Color?
    
    init(id: UUID = UUID(), title: String, imageName: String, color: Color) {
        self.id = id
        self.title = title
        self.imageName = imageName
        self.color = color
    }
    
    // dumyCategoryImageData 를 위해 배경색은 동일 하므로 Color를 옵셔널로 바꿉니다
    init(id: UUID = UUID(), title: String, imageName: String) {
        self.id = id
        self.title = title
        self.imageName = imageName
    }
}
