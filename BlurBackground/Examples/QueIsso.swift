//
//  QueIsso.swift
//  BlurBackground
//
//  Created by Caio de Almeida Pessoa on 11/03/25.
//
import SwiftUI

fileprivate struct QueIsso: View {
    
    let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: .purple, location: 0),
            .init(color: .clear, location: 0.4),
//            .init(color: .clear, location: 0.9)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )
    
    var body: some View {
        Image("Background")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay(
                ZStack(alignment: .bottom) {
                    Image("Background")
                        .resizable()
                        .blur(radius: 20) /// blur the image
                        .padding(-20) /// expand the blur a bit to cover the edges
                        .clipped() /// prevent blur overflow
                        .mask(gradient) /// mask the blurred image using the gradient's alpha values
                    
//                    gradient /// also add the gradient as an overlay (this time, the purple will show up)
                    
                    HStack {
                        Image("Icon") /// app icon
                            .resizable()
                            .frame(width: 64, height: 64)
                        
                        VStack(alignment: .leading) {
                            Text("Classroom of the Elite")
                                .bold()
                            Text("Horikita best girl")
                                .opacity(0.75)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading) /// allow text to expand horizontally
                        
                        Button { } label: {
                            Text("GET")
                                .bold()
                                .padding(8)
                                .background(Color.gray)
                                .cornerRadius(16)
                        }
                    }
                    .foregroundColor(.white)
                    .padding(20)
                }
            )
    }
}

#Preview {
    QueIsso()
}
