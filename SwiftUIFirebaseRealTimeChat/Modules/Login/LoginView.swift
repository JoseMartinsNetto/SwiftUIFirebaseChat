//
//  LoginView.swift
//  SwiftUIFirebaseRealTimeChat
//
//  Created by Jose Martins on 27/10/21.
//

import SwiftUI

struct LoginView: View {
    @State var isLoginMode = true
    @State var email = ""
    @State var password = ""
    @State var message = ""
    @State var hasError = false
    @State var shouldShowPicker = false
    @State var image: UIImage?
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack(spacing: 16) {
                    Picker(selection: $isLoginMode) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    } label: {
                        Text("Choose any option")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    if !isLoginMode {
                        
                        Button {
                            shouldShowPicker.toggle()
                        } label: {
                            VStack {
                                if let image = image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 128, height: 128)
                                        .cornerRadius(64)
                                } else {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 64))
                                        .foregroundColor(Color(.label))
                                        .padding()
                                }
                            }.overlay(RoundedRectangle(cornerRadius: 64).stroke(Color.black, lineWidth: 3))
                        }
                    }
                    
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $password)
                    }
                    .padding(12)
                    .background(Color.white)
                    
                    Button {
                        handleAction()
                    } label: {
                        HStack {
                            Spacer()
                            Text(isLoginMode ? "Login": "Create Account")
                                .padding(.vertical, 8)
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }
                        .background(Color.blue)
                    }
                    
                    if !self.message.isEmpty {
                        Text(self.message)
                            .padding()
                            .foregroundColor(hasError ? Color.red: Color.green)
                            .font(.system(size: 14, weight: .heavy))
                            .background(hasError ? Color.red.opacity(0.4) : Color.green.opacity(0.4))
                    }
                    
                }
                .padding()
            }
            .navigationTitle(isLoginMode ? "Login" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05)).ignoresSafeArea())
            .sheet(isPresented: $shouldShowPicker) {
                ImagePicker(selectedImage: $image)
            }
        }
    }
    
    private func handleAction() {
        if isLoginMode {
            login()
        }else{
            createUser()
        }
    }
    
    private func createUser() {
        
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, error in
            
            guard error == nil else {
                self.hasError = true
                self.message = "Failed to create user: \(error as Any)"
                return
            }
            
            self.hasError = false
            self.message = "SuccessFully Created user!"
            
            self.uploadImageToStorage()
        }
    }
    
    private func uploadImageToStorage() {
        guard let fileName = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let ref = FirebaseManager.shared.storage.reference(withPath: fileName)
        
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else { return }
        
        ref.putData(imageData) { metadata, error in
            guard error == nil else {
                self.message = "Failed To upload image! \(error as Any) "
                self.hasError = true
                return
            }
            
            ref.downloadURL { url, error in
                guard error == nil else {
                    self.message = "Failed To get image url! \(error as Any) "
                    self.hasError = true
                    return
                }
                
                self.hasError = false
                self.message = "Successfuly uploaded image! \(url?.absoluteString ?? "")"
            }
            
            
        }
    }
    
    private func login() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            
            guard error == nil else {
                self.hasError = true
                self.message = "Failed to login user: \(error as Any)"
                return
            }
            
            self.hasError = false
            self.message = "SuccessFully login user!"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
