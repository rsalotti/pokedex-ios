//
//  PokemonTypeView.swift
//  Pokedex Watch App
//
//  Created by Ricardo Salotti on 17/06/25.
//

import SwiftUI

///Uma opção do seletor radial. `type == nil` é a opção "todos os tipos", que limpa o filtro.
struct TypeOption {
    let type: PokemonType?

    var typeImage: Image {
        return type?.image ?? Image(systemName: "square.grid.2x2.fill")
    }

    var title: String {
        return type?.title ?? L10n.Common.allTypes
    }

    ///"Todos" na primeira posição, seguido pelos 18 tipos.
    static let all: [TypeOption] = [TypeOption(type: nil)] + PokemonType.allCases.map { TypeOption(type: $0) }
}

struct CircleTypeIconView: View {
    let icon: TypeOption

    var body: some View {
        icon.typeImage
            .resizable()
            .frame(width: 40, height: 40)
    }
}

struct PokemonTypeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PokemonTypeView(selectedType: .Fire) { _ in }
        }
    }
}

struct PokemonTypeView: View {
    let typeIcons: [TypeOption] = TypeOption.all
    ///Confirma a escolha para quem apresentou a tela. `nil` limpa o filtro.
    let onSelect: (PokemonType?) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var selectedIndex: Int
    @FocusState private var isCrownFocused: Bool
    @State private var crownRotation: Double

    init(selectedType: PokemonType?, onSelect: @escaping (PokemonType?) -> Void) {
        self.onSelect = onSelect
        //Abre a roda já posicionada no tipo que está filtrando a lista.
        let index = TypeOption.all.firstIndex { $0.type == selectedType } ?? 0
        _selectedIndex = State(initialValue: index)
        _crownRotation = State(initialValue: Double(index))
    }

    var body: some View {
        ZStack {
            circleTypesView
            selectedTypeView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.85))
        .focusable(true)
        .focused($isCrownFocused)
        .digitalCrownRotation($crownRotation, from: 0, through: Double(typeIcons.count - 1), by: 1, sensitivity: .low, isContinuous: true, isHapticFeedbackEnabled: true)
        .onChange(of: crownRotation) { newValue in
            let newIndex = wrappedIndex(for: newValue)
            if newIndex != selectedIndex {
                selectedIndex = newIndex
            }
        }
        .onAppear {
            //Sem o foco explícito a Digital Crown não recebe os eventos de rotação.
            isCrownFocused = true
        }
    }

    ///Ícone grande no centro: confirma a seleção e fecha a tela.
    @ViewBuilder
    private var selectedTypeView: some View {
        let option = typeIcons[selectedIndex]
        VStack(spacing: 2) {
            option.typeImage
                .resizable()
                .frame(width: 100, height: 100)
            Text(option.title)
                .font(.system(size: 13, weight: .semibold))
                .lineLimit(1)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onSelect(option.type)
            dismiss()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(option.title)
        .accessibilityHint(L10n.Filter.title)
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
                    crownRotation = Double(index)
                }
                .offset(x: CGFloat(cos(angle.radians)) * 86,
                        y: CGFloat(sin(angle.radians)) * 88)
                .accessibilityLabel(typeIcons[index].title)
        }
    }

    ///A coroa é contínua, então o valor pode passar do intervalo (inclusive para negativo).
    private func wrappedIndex(for rotation: Double) -> Int {
        let count = typeIcons.count
        let rounded = Int(rotation.rounded())
        return ((rounded % count) + count) % count
    }
}
