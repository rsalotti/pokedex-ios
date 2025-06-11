//
//  HoneycombIcon.swift
//  Pokedex
//
//  Created by Ricardo Salotti on 10/06/25.
//

import SwiftUI

struct HoneycombGridView: View {
    @State private var zoom: CGFloat = 1.0

    var body: some View {
        GeometryReader { geo in
            ScrollView([.vertical, .horizontal]) {
                VStack(spacing: 10) {
                    ForEach(Array(rows().enumerated()), id: \.offset) { _, row in
                        HStack(spacing: 10) {
                            if row.isOffset {
                                Spacer().frame(width: 30)
                            }

                            ForEach(row.items) { icon in
                                Image(systemName: icon.systemImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 36, height: 36)
                                    .padding(6)
                                    .background(icon.color)
                                    .clipShape(Circle())
                            }
                        }
                    }
                }
                .scaleEffect(zoom)
                .focusable(true) // habilita uso da Crown
                .digitalCrownRotation($zoom, from: 0.5, through: 2.0, by: 0.01, sensitivity: .medium, isContinuous: true, isHapticFeedbackEnabled: true)
            }
        }
    }

    private func rows() -> [HoneycombRow] {
        let icons: [HoneycombIcon] = (0..<60).map { index in
            HoneycombIcon(
                color: Color(hue: Double(index) / 60, saturation: 0.8, brightness: 0.9),
                systemImage: "app.fill"
            )
        }

        let columns = 5
        var result: [HoneycombRow] = []
        var temp: [HoneycombIcon] = []

        for icon in icons {
            temp.append(icon)
            if temp.count == columns {
                result.append(HoneycombRow(items: temp, isOffset: result.count % 2 == 1))
                temp = []
            }
        }

        if !temp.isEmpty {
            result.append(HoneycombRow(items: temp, isOffset: result.count % 2 == 1))
        }

        return result
    }
}

struct HoneycombIcon: Identifiable {
    let id = UUID()
    let color: Color
    let systemImage: String
}

struct HoneycombRow {
    let items: [HoneycombIcon]
    let isOffset: Bool
}
