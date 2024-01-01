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
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appState.routes) {
                RegisterView()
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
                        }
                        
                    }
            }
            .environment(groceryModel)
            .environmentObject(appState)
            //                .environmentObject(groceryModel)
        }
    }
}
