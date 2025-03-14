//
//  ContentView.swift
//  BlurBackground
//
//  Created by Caio de Almeida Pessoa on 11/03/25.
//

import SwiftUI

fileprivate struct ContentView: View {
    @State var isExpanded: Bool = false
    var body: some View {
        ZStack{
            Group{
                
                Color(.background)
                Image("Background")
                    .resizable()
                    .scaledToFit()
//                    .blur(radius: isExpanded ? 10 : 0)
            }
            .ignoresSafeArea()
            
            VStack {
                Button(isExpanded ? "Collapse" : "Expand") {
                    print("expandindo")
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
                .padding(.top, 100)
                Spacer()
                
                ZStack {
                    ZStack{
//                        Rectangle()
//                            .background(.ultraThinMaterial.opacity(0.8))
//                            .blur(radius: 10)
//                            .frame(width: 400)
//                            .offset(x: 100)
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: .infinity)
                            .background(.thickMaterial.opacity(0.3))
//                            .frame(width: UIScreen.main.bounds.width + 40)
                            .blur(radius: 10)
//                            .blur(radius: 1)
//                            .offset(x: -100)
                    }
                    
                    
                    List {
                        Text("CAIO")
                            .listRowBackground(Color.clear)
                            .foregroundStyle(.white)
                            .listRowSeparator(.hidden)
                        Text("CAIO")
                            .listRowBackground(Color.clear)
                            .foregroundStyle(.white)
                            .listRowSeparator(.hidden)
                        Text("CAIO")
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .foregroundStyle(.white)
                    }
                    .scrollContentBackground(.hidden)
                }
                .frame(height: isExpanded ? 600 : 290)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
