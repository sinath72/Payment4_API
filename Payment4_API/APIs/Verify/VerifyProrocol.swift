//
//  VerifyProrocol.swift
//  Payment4_API
//
//  Created by Macvps on 7/23/24.
//

import Foundation
/// a Protocol Delegate's for Using Response of Payment Class's
///  - Parameters:
///   - onSuccedVerify: when successfully verify transaction and receive verify data from API
///   - onFaildVerifiing: when send data to API has faild
///   - onErrorVerifing: when API send error to user or developer
protocol VerifyProrocol{
    /// send data on successfully received response
    /// - Parameters:
    ///  - data: all data you nedded
    func onSuccedVerify(_ data:VerifyResponseModel)
    
    
    /// faild to send data for API for any reason not expected
    /// - Parameter msg: text of faild reason
    func onFaildVerifiing(_ msg:String)
    
    
    /// send data on server while send error messages
    /// - Parameter data: data sent from API like error title, error description, error code and transaction status
    func onErrorVerifing(_ data:ErrorExtractModels)
}
