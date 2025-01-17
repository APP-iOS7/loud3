//
//  ContentView.swift
//  SwiftDataDemo
//
//  Created by 고요한 on 1/16/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var Products: [Product]
    
    @State private var name : String = ""
    @State var quantity: String = ""

    var body: some View {
        NavigationStack {
            VStack{
                TextField("Product name", text: $name)
                TextField("Product quantity", text: $quantity)
                
                HStack {
                    Spacer()
                    Button(action: {
                        addProduct()
                        name = ""
                        quantity = ""
                    }, label: {
                        Text("Add")
                    })
                    Spacer()
                    NavigationLink(destination: ResultsView(name: name)) {
                        Text("Find")
                    }
                    Spacer()
                    Button(action: {
                        name = ""
                        quantity = ""
                    }, label: {
                        Text("Clear")
                    })
                    Spacer()
                }
                .padding()
                .frame(maxWidth : .infinity)
                
                List {
                    ForEach(Products) { productss in
                        HStack {
                            Text(productss.name ?? "not found")
                            Spacer()
                            Text(productss.quantity ?? "not found")
                        }
                    }
                    .onDelete(perform: deleteProduct)
                }
                .navigationTitle("Product Database")
            }
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }

    private func addProduct() {
        withAnimation {
            let newItem = Product(name: name, quantity: quantity)
            modelContext.insert(newItem)
        }
        
    }

    private func deleteProduct(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(Products[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Product.self, inMemory: true)
}
