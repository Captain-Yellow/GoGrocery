//
//  LoginView.swift
//  GoGrocery
//
//  Created by Mohammad Afshar on 17/12/2023.
//

import SwiftUI

struct LoginView: View {
    @Environment(GroceryModel.self) var groceryModel
    @EnvironmentObject private var appState: AppState
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var error: Bool = false
    @State private var errorMessage: String = ""
    @State private var loggedIn: Bool = false
    var isFieldsValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && (password.count >= 6 && password.count <= 14)
    }
    
    var body: some View {
        Form {
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
                .textInputAutocapitalization(.never)
            
            HStack(alignment: .center) {
                Button("Login") {
                    Task {
                        await login()
                    }
                }
                .buttonStyle(.borderless)
                .disabled(!isFieldsValid)
//                .fullScreenCover(isPresented: $loggedIn) {
//                    GroceryCategoryListView()
//                }
            }
            .frame(maxWidth: .infinity)
            
            if error {
                HStack(alignment: .center) {
                    Label{
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    } icon: {
                        Image(systemName: "person")
                            .foregroundStyle(.pink)
                    }
                    .labelStyle(.titleOnly)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }

    private func login() async {
        do {
            let resault = try await groceryModel.loginUser(username: username, password: password)
            if resault.error {
                self.error = true
                self.errorMessage = resault.reason ?? ""
            } else {
//                appState.popAll()
                loggedIn.toggle()
                appState.routes.append(.GroceryCategoryList)
            }
        } catch {
            self.error = true
            self.errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    LoginView()
        .environment(GroceryModel())
}
