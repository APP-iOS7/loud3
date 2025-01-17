
import SwiftUI
import SwiftData

struct ResultsView: View {
    var name: String
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var matches: [Product] = []
    
    var body: some View {
        VStack {
            List {
                ForEach(matches) { product in
                    HStack {
                        Text(product.name ?? "Not found")
                        Spacer()
                        Text(product.quantity ?? "Not found")
                    }
                }
            }
            .navigationTitle("Results")
        }
        .task {
            let descriptor = FetchDescriptor<Product>(predicate: #Predicate<Product> {
                $0.name?.contains(name) ?? false
            })
            do {
                matches = try modelContext.fetch(descriptor)
                print(matches)
            } catch {
                print("Error fetching products: \(error)")
                matches = []
            }
        }
    }
}

#Preview {
    ResultsView(name: "test")
        .modelContainer(for: Product.self, inMemory: true)
}
