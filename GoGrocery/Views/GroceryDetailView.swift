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
            if groceryModel.groceryItems.isEmpty {
                ContentUnavailableView("No items found", image: "Person")
            } else {
                GroceryItemListView(groceryItems: groceryModel.groceryItems) { categoryItemId in
                    Task {
                        do {
                            try await groceryModel.deleteGroceryItems(groceryId: groceryCategoryResponseDTO.id, itemId: categoryItemId)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
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
                AddNewGroceryItemView()
            }
        }
        .onAppear {
            groceryModel.groceryCategoryResponseDTO = groceryCategoryResponseDTO
        }
        .task {
            await populateGroceryItems()
        }
    }
    
    private func populateGroceryItems() async {
        do {
            try await groceryModel.pupolateGroceryItems(categoryId: groceryCategoryResponseDTO.id)
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    NavigationStack {
        GroceryDetailView(groceryCategoryResponseDTO: GroceryCategoryResponseDTO(id: UUID(), title: "SeaFood", colorCode: "#f1c40f"))
            .environment(GroceryModel())
    }
}
