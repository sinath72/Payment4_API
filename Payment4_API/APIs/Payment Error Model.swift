//
//  Payment Error Model.swift
//  Payment4_API
//
//  Created by Macvps on 7/20/24.
//

import Foundation
struct PaymentErrorModels:Codable{
    let status: Bool
    let message: String
    let errorCode: Int
}
