//
//  PayResponseModel.swift
//  Payment4_API
//
//  Created by Macvps on 7/20/24.
//

import Foundation
/// a Model for Deconding Payment Data When Successfully Receive Data
struct PayResponseModel:Codable{
    let id: Int
    let paymentUid: String
    let paymentUrl: String
}
