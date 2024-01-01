//
//  GroceryCategoryListView.swift
//  GoGrocery
//
//  Created by Mohammad Afshar on 23/12/2023.
//

import SwiftUI

struct GroceryCategoryListView: View {
    @Environment(GroceryModel.self) var groceryModel
    @State private var isPresent: Bool = false
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        ZStack {
            if groceryModel.groceryCategories.isEmpty {
                ContentUnavailableView {
                    Image(systemName: "person")
                        .foregroundStyle(.red)
                } description: {
                    Text("No Category Exist, Create a New one...")
                } actions: {
                    Button("Create a Category") {
                        isPresent.toggle()
                    }
                }
                
            } else {
                //        Text("list")
                //            .onAppear {
                //                print(groceryModel.groceryCategories.count)
                //                print(groceryModel.groceryCategories)
                //            }
                //        NavigationStack {
                
                List/*(groceryModel.groceryCategories)*/ { /*grocery in*/
                    ForEach(groceryModel.groceryCategories) { groceryCategory in
                        NavigationLink(value: groceryCategory) {
                            HStack {
                                Circle()
                                    .foregroundStyle(Color.fromHex(groceryCategory.colorCode))
                                    .font(.title)
                                    .frame(width: 25, height: 25)
                                
                                Text(groceryCategory.title)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        self.deleteThisGroceryCategory(offsets: indexSet)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Logout") {
                    appState.popToRoot()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isPresent.toggle()
                    //                    appState.routes.append(.AddGroceryCategory)
                } label: {
                    Image(systemName: "plus")
                }
                
            }
        }
        .sheet(isPresented: $isPresent) {
            NavigationStack {
                AddGroceryCategoryView()
            }
        }
        .navigationBarTitle("Full Screen View", displayMode: .inline)
        .task {
            do {
                try await groceryModel.populateGroceryCategories()
                //                await fetchGroceryCategories()
            } catch {
                print(error)
            }
        }
        //    }
    }
    private func fetchGroceryCategories() async {
        do {
            try await groceryModel.populateGroceryCategories()
        } catch {
            print(error)
        }
    }
    
    private func deleteThisGroceryCategory(offsets: IndexSet) {
        offsets.forEach { index in
            let groceryCategory = groceryModel.groceryCategories[index]
            Task {
                do {
                    try await groceryModel.deleteGroceryCategory(groceryCategoryId: groceryCategory.id)
                    //                    try await groceryModel.deleteGroceryCategory(groceryCategoryId: groceryModel.groceryCategories[index].id)
                } catch {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    GroceryCategoryListView()
        .environment(GroceryModel())
}
