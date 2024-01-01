//
//  ColorSelector.swift
//  GoGrocery
//
//  Created by Mohammad Afshar on 23/12/2023.
//

import SwiftUI

enum Colors: String, CaseIterable {
    case yellow = "#f1c40f"
    case green = "#2ecc71"
    case red = "#e74c3c"
    case blue = "#3498db"
    case purple = "#9b59b6"
}
/*
extension Colors: Identifiable {
    var id: Self { self }
    var id: RawValue { rawValue }
}
*/
struct ColorSelector: View {
    @Binding var colorCode: String
    
    var body: some View {
        HStack {
            ForEach(Colors.allCases, id: \.rawValue/*\.self*/) { color in
                Image(systemName: colorCode == color.rawValue ? "record.circle.fill" : "circle.fill")
                    .foregroundStyle(Color.fromHex(color.rawValue))
                    .font(.title)
                    .clipShape(Circle())
                    .onTapGesture {
                        self.colorCode = color.rawValue
                    }
            }
        }
    }
}

#Preview {
    ColorSelector(colorCode: .constant("#f1c40f"))
}
