import SwiftUI

enum GradientDirection {
    case topToBottom
    case bottomToTop
}

struct CustomImage {
    let image: Image
    let aspectRatio: ContentMode
    
}

/// Use com `ignoresSafeArea`
struct BackgroundBlur<Content: View>: View {
    @State private var containerSize: CGSize = .zero
    @State private var contentSize: CGSize = .zero
    private var contentMode: ContentMode = .fill
    @Environment(\.gradientDirection) private var gradientDirection
    
    var blurCoverageRatio: CGFloat {
        guard containerSize.height > 0 else { return 0.45 }
        return contentSize.height / containerSize.height
    }
    
    var blurCoverageEndRatio: CGFloat {
        min(blurCoverageRatio + 0.1, 1)
    }
    
    var bottomToTopGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: .black, location: 0),
                .init(color: .black, location: blurCoverageRatio),
                .init(color: .clear, location: blurCoverageEndRatio)
            ]),
            startPoint: .bottom,
            endPoint: .top
        )
    }
    
    var topToBottomGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: .black, location: 0),
                .init(color: .black, location: blurCoverageRatio),
                .init(color: .clear, location: blurCoverageEndRatio)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    let content: Content
    let backgroundImage: Image
    
    init(_ backgroundImage: Image, @ViewBuilder content: @escaping () -> Content) {
        self.backgroundImage = backgroundImage
        self.content = content()
    }
    
    init(_ customImage: CustomImage, @ViewBuilder content: @escaping () -> Content) {
        self.backgroundImage = customImage.image
        self.contentMode = customImage.aspectRatio
        self.content = content()
    }
    
    var zStackAlignment: Alignment {
        switch gradientDirection {
        case .topToBottom:
            return .top
        case .bottomToTop:
            return .bottom
        }
    }
    
    var gradientMask: LinearGradient {
        switch gradientDirection {
        case .topToBottom:
            return topToBottomGradient
        case .bottomToTop:
            return bottomToTopGradient
        }
    }
    
    var body: some View {
        ZStack(alignment: zStackAlignment) {
            backgroundImage
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .frame(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            backgroundImage
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .blur(radius: 25)
                .padding(-35)
                .clipped()
                .mask(gradientMask)
                .frame(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )
            
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
                        containerSize = geometry.size
                    }
                    .onChange(of: geometry.size) { oldSize, newSize in
                        if oldSize != newSize {
                            withAnimation {
                                containerSize = newSize
                            }
                        }
                    }
            }
        )
    }
}

#Preview {
    BackgroundBlur(Image(.background)) {
        VStack {
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
