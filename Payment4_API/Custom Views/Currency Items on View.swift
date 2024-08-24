//
//  Currency Items on View.swift
//  Payment4_API
//
//  Created by Macvps on 8/24/24.
//

import Foundation
typealias CurrencyItems = (currency:[CurrencyViewItems],checked:[Bool])
enum CurrencyViewItems:String,CaseIterable{
    case usd = "US Dollar"
    case euro = "Euro"
    case gbp = "Biritish Pound"
    case irt = "Iranian Tomans"
    case TRY = "Turkish Lira"
    case aed = "UAE Dirham"
}
