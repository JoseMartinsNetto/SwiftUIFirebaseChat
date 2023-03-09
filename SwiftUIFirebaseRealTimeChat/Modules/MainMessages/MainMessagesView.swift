//
//  MainMessagesView.swift
//  SwiftUIFirebaseRealTimeChat
//
//  Created by Jose Martins on 09/03/23.
//

import SwiftUI

fileprivate struct CustomNavBar: View {
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
            Image(systemName: "gear")
            
        }.padding()
    }
}

struct MainMessagesView: View {
    var body: some View {
        NavigationView {
            VStack {
                CustomNavBar()
                
                ScrollView {
                    ForEach(0..<10) { index in
                        VStack {
                            HStack(spacing: 16) {
                                Image(systemName: "person.fill")
                                    .padding(8)
                                    .font(.system(size: 32))
                                    .overlay(RoundedRectangle(cornerRadius: 44)
                                        .stroke(Color.black, lineWidth: 1))
                                
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
            }.navigationBarHidden(true)
        }
    }
}

struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}
