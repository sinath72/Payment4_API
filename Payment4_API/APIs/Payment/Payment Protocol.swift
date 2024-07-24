//
//  Payment Protocol.swift
//  Payment4_API
//
//  Created by Macvps on 7/17/24.
//

import Foundation
protocol PaymentDelegates{
    func onSucced(_ data:PayResponseModel,_ currencyMark:CurrencyPayment,_ amount:Int,_ lang:LanguagesName)
    func onFaild(_ msg:String)
    func onError(_ data:ErrorExtractModels)
}
