//
//  Payment Protocol.swift
//  Payment4_API
//
//  Created by Macvps on 7/17/24.
//

import Foundation
/// a type for sending data to display to user or manage actions
/// - Parameters:
///  -  paymentResponse: all data sent from API
///  - currencyMark: send user selected currency mark for send for verifying transaction
///  - amount: send user amount payed for verifying transaction
///  - languages: send user language selected name for pass on verifying transacion on error localization while verifying transaction
typealias paymentSuccessResponseModel = (paymentResponse:PayResponseModel,currencyMark:CurrencyPayment,amount:Int,languages:LanguagesName)

/// a Protocol Delegate's for Using Response of Payment Class's
///  - Parameters:
///   - onSuccess: when successfully receive data
///   - onFaild: when send data to API has faild
///   - onError: when API send error to user or developer
protocol PaymentDelegates{
    /// send data on successfully received response
    /// - Parameters:
    ///  - data: all data you nedded
    func onSucced(_ data:paymentSuccessResponseModel)
    
    
    /// faild to send data for API for any reason not expected
    /// - Parameter msg: text of faild reason
    func onFaild(_ msg:String)
    
    
    /// send data on server while send error messages
    /// - Parameter data: data sent from API like error title, error description, error code and transaction status
    func onError(_ data:ErrorExtractModels)
}
