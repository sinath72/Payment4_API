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
///    - errorCode: Optional(errorCode for contacting of Payment4 Support for why of your request has Error)
///    - description: describe your error message
struct ErrorExtractModels{
    /// status of verified transaction is true or false
    let status: Bool
    /// message for  why of your request has error
    let message: String
    /// Optional( errorCode for contacting of Payment4 Support for why of your request has Error)
    let errorCode: Int?
    /// describe your error message
    let description: String
}
