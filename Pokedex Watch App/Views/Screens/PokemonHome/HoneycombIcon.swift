import SwiftUI

struct HoneycombIcon: Identifiable {
    let id = UUID()
    let color: Color
    let systemImage: String
}

struct HoneycombGridView: View {
    // Gerar ícones de teste
    private let icons: [HoneycombIcon] = (0..<40).map { index in
        HoneycombIcon(color: Color(hue: Double(index) / 40, saturation: 0.8, brightness: 0.9),
                      systemImage: "app.fill")
    }
    
    private let columns = 6
    private let spacing: CGFloat = 10
    private let size: CGFloat = 60
    
    var body: some View {
        ScrollView {
            VStack(spacing: spacing) {
                ForEach(rows(), id: \.self) { row in
                    HStack(spacing: spacing) {
                        if row.isOffset {
                            Spacer().frame(width: size / 2)
                        }
                        
                        ForEach(row.items) { icon in
                            Image(systemName: icon.systemImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: size * 0.6, height: size * 0.6)
                                .padding(10)
                                .background(icon.color)
                                .clipShape(Circle())
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color.black.ignoresSafeArea())
    }
    
    // MARK: - Grid Calculation
    private func rows() -> [HoneycombRow] {
        var result: [HoneycombRow] = []
        var temp: [HoneycombIcon] = []
        for (index, icon) in icons.enumerated() {
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

struct HoneycombRow: Hashable {
    let items: [HoneycombIcon]
    let isOffset: Bool
}

#Preview {
    HoneycombGridView()
}