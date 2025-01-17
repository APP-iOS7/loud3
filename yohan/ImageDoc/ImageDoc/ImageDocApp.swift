//
//  ImageDocApp.swift
//  ImageDoc
//
//  Created by 고요한 on 1/16/25.
//

import SwiftUI

@main
struct ImageDocApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: ImageDocDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
