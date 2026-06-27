//
//  ScheduleStatusBannerView.swift
//  Island Now
//
//  欠航・遅延確認の共通バナー（日英併記）
//

import SwiftUI

struct ScheduleStatusBannerView: View {
    let sources: [ScheduleStatusSource]

    @Environment(\.detailPalette) private var palette

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label {
                VStack(alignment: .leading, spacing: 4) {
                    Text("欠航・遅延")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text("Delays & Cancellations")
                        .font(.caption)
                        .fontWeight(.medium)
                }
            } icon: {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundStyle(palette.warning)
            }

            Text("出発前に各社公式サイトで運航状況を確認してください。本アプリの時刻は参考ダイヤです。")
                .font(.caption)
                .detailCardSecondaryText()

            Text("Check official websites before you travel. This app shows sample timetables only.")
                .font(.caption)
                .detailCardSecondaryText()

            ForEach(sources) { source in
                sourceLinks(source)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(palette.bannerBackground)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(palette.warning.opacity(0.35), lineWidth: 1)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    @ViewBuilder
    private func sourceLinks(_ source: ScheduleStatusSource) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(source.name)
                .font(.caption)
                .fontWeight(.semibold)
                .detailCardSecondaryText()

            OpenURLButton(url: source.statusPageURL) {
                Label(statusButtonTitle(for: source.category), systemImage: statusIcon(for: source.category))
                    .font(.subheadline)
            }

            if let phoneURL = source.phoneURL, let phoneNumber = source.phoneNumber {
                OpenURLButton(url: phoneURL) {
                    Label("運航問い合わせ / Call: \(phoneNumber)", systemImage: "phone.fill")
                        .font(.caption)
                }
            }
        }
    }

    private func statusButtonTitle(for category: ScheduleStatusSource.Category) -> String {
        switch category {
        case .ferry:
            return "運航状況 / Service Status"
        case .flight:
            return "運航状況 / Flight Status"
        }
    }

    private func statusIcon(for category: ScheduleStatusSource.Category) -> String {
        switch category {
        case .ferry:
            return "ferry.fill"
        case .flight:
            return "airplane"
        }
    }
}

#Preview {
    ScheduleStatusBannerView(sources: [
        ScheduleStatusSource(
            id: "https://www.tokaikisen.co.jp/schedule/",
            name: "東海汽船株式会社",
            statusPageURL: URL(string: "https://www.tokaikisen.co.jp/schedule/")!,
            phoneNumber: "03-5472-9999",
            category: .ferry
        ),
    ])
    .padding()
    .detailSectionCard()
}
