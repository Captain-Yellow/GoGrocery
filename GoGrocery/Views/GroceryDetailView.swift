//
//  GroceryDetailView.swift
//  GoGrocery
//
//  Created by Mohammad Afshar on 31/12/2023.
//

import SwiftUI
import GoGrocerySharedDTO

struct GroceryDetailView: View {
    @Environment(GroceryModel.self) var groceryModel
    @Environment(\.dismiss) var dismiss
    @State var addItemViewIsPresented: Bool = false
    let groceryCategoryResponseDTO: GroceryCategoryResponseDTO
    
    var body: some View {
        VStack {
            List(0...10, id: \.self) { index in
                Text("list Item \(index)")
            }
            .navigationTitle(groceryCategoryResponseDTO.title)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        addItemViewIsPresented = true
                    }
                }
            }
            .sheet(isPresented: $addItemViewIsPresented) {
                NavigationStack {
                    
                }
            }
            .onAppear {
                groceryModel.groceryCategoryResponseDTO = groceryCategoryResponseDTO
            }
        }
    }
}

#Preview {
    NavigationStack {
        GroceryDetailView(groceryCategoryResponseDTO: GroceryCategoryResponseDTO(id: UUID(), title: "SeaFood", colorCode: "#f1c40f"))
            .environment(GroceryModel())
    }
}
