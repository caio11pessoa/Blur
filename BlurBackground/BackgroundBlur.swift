//
//  BackgroundBlur.swift
//  BlurBackground
//
//  Created by Caio de Almeida Pessoa on 13/03/25.
//

import SwiftUI

enum GradientDirection {
    case topToBottom
    case bottomToTop
}

///Use com ignoreSafeArea
struct BackgroundBlur<Content: View>: View {
    @State private var viewSize: CGSize = .zero
    @State private var contentSize: CGSize = .zero
    @Environment(\.gradientDirection) private var gradientDirection // Agora pode ser alterado

    var blurPercentage: CGFloat {
        guard viewSize.height > 0 else { return 0.45 } // Evita divisão por zero
        return contentSize.height / viewSize.height
    }
    
    var blurPercentageFinished: CGFloat {
        min(blurPercentage + 0.1, 1) // Garante que não ultrapasse 1
    }
    
    var gradientDown: LinearGradient {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: .black, location: 0),
                .init(color: .black, location: blurPercentage),
                .init(color: .clear, location: blurPercentageFinished)
            ]),
            startPoint: .bottom,
            endPoint: .top
        )
    }
    
    var gradientUp: LinearGradient {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: .black, location: 0),
                .init(color: .black, location: blurPercentage),
                .init(color: .clear, location: blurPercentageFinished)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    let content: Content
    let image: Image
    
    init(_ image: Image, @ViewBuilder content: @escaping () -> Content) {
        self.image = image
        self.content = content()
    }
    
    var getZstackAlignment: Alignment {
        switch gradientDirection {
        case .topToBottom:
            .top
        case .bottomToTop:
            .bottom
        }
    }
    
    var getGradientMask: LinearGradient {
        switch gradientDirection {
        case .topToBottom:
            gradientUp
        case .bottomToTop:
            gradientDown
        }
    }
    
    var body: some View {
        ZStack(alignment: getZstackAlignment) {
            image
                .resizable()
            Image(.wallPaper)
                .resizable()
                .blur(radius: 25)
                .padding(-35)
                .clipped()
                .mask(getGradientMask)
            content
                .background(
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                contentSize = geometry.size
                            }
                            .onChange(of: geometry.size) { oldSize, newSize in
                                if oldSize != newSize {
                                    withAnimation {
                                        contentSize = newSize
                                    }
                                }
                            }
                    }
                )
        }
        .background(
            GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        viewSize = geometry.size
                    }
                    .onChange(of: geometry.size) { oldSize, newSize in
                        if oldSize != newSize {
                            withAnimation {
                                viewSize = newSize
                            }
                        }
                    }
            }
        )
    }
}


#Preview {
    BackgroundBlur(background: Image(.wallPaper)) {
        VStack{
            ScrollView {
                Text("Content!")
                Text("Content!")
                Text("Content!")
                Text("Content!")
                Text("Content!")
                Text("Content!")
                Text("Content!")
                Text("Content!")
                Text("Content!")
                Text("Content!")
                Text("Content!")
                Text("Content!")
            }
            .foregroundStyle(.white)
            .frame(height: 300)
            
        }
    }
    .ignoresSafeArea()
}
