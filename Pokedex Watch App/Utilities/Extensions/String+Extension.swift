//
//  String+Extension.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 27/08/24.
//

import Foundation

extension String {
    func capitalizedFirstLetter() -> String {
        // Verifica se a string não está vazia
        guard !self.isEmpty else { return self }
        
        // Divide a string em duas partes: a primeira letra e o restante da string
        let firstLetter = self.prefix(1).uppercased()
        let remainingString = self.dropFirst()
        
        // Retorna a string com a primeira letra maiúscula
        return firstLetter + remainingString
    }
}
