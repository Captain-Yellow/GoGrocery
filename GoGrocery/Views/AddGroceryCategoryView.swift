//
//  Categories.swift
//  GoGrocery
//
//  Created by Mohammad Afshar on 23/12/2023.
//

import SwiftUI
import GoGrocerySharedDTO

struct AddGroceryCategoryView: View {
    @State var title: String = ""
    @State var colorCode: String = "#f1c40f"
    @Environment(GroceryModel.self) var groceryModel
    @Environment(\.dismiss) private var dismiss
    
    private var isFormValid: Bool {
        title.isEmptyOrWhiteSpace
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            
            ColorSelector(colorCode: $colorCode)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    Task {
                        await saveGroceryCategory()
                    }
                }
                .disabled(isFormValid)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
        }
        .navigationTitle("New Category")
    }
    
    private func saveGroceryCategory() async {
        let groceryCategoryRequestDTO = GroceryCategoryRequestDTO(title: title, colorCode: colorCode)
        do {
            try await groceryModel.saveGroceryCategory(groceryCategoryRequestDTO)
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    NavigationStack {
        AddGroceryCategoryView()
    }
}
