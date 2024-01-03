//
//  AppState.swift
//  GoGrocery
//
//  Created by Mohammad Afshar on 18/12/2023.
//

import Foundation
import GoGrocerySharedDTO

enum Route: Hashable {
    case LoginScreen
    case RegisterScreen
    case GroceryCategoryList
    case GroceryCategoryDetail(GroceryCategoryResponseDTO)
    case AddGroceryCategory
    case AddGroceryItem
}

class AppState: ObservableObject {
    @Published var routes: [Route] = []
    @Published var globalErrorWrapper: ErrorWrapper?
    
    func popAll() {
        routes.removeAll()
    }
    
    func popToRoot() {
        routes.removeLast(routes.count)
    }
    
    func popTo(route: Route) {
        guard let index = routes.firstIndex(of: route) else { return }
        routes = Array(routes[0...index])
    }
}
