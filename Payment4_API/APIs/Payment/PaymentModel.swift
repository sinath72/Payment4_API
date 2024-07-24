//
//  PaymentModel.swift
//  Payment4_API
//
//  Created by Macvps on 7/17/24.
//

import Foundation
struct PaymentModel{
    let amount:Int
    let callbackParams:[String:Any] = ["":""]
    let webhookParams:[String:Any] = ["":""]
    let language:LanguagesName
    let currencyName:CurrencyPaymentName
    var sandbox:Bool?
}
