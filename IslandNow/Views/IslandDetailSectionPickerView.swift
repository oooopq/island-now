//
//  IslandDetailSectionPickerView.swift
//  Island Now
//
//  島詳細画面のセクション切り替え（アイコン）
//

import SwiftUI

struct IslandDetailSectionPickerView: View {
    @Binding var selection: IslandDetailSection

    @Environment(\.detailPalette) private var palette
    @Namespace private var selectionNamespace

    var body: some View {
        HStack(spacing: 4) {
            ForEach(IslandDetailSection.allCases) { section in
                sectionButton(section)
            }
        }
        .padding(5)
        .background { pickerBackground }
    }

    private var pickerBackground: some View {
        RoundedRectangle(cornerRadius: 18, style: .continuous)
            .fill(palette.cardBackground.opacity(0.72))
            .background {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(.ultraThinMaterial)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .strokeBorder(rainbowBorderGradient, lineWidth: 1.5)
            }
            .shadow(color: palette.cardShadow, radius: 12, y: 5)
    }

    private var rainbowBorderGradient: LinearGradient {
        LinearGradient(
            colors: IslandDetailSection.allCases.map(\.iconColor),
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    private func sectionButton(_ section: IslandDetailSection) -> some View {
        let isSelected = selection == section

        return Button {
            withAnimation(.spring(response: 0.34, dampingFraction: 0.78)) {
                selection = section
            }
        } label: {
            VStack(spacing: 6) {
                ZStack {
                    Circle()
                        .fill(
                            isSelected
                                ? AnyShapeStyle(Color.white.opacity(0.22))
                                : AnyShapeStyle(section.iconColor.opacity(0.22))
                        )
                        .frame(width: 34, height: 34)

                    Image(systemName: section.systemImage)
                        .font(.system(size: 16, weight: .bold))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            isSelected ? Color.white : section.iconColor,
                            isSelected ? Color.white.opacity(0.75) : section.iconColor.opacity(0.55)
                        )
                        .scaleEffect(isSelected ? 1.08 : 1.0)
                }
                .frame(height: 34)

                Text(section.title)
                    .font(.system(size: 10, weight: isSelected ? .bold : .semibold))
                    .foregroundStyle(isSelected ? Color.white : section.iconColor.opacity(0.92))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background {
                if isSelected {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(section.tabGradient)
                        .overlay {
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .strokeBorder(Color.white.opacity(0.28), lineWidth: 1)
                        }
                        .shadow(color: section.iconColor.opacity(0.55), radius: 8, y: 3)
                        .matchedGeometryEffect(id: "sectionTabPill", in: selectionNamespace)
                } else {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(section.iconColor.opacity(0.12))
                        .overlay {
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .strokeBorder(section.iconColor.opacity(0.28), lineWidth: 1)
                        }
                }
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel(section.title)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview("ダーク") {
    IslandDetailSectionPickerView(selection: .constant(.schedule))
        .padding()
        .background {
            LinearGradient(
                colors: [Color(red: 0.05, green: 0.18, blue: 0.32), Color(red: 0.02, green: 0.08, blue: 0.16)],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .environment(\.detailPalette, DetailCardPalette.dark)
}

#Preview("ライト") {
    IslandDetailSectionPickerView(selection: .constant(.savedPhotos))
        .padding()
        .background(Color(red: 0.92, green: 0.95, blue: 0.98))
        .environment(\.detailPalette, DetailCardPalette.light)
}
