//
//  PokemonTypeView.swift
//  Pokedex Watch App
//
//  Created by Ricardo Salotti on 17/06/25.
//

import SwiftUI

struct CircleIconView: View {
    let icon: TypeIcon
    
    var body: some View {
        Image(systemName: icon.systemName)
            .resizable()
            .foregroundColor(.white)
            .frame(width: 20, height: 20)
            .padding(8)
            .background(Circle().fill(icon.color))
    }
}

struct TypeIcon {
    let systemName: String // Substitua por nome da imagem correta
    let color: Color
    
    static let all: [TypeIcon] = [
        .init(systemName: "bolt.fill", color: .yellow),
        .init(systemName: "flame.fill", color: .orange),
        .init(systemName: "drop.fill", color: .blue),
        // Adicione os outros tipos aqui
    ]
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
    
    var body: some View {
        ZStack {
            // Ícones ao redor em círculo
            ForEach(0..<typeIcons.count, id: \.self) { index in
                let angle = Angle(degrees: Double(index) / Double(typeIcons.count) * 360)
                CircleIconView(icon: typeIcons[index])
                    .shadow(color: .white.opacity(0.3), radius: 4)
                    .offset(x: CGFloat(cos(angle.radians)) * 80,
                            y: CGFloat(sin(angle.radians)) * 80)
            }
            
            VStack(spacing: 8) {
                // Ícone central
                Image(systemName: "leaf.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .padding(20)
                    .background(Circle().fill(Color.green))
                    .overlay(Circle().stroke(Color.white.opacity(0.2), lineWidth: 2))
                
                Text("Grass")
                    .font(.headline)
                    .foregroundColor(.white)
                .padding(.bottom, 10)
            }
        }
        .frame(width: 180, height: 180)
        .background(Color.black.opacity(0.85))
    }
}
