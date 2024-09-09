//
//  VerifyModel.swift
//  Payment4_API
//
//  Created by Macvps on 7/23/24.
//

import Foundation
/// a Model for Send Data from Yours to Verify Class's
/// - Parameters:
///  - paymentUid: a Uniqe ID of Your Transaction on Recived at Payment Request from API
///  - amount: amount of Your Transaction Want to Verify
///  - currency: Currency Mark of Transaction in PaymentDelegate at onSucced data
struct VerifyModel{
    let paymentUid:String
    let amount:Int
    let currency:CurrencyPayment
}
