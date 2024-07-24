//
//  VerifyProrocol.swift
//  Payment4_API
//
//  Created by Macvps on 7/23/24.
//

import Foundation
protocol VerifyProrocol{
    func onSuccedVerify(_ data:VerifyResponseModel)
    func onFaildVerifiing(_ msg:String)
    func onErrorVerifing(_ data:ErrorExtractModels)
}
