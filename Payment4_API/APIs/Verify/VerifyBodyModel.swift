//
//  VerifyBodyModel.swift
//  Payment4_API
//
//  Created by Macvps on 9/10/24.
//

import Foundation
///a Model for Sendding Data to Body Creator Function foe Send Request to API in Verify Class
/// - Parameters:
///  - paymentUid: a Uniqe ID of Your Transaction on Recived at Payment Request from API
///  - amount: amount of Your Transaction Want to Verify
///  - currency: Currency Mark of Transaction in PaymentDelegate at onSucced data  
struct VerifyBodyModel{
    /// a Uniqe ID of Your Transaction on Recived at Payment Request from API
    var paymentUid:String
    /// amount of Your Transaction Want to Verify
    var amount:Int
    /// Currency Mark of Transaction in PaymentDelegate at onSucced data
    var currency:CurrencyPayment
}
