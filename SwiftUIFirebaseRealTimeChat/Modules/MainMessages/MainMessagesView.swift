//
//  MainMessagesView.swift
//  SwiftUIFirebaseRealTimeChat
//
//  Created by Jose Martins on 09/03/23.
//

import SwiftUI

struct MainMessagesView: View {
    var body: some View {
        NavigationView {
            VStack {
                CustomNavBar(onLogout: {
                    print("handle logout")
                })
                
                ScrollView {
                    ForEach(0..<10) { index in
                        VStack {
                            HStack(spacing: 16) {
                                Image(systemName: "person.fill")
                                    .padding(8)
                                    .font(.system(size: 32))
                                    .overlay(RoundedRectangle(cornerRadius: 44)
                                        .stroke(Color(.label), lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text("Username")
                                        .font(.system(size: 14, weight: .bold))
                                    Text("Message sent to user")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color(.lightGray))
                                }
                                Spacer()
                                
                                Text("22d")
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            Divider()
                                .padding(.vertical, 8)
                        }.padding(.horizontal)
                    }
                }
            }
            .overlay(
                NewMessagesButton {
                    
                }
                , alignment: .bottom
            )
            .navigationBarHidden(true)
        }
    }
}

fileprivate struct CustomNavBar: View {
    @State var sholdShowLogoutOptions = false
    
    let onLogout: () -> Void
    
    init(onLogout: @escaping () -> Void) {
        self.onLogout = onLogout
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.fill")
                .font(.system(size: 34, weight: .heavy))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("USERNAME")
                    .font(.system(size: 24, weight: .bold))
                
                HStack {
                    Circle()
                        .foregroundColor(Color.green)
                        .frame(width: 14, height: 14)
                    Text("online")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.lightGray))
                }
            }
            
            Spacer()
            
            Button {
                sholdShowLogoutOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .foregroundColor(Color.black)
            }
            
        }
        .padding()
        .actionSheet(isPresented: $sholdShowLogoutOptions) {
            .init(title: Text("Settings"),
                  message: Text("What you want to do ?"),
                  buttons: [
                    .destructive(Text("Sing Out"), action: onLogout),
                    .cancel()
                  ]
            )
        }
    }
}

fileprivate struct NewMessagesButton: View {
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
            Button {
                action()
            } label: {
                HStack {
                    Spacer()
                    Text("+ New Message")
                    Spacer()
                }
                .foregroundColor(Color.white)
                .padding(.vertical)
                .background(Color.blue)
                .cornerRadius(32)
                .padding(.horizontal)
                .shadow(radius: 5)
            }
    }
}

struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}
