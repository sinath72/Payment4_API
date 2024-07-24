//
//  bodyModel.swift
//  Payment4_API
//
//  Created by Macvps on 7/17/24.
//

import Foundation
struct PaymentBodyModel{
    let amount:Int
    let callbackUrl:String
    let callbackParams:[String:Any]
    let webhoockUrl:String
    let webhookParams:[String:Any]
    let language:Languages
    let currencyMark:CurrencyPayment
    let sandbox:Bool
}
