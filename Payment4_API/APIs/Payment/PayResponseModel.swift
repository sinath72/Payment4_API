//
//  PayResponseModel.swift
//  Payment4_API
//
//  Created by Macvps on 7/20/24.
//

import Foundation
/// a Model for Deconding Payment Data When Successfully Receive Data
/// - Parameters:
///  - id: Your Transaction ID Please Save on Your DB
///  - paymentUid: Your Transaction Uniqe ID for Payment Please Save on Your DB
///  - paymentUrl: Your URL for Transfer User on to that for Pay
struct PayResponseModel:Codable{
    /// Your Transaction ID Please Save on Your DB
    let id: Int
    /// Your Transaction Uniqe ID for Payment Please Save on Your DB
    let paymentUid: String
    /// Your URL for Transfer User on to that for Pay
    let paymentUrl: String
}
