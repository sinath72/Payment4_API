//
//  CurrencyPayment.swift
//  Payment4_API
//
//  Created by Macvps on 7/17/24.
//

import Foundation
/// All Currency Name Supported with Payment4 for Displaying in a View like Currencies_Swiftui View
enum CurrencyPaymentName:String,CaseIterable{
    case none = ""
    case usd = "US Dollar"
    case euro = "Euro"
    case gbp = "Biritish Pound"
    case irt = "Iranian Tomans"
    case TRY = "Turkish Lira"
    case aed = "UAE Dirham"
}
///Abbreviation Each of Selected Currency Name for Sendding to API
enum CurrencyPayment:String,CaseIterable{
    case none = ""
    case usd = "USD"
    case euro = "EUR"
    case gbp = "GBP"
    case irt = "IRT"
    case TRY = "TRY"
    case aed = "AED"
}
/// Return Count of All Currencies in Enum of CurrencyPaymentName
func getCurrencyPaymentNameCount() -> Int{
    CurrencyPaymentName.allCases.count
}
/// Return Count of All Currencies in Enum of CurrencyPayment
func getCurrencyPaymentCount() -> Int{
    CurrencyPayment.allCases.count
}
