//
//  ContentView.swift
//  GoGrocery
//
//  Created by Mohammad Afshar on 01/12/2023.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(GroceryModel.self) var groceryModel
    //    @EnvironmentObject private var groceryModel: GroceryModel
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var error: Bool = false
    @State private var errorMessage: String = ""
    var isFieldsValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && (password.count >= 6 && password.count <= 14)
    }
    @State private var goToLogin: Bool = false
    
    var body: some View {
            Form() {
                TextField("Username", text: $username)
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                
                HStack() {
                    Button("Register") {
                        Task {
                            await register()
                        }
                    }
                    .buttonStyle(.borderless)
                    .disabled(!isFieldsValid)
                    
                    Spacer()
                    HStack {
//                        NavigationLink("Go to Detail", value: Route.LoginScreen)
                        Button("Login") {
                            DispatchQueue.main.async {
                                appState.routes.append(.LoginScreen)
                            }
//                            goToLogin.toggle()
                        }
//                        .background {
//                            if goToLogin {
//                                NavigationLink(destination: LoginView(), isActive: $goToLogin) {
//                                    Text("")
//                                }
//                                .opacity(0)
//                            }
//                        }
                    }
                    
                    
//                    Button("Login") {
//                        goToLogin.toggle()
//                    }
//                    .buttonStyle(.borderless)
//                    .fullScreenCover(isPresented: $goToLogin, content: {
//                        LoginView()
//                    })
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
    
    fileprivate func register() async {
        do {
            let resault = try await groceryModel.registerUser(username: username, password: password)
            if !resault.error {
                appState.routes.append(.LoginScreen)
                print("succecc registered")
                print(resault.error)
                print(resault.reason)
            } else {
                self.error = resault.error
                self.errorMessage = resault.reason ?? ""
            }
        } catch {
            print("error in register async func ")
        }
    }
}


#Preview {
    RegisterView()
        .environment(GroceryModel())
}
