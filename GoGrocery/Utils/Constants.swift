//
//  Constants.swift
//  GoGrocery
//
//  Created by Mohammad Afshar on 17/12/2023.
//

import Foundation

struct Constants {
    static let baseUrl = "http://127.0.0.1:8080"
    
    struct urls {
        static let register = URL(string: "\(baseUrl)/authentication/registeration")!
        static let login = URL(string: "\(baseUrl)/authentication/login")!
        
        static func saveGroceryCategory(_ userId: UUID) -> URL {
            return URL(string: "\(baseUrl)/users/\(userId)/grocery_categories")!
        }
        
        static func getGroceryCategories(_ userId: UUID) -> URL {
            return URL(string: "\(baseUrl)/users/\(userId)/grocery_categories")!
        }
        
        static func deletGroceryCategories(userId: UUID, categoryId: UUID) -> URL {
            URL(string: "\(baseUrl)/users/\(userId)/grocery_categories/\(categoryId)")!
        }
        
        static func saveGroceryItem(userId: UUID, categoryId: UUID) -> URL {
            URL(string: "\(baseUrl)/users/\(userId)/grocery_categories/\(categoryId)/grocery_items")!
        }
    }
}
