//
//  AppState.swift
//  GoGrocery
//
//  Created by Mohammad Afshar on 18/12/2023.
//

import Foundation

enum Route: Hashable {
    case LoginScreen
    case RegisterScreen
    case GroceryCategoryList
    case AddGroceryCategory
}

class AppState: ObservableObject {
    @Published var routes: [Route] = []
    
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
