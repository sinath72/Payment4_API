//
//  Payment Error Model.swift
//  Payment4_API
//
//  Created by Macvps on 7/20/24.
//

import Foundation
/// a Model for Decode Error API Response
struct ErrorModels:Codable{
    let status: Bool
    let message: String
    let errorCode: Int?
}
/// a Model for Send Error API Response With Descriptions to User or Developer
/// - Parameters:
///    - status: status of verified transaction is true or false
///    - message: message for  why of your request has error
///    - errorCode: errorCode for contacting of Payment4 Support for why of your request has Error
///    - description: describe your error message
struct ErrorExtractModels{
    let status: Bool
    let message: String
    let errorCode: Int?
    let description: String
}
