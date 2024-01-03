//
//  GroceryItemListView.swift
//  GoGrocery
//
//  Created by Mohammad Afshar on 01/01/2024.
//

import SwiftUI
import GoGrocerySharedDTO

struct GroceryItemListView: View {
    @Environment(GroceryModel.self) var model
    let groceryItems: [GroceryItemResponseDTO]
    let onRemoveCallBack: (UUID) -> Void
    
    /*@MainActor*/ private func removeItem(at offset: IndexSet) {
        Task {
            guard let categoryId = await MainActor.run(body: {
                model.groceryCategoryResponseDTO?.id
            }) else {
                return
            }
        }
//        guard (model.groceryCategoryResponseDTO?.id) != nil else { return }
                
        offset.forEach { index in
            let groceryItem = groceryItems[index]
            onRemoveCallBack(groceryItem.id)
        }
    }
    
    var body: some View {
        List {
            ForEach(groceryItems) { item in
                Text(item.title)
            }
            .onDelete(perform: removeItem)
        }
    }
}

//#Preview {
//    GroceryItemListView()
//}
