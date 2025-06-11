//
//  SkeletonCellView.swift
//  Pokedex
//
//  Created by Ricardo Santos on 22/10/24.
//
import SwiftUI

struct SkeletonCellView: View {
    let primaryColor = Color.gray
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            primaryColor
                .frame(width: 40, height: 40)
                .cornerRadius(2)
            
            primaryColor
                .frame(height: 20)
                .cornerRadius(2)
        }
        .blinking(duration: 0.75)
        .padding()
    }
}

#Preview {
    SkeletonCellView()
}
