//
//  CatalogView.swift
//  BuyShoes
//

import SwiftUI

struct CatalogView: View {
    @StateObject private var cartManager = CartManager()
    @State private var showingCart = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    ForEach(Product.sampleProducts) { product in
                        ProductCard(product: product, cartManager: cartManager)
                    }
                }
                .padding()
            }
            .navigationTitle("Каталог")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showingCart = true }) {
                        ZStack {
                            Image(systemName: "cart")
                                .font(.title2)
                            if cartManager.itemCount > 0 {
                                Text("\(cartManager.itemCount)")
                                    .font(.caption2)
                                    .padding(4)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .offset(x: 10, y: -8)
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showingCart) {
                CartView(cartManager: cartManager)
            }
        }
    }
}

struct ProductCard: View {
    let product: Product
    @ObservedObject var cartManager: CartManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Product Image
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 140)
                .overlay {
                    if let uiImage = UIImage(named: product.imageName) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                    } else {
                        Image(systemName: "shoe")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                    }
                }
            
            Text(product.brand)
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(product.name)
                .font(.headline)
                .lineLimit(1)
            
            Text("$\(product.price, specifier: "%.2f")")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Button(action: {
                cartManager.addToCart(product: product)
            }) {
                Text("В корзину")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}
