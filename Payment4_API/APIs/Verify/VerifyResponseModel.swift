//
//  VerifyResponseModel.swift
//  Payment4_API
//
//  Created by Macvps on 7/23/24.
//

import Foundation
/// a Model for Deconding Verify Data When Successfully Receive Data
/// - Parameters:
///  - paymentStatus: Show What's Your Transaction Status exp: ACCEPTABLE or PENDING or EXPIRED or MISMATCH
///  - amountDifference: Optional(Difference of Your Amount Request and User Payed Amount)
///  - verified: is Your Transaction Verified or Not as Boolean Type
struct VerifyResponseModel:Codable{
    /// Show What's Your Transaction Status exp: ACCEPTABLE or PENDING or EXPIRED or MISMATCH
    var paymentStatus: String
    ///Optional(Difference of Your Amount Request and User Payed Amount)
    let amountDifference: String?
    ///Optional(Difference of Your Amount Request and User Payed Amount)
    let verified: Bool
}
