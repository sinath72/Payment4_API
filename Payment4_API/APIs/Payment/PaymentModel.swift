//
//  PaymentModel.swift
//  Payment4_API
//
//  Created by Macvps on 7/17/24.
//

import Foundation
struct PaymentModel{
    let amount:Int
    var callbackParams:[String:Any] = ["":""]
    var webhookParams:[String:Any] = ["":""]
    let language:LanguagesName
    let currencyName:CurrencyPaymentName
    var sandbox:Bool?
}
