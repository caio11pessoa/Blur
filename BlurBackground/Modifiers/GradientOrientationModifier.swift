//
//  BackgroundBlurModifier.swift
//  BlurBackground
//
//  Created by Caio de Almeida Pessoa on 13/03/25.
//

import SwiftUI

import SwiftUI

struct GradientDirectionModifier: ViewModifier {
    var direction: GradientDirection

    func body(content: Content) -> some View {
        content
            .environment(\.gradientDirection, direction) // Passa a direção via Environment
    }
}

struct GradientDirectionKey: EnvironmentKey {
    static let defaultValue: GradientDirection = .bottomToTop // Valor padrão
}

extension EnvironmentValues {
    var gradientDirection: GradientDirection {
        get { self[GradientDirectionKey.self] }
        set { self[GradientDirectionKey.self] = newValue }
    }
}

extension BackgroundBlur {
    func orientation(_ direction: GradientDirection) -> some View {
        self.modifier(GradientDirectionModifier(direction: direction))
    }
}
