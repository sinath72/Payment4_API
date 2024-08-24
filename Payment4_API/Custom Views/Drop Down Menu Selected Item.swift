//
//  Drop Down Menu Selected Item.swift
//  Payment4_API
//
//  Created by Macvps on 8/24/24.
//

import Foundation
class Selected_Items: ObservableObject{
    @Published var currency:CurrencyPaymentName = .none
    @Published var language:LanguagesName = .none
}
