//
//  Payment.swift
//  Payment4_API
//
//  Created by Macvps on 7/17/24.
//

import Foundation
class Payment {
    /// a Delegate for Sendding Data Statement Request to Other Class's or View's Delegated
    var delegate:PaymentDelegates?
    var language:LanguagesName = .english
    let translate = Translete()
    //// All Necessary Data's for Requesting to API
    var payment4:Payment4
    /// initialize Payment Method
    /// - Parameter apiKeyModel: Receive API Key and All Data's Necessary Model on Payment 4 Dashboard and Pass it
    init(apiKeyModel: Payment4) {
        self.payment4 = apiKeyModel
    }
    /// Change Language Name to Currency Mark exp: US Dollar to usd
    /// - Parameter language: Language of User Selected in View
    private func languageMarks(_ language:LanguagesName) -> Languages{
        switch language{
        case .arabic:
            return .arabic
        case .english:
            return .english
        case .farsi:
            return .farsi
        case .french:
            return .french
        case .spanish:
            return .spanish
        case .turkey:
            return .turkey
        case .none:
            return .none
        }
    }
    /// Change Currency Name to Language Mark exp: English to en
    /// - Parameter currency: Currency of User Selected iin View
    private func currencyMarks(_ currency:CurrencyPaymentName) -> CurrencyPayment{
        switch currency {
        case .usd:
            return .usd
        case .euro:
            return .euro
        case .gbp:
            return .gbp
        case .irt:
            return .irt
        case .TRY:
            return .TRY
        case .aed:
            return .aed
        case .none:
            return .none
        }
    }
    /// Send Request for Receive Response for Payment Details from API
    /// - Parameters:
    ///  - data: Send a Model of PaymentModel for Request to API and Recive Your Payment info for Pay as You GO
    func pay(_ data:PaymentModel){
        var sandbox = true
        //sandbox on data receive from developer by default is nil
        if data.sandbox == nil{
            sandbox = false
        }
        let languageMark:Languages = languageMarks(data.language)
        let currencyMark:CurrencyPayment = currencyMarks(data.currencyName)
        let bodyModel = PaymentBodyModel(amount: data.amount, callbackUrl: payment4.callbackUrl,callbackParams: data.callbackParams, webhoockUrl: payment4.webhoockUrl, webhookParams: data.webhookParams, language: languageMark, currencyMark: currencyMark,sandbox: sandbox)
        let body = bodyArgs(bodyModel)
        let header = headerArgs()
        let url = getUrl()
        self.language = data.language
        guard let body = body else { self.delegate?.onFaild(translate.getFaildErrorTranslation(1,self.language));return }
        let request = getRequest(body, header, url)
        let seassion = getSeassion()
        let task = seassion.dataTask(with: request) { [self] (data, response, error) in
            if error == nil{
                let statusCode = (response as! HTTPURLResponse).statusCode
                if statusCode == 200 || statusCode == 201{
                    /*
                     if all parameters is true and receive data from API send data like url for payment
                     as model PayResponseModel to programmer with delegate's method for handle it
                     */
                    guard let data = data else { self.delegate?.onFaild(translate.getFaildErrorTranslation(2, self.language)); return}
                    do{
                        let modularData = try JSONDecoder().decode(PayResponseModel.self, from: data)
                        let similarModel = (modularData,currencyMark,bodyModel.amount,self.language)
                        self.delegate?.onSucced(similarModel)
                    }
                    catch{
                        self.delegate?.onFaild(translate.getFaildErrorTranslation(3, self.language))
                    }
                }
                else{
                    if statusCode == 400{
                        /*
                         if one or more parameter(s) is wrong receive error from API send data like error title , error description and etc... and translation error to language passed in parameters in first for error as model ErrorExtractModels to programmer with delegate's method for handle it
                         */
                        guard let data = data else { self.delegate?.onFaild(translate.getFaildErrorTranslation(2, language)); return}
                        do{
                            let modularData = try JSONDecoder().decode(ErrorModels.self, from: data)
                            let translatedError = translate.getAPITranslationError(modularData.errorCode, bodyModel.language)
                            let model = ErrorExtractModels(status: modularData.status, message: translatedError.errorTitle, errorCode: modularData.errorCode, description: translatedError.message)
                            self.delegate?.onError(model)
                        }
                        catch{
                            self.delegate?.onFaild(translate.getFaildErrorTranslation(3, self.language))
                        }
                    }
                    else{
                        //if received not expected statusCode show error in language parameter passed at first
                        self.delegate?.onFaild(translate.getFaildErrorTranslation(4, self.language))
                    }
                }
            }
            else{
                self.delegate?.onFaild(error!.localizedDescription)
            }
        }
        task.resume()
    }
    /// Create Header Argumented for  pass on API
    private func headerArgs() -> [String:String]{
        [
            "x-api-key": payment4.apiKey,
            "Content-Type": "application/json"
        ]
    }
    /// Create Body Arguments for pass on API
    /// - Parameter data: Send Body Request Parameter as a PaymentBodyModel Model
    private func bodyArgs(_ data:PaymentBodyModel) -> Data?{
        let jsonBodyData = [
            "amount": data.amount,
            "callbackUrl": data.callbackUrl,
            "callbackParams": data.callbackParams,
            "webhookUrl": data.webhoockUrl,
            "webhookParams": data.webhookParams,
            "language": data.language.rawValue.uppercased(),
            "currency": data.currencyMark.rawValue.uppercased(),
            "sandBox": data.sandbox
        ] as [String:Any]
        guard let data = try? JSONSerialization.data(withJSONObject: jsonBodyData,options: []) else { self.delegate?.onFaild(translate.getFaildErrorTranslation(5, self.language));return nil}
        return data
    }
    /// Create URL for use on Request's
    private func getUrl() -> URL{
        URL(string: "https://service.payment4.com/api/v1/payment")!
    }
    /// Create Request's for send Data to API
    /// - Parameters:
    ///  - body: Send Body of Request for Creation URLRequest for Using API
    ///  - header: Send Header of Request for Creation URLRequest for Using API
    ///  - url: Send URL of Request for Creation URLRequest for Using API
    private func getRequest(_ body:Data,_ header:[String:String],_ url:URL) -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = header
        request.httpBody = body as Data
        return request
    }
    /// Create Seassion for Handle Send API Request's
    private func getSeassion() -> URLSession{
        URLSession(configuration: URLSessionConfiguration.default)
    }
}
