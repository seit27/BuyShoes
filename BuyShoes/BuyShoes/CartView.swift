//
//  CartView.swift
//  BuyShoes
//

import SwiftUI

struct CartView: View {
    @ObservedObject var cartManager: CartManager
    @Environment(\.dismiss) var dismiss
    @State private var showingCheckout = false
    
    var body: some View {
        NavigationStack {
            if cartManager.cartItems.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "cart")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    Text("Корзина пуста")
                        .font(.title2)
                        .foregroundColor(.gray)
                    Button("Начать покупки") {
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                List {
                    ForEach(cartManager.cartItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.product.name)
                                    .font(.headline)
                                Text("$\(item.product.price, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                            
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    cartManager.updateQuantity(productId: item.product.id, quantity: item.quantity - 1)
                                }) {
                                    Image(systemName: "minus.circle")
                                }
                                
                                Text("\(item.quantity)")
                                    .frame(width: 30)
                                
                                Button(action: {
                                    cartManager.updateQuantity(productId: item.product.id, quantity: item.quantity + 1)
                                }) {
                                    Image(systemName: "plus.circle")
                                }
                            }
                            
                            Button(action: {
                                cartManager.removeFromCart(productId: item.product.id)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let item = cartManager.cartItems[index]
                            cartManager.removeFromCart(productId: item.product.id)
                        }
                    }
                }
                .listStyle(.plain)
                
                VStack(spacing: 16) {
                    HStack {
                        Text("Итого:")
                            .font(.title2)
                        Spacer()
                        Text("$\(cartManager.totalPrice, specifier: "%.2f")")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        showingCheckout = true
                    }) {
                        Text("Оформить заказ")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle("Корзина")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Закрыть") {
                    dismiss()
                }
            }
        }
        .alert("Заказ оформлен!", isPresented: $showingCheckout) {
            Button("OK") {
                cartManager.clearCart()
                dismiss()
            }
        } message: {
            Text("Спасибо за покупку!")
        }
    }
}
