//
//  GroceryModel.swift
//  GoGrocery
//
//  Created by Mohammad Afshar on 17/12/2023.
//

import Foundation
import GoGrocerySharedDTO

@MainActor
@Observable class GroceryModel/*: ObservableObject*/ {
    var groceryCategories: [GroceryCategoryResponseDTO] = []
    let client = HTTPClient()
    var groceryItems: [GroceryItemResponseDTO] = []
    var groceryCategoryResponseDTO: GroceryCategoryResponseDTO?
    
    func registerUser(username: String, password: String) async throws -> RegisterResponceDTO {
        let data = ["username" : username, "password" : password]
        let postData = try JSONEncoder().encode(data)
        let resource = Resourse(url: Constants.urls.register, method: .post(postData), methodType: RegisterResponceDTO.self)
        let registerResponseDTO = try await client.load(resource)
        return registerResponseDTO
    }
    
    func loginUser(username: String, password: String) async throws -> LoginResponceDTO {
        let data = ["username" : username, "password" : password]
        let postData = try JSONEncoder().encode(data)
        let resource = Resourse(url: Constants.urls.login, method: .post(postData), methodType: LoginResponceDTO.self)
        let loginResponseDTO = try await client.load(resource)
        
        if loginResponseDTO.error == false && loginResponseDTO.token != nil && loginResponseDTO.userId != nil {
            print("saved userid")
            let userDef = UserDefaults.standard
            userDef.set(loginResponseDTO.token!, forKey: "authToken")
            userDef.set(loginResponseDTO.userId!.uuidString, forKey: "userId")
        } else {
            print("error in save userId")
            print(loginResponseDTO)
        }
        
        return loginResponseDTO
    }
    
    func saveGroceryCategory(_ groceryCategoryRequestDTO: GroceryCategoryRequestDTO) async throws {
        guard let userId = UserDefaults.standard.userId else { print("eeror in userid"); return }

        let resource = Resourse(url: Constants.urls.saveGroceryCategory(userId), method: .post(try JSONEncoder().encode(groceryCategoryRequestDTO)), methodType: GroceryCategoryResponseDTO.self)

        let newGroceryCategory = try await client.load(resource)

        groceryCategories.append(newGroceryCategory)
    }
    
    func populateGroceryCategories() async throws {
        guard let userId = UserDefaults.standard.userId else {
            return
        }
        let resource = Resourse(url: Constants.urls.getGroceryCategories(userId), methodType: [GroceryCategoryResponseDTO].self)
        self.groceryCategories = try await client.load(resource)
    }
    
    func deleteGroceryCategory(groceryCategoryId: UUID) async throws {
        guard let userId = UserDefaults.standard.userId else { return }
        
        let resource = Resourse(url: Constants.urls.deletGroceryCategories(userId: userId, categoryId: groceryCategoryId), method: .delete, methodType: GroceryCategoryResponseDTO.self)
        let deletedCategory = try await client.load(resource)
        
        self.groceryCategories = self.groceryCategories.filter { $0.id != deletedCategory.id }
    }
    
    func saveGroceryItem(groceryCategoryId: UUID, groceryItemRequestDTO: GroceryItemRequestDTO) async throws {
        guard let userId = UserDefaults.standard.userId else { return }
        
        let resource = Resourse(url: Constants.urls.saveGroceryItem(userId: userId, categoryId: groceryCategoryId), method: .post(try JSONEncoder().encode(groceryItemRequestDTO)), methodType: GroceryItemResponseDTO.self)
        
        let addedItem = try await client.load(resource)
        groceryItems.append(addedItem)
    }
    
    func pupolateGroceryItems() async throws -> String {
        
        return "OK"
    }
}
