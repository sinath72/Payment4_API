//
//  Payment.swift
//  Payment4_API
//
//  Created by Macvps on 7/17/24.
//

import Foundation
class Payment {
    var delegate:PaymentDelegates?
    var language:LanguagesName = .english
    let translate = Translete()
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
        }
    }
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
        }
    }
    func pay(_ data:PaymentModel){
        var sandbox = true
        if data.sandbox == nil{
            sandbox = false
        }
        let languageMark:Languages = languageMarks(data.language)
        let currencyMark:CurrencyPayment = currencyMarks(data.currencyName)
        let bodyModel = PaymentBodyModel(amount: data.amount, callbackUrl: AppDelegate.payment4.callbackUrl,callbackParams: data.callbackParams, webhoockUrl: AppDelegate.payment4.webhoockUrl, webhookParams: data.webhookParams, language: languageMark, currencyMark: currencyMark,sandbox: sandbox)
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
                    guard let data = data else { self.delegate?.onFaild(translate.getFaildErrorTranslation(2, self.language)); return}
                    do{
                        let modularData = try JSONDecoder().decode(PayResponseModel.self, from: data)
                        self.delegate?.onSucced(modularData,currencyMark,bodyModel.amount,self.language)
                    }
                    catch{
                        self.delegate?.onFaild(translate.getFaildErrorTranslation(3, self.language))
                    }
                }
                else{
                    if statusCode == 400{
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
    private func headerArgs() -> [String:String]{
        [
            "x-api-key": AppDelegate.payment4.apiKey,
            "Content-Type": "application/json"
        ]
    }
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
    private func getUrl() -> URL{
        URL(string: "https://service.payment4.com/api/v1/payment")!
    }
    private func getRequest(_ body:Data,_ header:[String:String],_ url:URL) -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = header
        request.httpBody = body as Data
        return request
    }
    private func getSeassion() -> URLSession{
        URLSession(configuration: URLSessionConfiguration.default)
    }
}
