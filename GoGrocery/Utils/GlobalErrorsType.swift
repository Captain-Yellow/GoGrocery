//
//  GlobalErrorsType.swift
//  GoGrocery
//
//  Created by Mohammad Afshar on 03/01/2024.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id = UUID()
    let error: Error
    let guidance: String
}

enum GlobalErrorsType: Error {
    case loginError
    case registerError
}
