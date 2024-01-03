//
//  GoGroceryApp.swift
//  GoGrocery
//
//  Created by Mohammad Afshar on 01/12/2023.
//

import SwiftUI

@main
struct GoGroceryApp: App {
//    @StateObject var groceryModel = GroceryModel()
    @State var groceryModel = GroceryModel()
    @StateObject private var appState = AppState()
    @State var isUserLogedin: Bool = false
    
    var body: some Scene {
        let userDefaults = UserDefaults.standard
        let userId = userDefaults.userId
        let userToken = userDefaults.string(forKey: "authToken")
        
        WindowGroup {
            NavigationStack(path: $appState.routes) {
                Group {
                    if userId != nil && userToken != nil {
                        GroceryCategoryListView()
                    } else {
                        RegisterView()
                    }
                }
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                            case .LoginScreen:
                                LoginView()
                            case .RegisterScreen:
                                RegisterView()
                            case .GroceryCategoryList:
                                GroceryCategoryListView()
                            case .AddGroceryCategory:
                                AddGroceryCategoryView()
                            case .GroceryCategoryDetail(let groceryCategoryResponseDTO):
                                GroceryDetailView(groceryCategoryResponseDTO: groceryCategoryResponseDTO)
                            case .AddGroceryItem:
                                AddNewGroceryItemView()
                        }
                        
                    }
            }
            .environment(groceryModel)
            .environmentObject(appState)
            //                .environmentObject(groceryModel)
        }
    }
}
