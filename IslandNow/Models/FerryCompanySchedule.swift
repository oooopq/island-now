//
//  FerryCompanySchedule.swift
//  Island Now
//
//  運営会社1社分のフェリーダイヤ
//

import Foundation

struct FerryCompanySchedule: Identifiable, Codable {
    let id: String
    let company: FerryCompany
    let trips: [FerryTrip]
}
