//
//  Example.swift
//  BlurBackground
//
//  Created by Caio de Almeida Pessoa on 13/03/25.
//

import SwiftUI

struct ExampleView: View {
    @State var helloWorld: [String] = []
    var body: some View {
        BackgroundBlur(Image(.wallPaper)) {
            VStack{
                Button {
                    helloWorld.append("Hello, World!")
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 200, height: 50)
                        .tint(Color.red)
                        .overlay {
                            Text("Adicionar")
                                .foregroundStyle(.white)
                                .bold()
                        }
                }
                .padding()

                ForEach(helloWorld, id: \.count) { text in
                    Text(text)
                }
            }
            .padding()
        }
        .orientation(.topToBottom)
//        .ignoresSafeArea()
    }
}

#Preview {
    ExampleView()
}
