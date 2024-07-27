//
//  VerifyResponseModel.swift
//  Payment4_API
//
//  Created by Macvps on 7/23/24.
//

import Foundation
struct VerifyResponseModel:Codable{
    var paymentStatus: String
    let amountDifference: String?
    let verified: Bool
}
