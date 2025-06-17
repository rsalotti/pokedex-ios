//
//  PokemonTypeView.swift
//  Pokedex Watch App
//
//  Created by Ricardo Salotti on 17/06/25.
//

import SwiftUI

struct CircleTypeIconView: View {
    let icon: TypeIcon
    
    var body: some View {
        icon.typeImage
            .resizable()
            .frame(width: 40, height: 40)
    }
}

struct TypeIcon {
    let typeImage: Image
    
    static let all: [TypeIcon] = PokemonType.allCases.map { type in
            .init(typeImage: type.image)
    }
}

struct PokemonTypeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PokemonTypeView()
                .previewDevice("Apple Watch Series 7 - 45mm")
        }
    }
}

struct PokemonTypeView: View {
    let typeIcons: [TypeIcon] = TypeIcon.all
    @State private var selectedIndex: Int = 0
    @State private var selectedTypeIcon: Image = Image("Bug")
    @FocusState private var isCrownFocused: Bool
    @State private var crownRotation: Double = 0.0

    var body: some View {
        ZStack {
            circleTypesView
            selectedTypeIcon
                .resizable()
                .frame(width: 120, height: 120)
                .onTapGesture {
                    print("Tapped Icon Center")
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.85))
        .focusable(true)
        .focused($isCrownFocused)
        .digitalCrownRotation($crownRotation, from: 0, through: Double(typeIcons.count - 1), by: 1, sensitivity: .low, isContinuous: true, isHapticFeedbackEnabled: true)
        .onChange(of: crownRotation) { newValue in
            let newIndex = Int(round(newValue)) % typeIcons.count
            if newIndex != selectedIndex {
                selectedIndex = newIndex
                selectedTypeIcon = typeIcons[newIndex].typeImage
            }
        }
    }

    @ViewBuilder
    private var circleTypesView: some View {
        ForEach(0..<typeIcons.count, id: \.self) { index in
            let angle = Angle(degrees: Double(index) / Double(typeIcons.count) * 360)
            
            CircleTypeIconView(icon: typeIcons[index])
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: selectedIndex == index ? 1 : 0)
                        .frame(width: 29, height: 29)
                )
                .onTapGesture {
                    selectedIndex = index
                    selectedTypeIcon = typeIcons[index].typeImage
                }
                .offset(x: CGFloat(cos(angle.radians)) * 86,
                        y: CGFloat(sin(angle.radians)) * 88)
        }
    }
}
