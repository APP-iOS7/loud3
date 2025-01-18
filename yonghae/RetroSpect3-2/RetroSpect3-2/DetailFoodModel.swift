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
    var color: Color
}
