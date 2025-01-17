//
//  ContentView.swift
//  ImageDoc
//
//  Created by 고요한 on 1/16/25.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @Binding var document: ImageDocDocument
    @State private var ciFilter = CIFilter.sepiaTone()
    
    let context = CIContext()

    var body: some View {
        VStack {
            Image(uiImage: document.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Button(action : {
                filterImage()
            } , label: {
                Text("Filter Image")
            })
            .padding()
            
        }
    }
    
    func filterImage() {
        ciFilter.intensity = Float(1.0)
        
        let ciImage = CIImage(image: document.image)
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        
        guard let outputImage = ciFilter.outputImage else { return }
        if let cgImage = context.createCGImage(outputImage, from: ciImage!.extent) {
            document.image = UIImage(cgImage: cgImage)
        }
    }
}

#Preview {
    ContentView(document: .constant(ImageDocDocument()))
}
