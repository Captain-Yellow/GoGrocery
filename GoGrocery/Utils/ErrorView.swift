//
//  ErrorView.swift
//  GoGrocery
//
//  Created by Mohammad Afshar on 03/01/2024.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "person")
                .backgroundStyle(.red)
            
            Text(errorWrapper.error.localizedDescription)
                .font(.title)
            
            Text(errorWrapper.guidance)
                .font(.caption)
        }
        .padding()
    }
}

//#Preview {
//    ErrorView()
//}
