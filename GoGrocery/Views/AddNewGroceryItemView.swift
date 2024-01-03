//
//  AddNewGroceryItemView.swift
//  GoGrocery
//
//  Created by Mohammad Afshar on 31/12/2023.
//

import SwiftUI
import GoGrocerySharedDTO

struct AddNewGroceryItemView: View {
    @State var title: String = ""
    @State var price: Double? = nil
    @State var quantity: Int? = nil
    @Environment(\.dismiss) var dismiss
    @Environment(GroceryModel.self) var groceryModel
    
    var isFormValid: Bool {
        guard let price, let quantity else {
            return false
        }
        return !title.isEmptyOrWhiteSpace && price > 0 && quantity > 0
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Price", value: $price, format: .currency(code: Locale.current.currencySymbol ?? ""))
            TextField("Quantity", value: $quantity, format: .number)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    if isFormValid {
                        Task {
                            await saveGroceryItem()
                        }
                    } else {
                        print("form isnt valid")
                    }
                }
                .disabled(!isFormValid)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
        }
    }
    
    private func saveGroceryItem() async {
        guard let groceryCategory = await groceryModel.groceryCategoryResponseDTO else { return }
        
        do {
            try await groceryModel.saveGroceryItem(groceryCategoryId: groceryCategory.id, groceryItemRequestDTO: GroceryItemRequestDTO(title: title, price: price!, quantity: quantity!))
            dismiss()
        } catch {
            print("\(error.localizedDescription) \n\n")
            print(error)
        }
    }
}

#Preview {
    NavigationStack {
        AddNewGroceryItemView()
    }
}
