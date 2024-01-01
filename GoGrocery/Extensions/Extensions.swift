//
//  Extentions.swift
//  GoGrocery
//
//  Created by Mohammad Afshar on 16/12/2023.
//

import Foundation
import SwiftUI
import GoGrocerySharedDTO

extension String {
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension Color {
    static func fromHex(_ hexCode: String) -> Color {
        let scanner = Scanner(string: hexCode.replacingOccurrences(of: "#", with: ""))
        var hexNumber: UInt64 = 0
        scanner.scanHexInt64(&hexNumber)
        
        let red = Double((hexNumber & 0xff0000) >> 16) / 255.0
        let green = Double ((hexNumber & 0xff00) >> 8) / 255.0
        let blue = Double (hexNumber & 0xff) / 255.0
        
        return Color(.sRGB, red: red, green: green, blue: blue, opacity: 1)
    }
}

extension UserDefaults {
    var userId: UUID? {
        get {
            guard let userIdString = string(forKey: "userId") else {
                return nil
            }
            return UUID(uuidString: userIdString)
        }
        
        set {
            set(newValue?.uuidString, forKey: "userId")
        }
    }
}

extension GroceryCategoryResponseDTO: Identifiable, Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(<#T##value: Hashable##Hashable#>)
    }
    
    public static func ==(lhs: GroceryCategoryResponseDTO, rhs: GroceryCategoryResponseDTO) -> Bool {
        <#code#>
    }
 
}
