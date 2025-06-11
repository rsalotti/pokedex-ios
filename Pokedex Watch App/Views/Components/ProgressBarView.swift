//
//  ProgressBarView.swift
//  Pokedex
//
//  Created by Ricardo Salotti on 11/06/25.
//


import SwiftUI

struct ProgressBarView: View {
    var title: String = ""
    var value: CGFloat
    var maxValue: CGFloat = 255
    var barColor: Color = .green
    var height: CGFloat = 8
    var animationDuration: Double = 0.6

    @State private var animatedValue: CGFloat = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            if !title.isEmpty {
                Text(title)
                    .font(.system(size: 10, weight: .semibold))
            }
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .frame(height: height)
                        .foregroundColor(.gray.opacity(0.2))

                    Capsule()
                        .frame(width: progressWidth(in: geo.size.width), height: height)
                        .foregroundColor(barColor)
                        .animation(.easeOut(duration: animationDuration), value: animatedValue)
                }
            }
            .frame(height: height)
        }
        .onAppear {
            animateToTarget()
        }
        .onChange(of: value) { _ in
            animateToTarget()
        }
    }

    private func progressWidth(in totalWidth: CGFloat) -> CGFloat {
        let clampedValue = min(max(animatedValue, 0), maxValue)
        return (clampedValue / maxValue) * totalWidth
    }

    private func animateToTarget() {
        animatedValue = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            animatedValue = value
        }
    }
}
