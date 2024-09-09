//
//  Verify.swift
//  Payment4_API
//
//  Created by Macvps on 7/23/24.
//

import Foundation
class Verify{
    /// a Delegate for Sendding Data Statement Request to Other Class's or View's Delegated
    var delegate:VerifyProrocol?
    var language:LanguagesName = .english
    let translate = Translete()
    var payment4:Payment4
    /// initialize Verify Method
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
    /// Send Request for Verify Transaction and Receive Response from API
    /// - Parameters:
    ///  - data: Send a Model of VerifyModel for Request Verify Transaction With that Parameters
    ///  - lang: Language for if Error on Your Verify Request
    func getVerify(_ data:VerifyModel,_ lang:LanguagesName){
        self.language = lang
        let languageMark = languageMarks(lang)
        let body = bodyArgs(data)
        let header = headerArgs()
        let url = getUrl()
        guard let body = body else { self.delegate?.onFaildVerifiing(translate.getFaildErrorTranslation(1, self.language));return }
        let request = getRequest(body, header, url)
        let seassion = getSeassion()
        let task = seassion.dataTask(with: request) { [self] data, response, error in
            if error == nil{
                let statusCode = (response as! HTTPURLResponse).statusCode
                if statusCode == 200 || statusCode == 201{
                    /*
                     if all parameters is true and receive data from API send data like paymentStatus,verified
                     as model VerifyResponseModel to programmer with delegate's method for handle it
                     */
                    guard let data = data else { self.delegate?.onFaildVerifiing(translate.getFaildErrorTranslation(2, self.language)); return}
                    do{
                        var modularData = try JSONDecoder().decode(VerifyResponseModel.self, from: data)
                        modularData.paymentStatus = translate.getTranslatePaymentStatusonVerify(modularData.paymentStatus, self.language)
                        self.delegate?.onSuccedVerify(modularData)
                    }
                    catch{
                        self.delegate?.onFaildVerifiing(translate.getFaildErrorTranslation(3, self.language))
                    }
                }
                else {
                    if statusCode == 400{
                        /*
                         if one or more parameter(s) is wrong receive error from API send data like error title , error description and etc... and translation error to language passed in parameters in first for error as model ErrorExtractModels to programmer with delegate's method for handle it
                         */
                        guard let data = data else { self.delegate?.onFaildVerifiing(translate.getFaildErrorTranslation(2, language)); return}
                        do{
                            let modularData = try JSONDecoder().decode(ErrorModels.self, from: data)
                            let translatedError = translate.getAPITranslationError(modularData.errorCode, languageMark)
                            let model = ErrorExtractModels(status: modularData.status, message: translatedError.errorTitle, errorCode: modularData.errorCode, description: translatedError.message)
                            self.delegate?.onErrorVerifing(model)
                        }
                        catch{
                            //if received not expected statusCode show error in language parameter passed at first
                            self.delegate?.onFaildVerifiing(translate.getFaildErrorTranslation(3, self.language))
                        }
                    }
                    else{
                        self.delegate?.onFaildVerifiing(translate.getFaildErrorTranslation(4, self.language))
                    }
                }
            }
            else if let error = error{
                self.delegate?.onFaildVerifiing(error.localizedDescription)
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
    /// - Parameter data: Send Body Request Parameter as a VerifyModel Model or First data on getVerify Function
    private func bodyArgs(_ data:VerifyModel) -> Data?{
        let jsonBodyData = [
            "paymentUid": data.paymentUid,
            "amount": data.amount,
            "currency": data.currency.rawValue
        ] as [String:Any]
        guard let data = try? JSONSerialization.data(withJSONObject: jsonBodyData,options: []) else { self.delegate?.onFaildVerifiing(translate.getFaildErrorTranslation(5, self.language));return nil}
        return data
    }
    /// Create URL for use on Request's
    private func getUrl() -> URL{
        URL(string: "https://service.payment4.com/api/v1/payment/verify")!
    }
    /// Create Request's for send Data to API
    /// - Parameters:
    ///  - body: Send Body of Request for Creation URLRequest for Using API
    ///  - header: Send Header of Request for Creation URLRequest for Using API
    ///  - url: Send URL of Request for Creation URLRequest for Using API
    private func getRequest(_ body:Data,_ header:[String:String],_ url:URL) -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = header
        request.httpBody = body as Data
        return request
    }
    /// Create Seassion for Handle Send API Request's
    private func getSeassion() -> URLSession{
        URLSession(configuration: URLSessionConfiguration.default)
    }
}
