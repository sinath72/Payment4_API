//
//  PaymentModel.swift
//  Payment4_API
//
//  Created by Macvps on 7/17/24.
//

import Foundation
/// a Model for Send Data from Yours to Payment Class's
///  - Parameters:
///   - amount: Value of Your User for Pay
///   - callbackParams :  Optional (include for internals app proccessing when back result from API)
///   - webhookParams:  Optional( like callbackParams Just Send Additional Parameters Along With the Webhook Notification)
///   - language: a Language's Selected from User for Translation Payment Page or Errors for User
///   - currencyName: a Currency 's Name Selected from User
///   - sandbox: Optional(by Default is False if Send True You can Test the API)
struct PaymentModel{
    /// Value of Your User for Pay
    let amount:Int
    /// Optional (include for internals app proccessing when back result from API)
    var callbackParams:[String:Any] = ["":""]
    /// Optional( like callbackParams Just Send Additional Parameters Along With the Webhook Notification)
    var webhookParams:[String:Any] = ["":""]
    /// a Language's Selected from User for Translation Payment Page or Errors for User
    let language:LanguagesName
    /// a Currency 's Name Selected from User
    let currencyName:CurrencyPaymentName
    /// Optional(by Default is False if Send True You can Test the API)
    var sandbox:Bool?
}
