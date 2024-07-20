//
//  Payment.swift
//  Payment4_API
//
//  Created by Macvps on 7/17/24.
//

import Foundation
class Payment {
    var delegate:PaymentDelegates?
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
        case .espanish:
            return .espanish
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
        let languageMark:Languages = languageMarks(data.language)
        let currencyMark:CurrencyPayment = currencyMarks(data.currencyName)
        let bodyModel = BodyModel(amount: data.amount, callbackUrl: AppDelegate.callbackUrl,callbackParams: data.callbackParams, webhoockUrl: AppDelegate.webhoockUrl, webhookParams: data.webhookParams, language: languageMark, currencyMark: currencyMark)
        let body = bodyArgs(bodyModel)
        let header = headerArgs()
        let url = getUrl()
        guard let body = body else { self.delegate?.onFaild("ورودی داده ها را بررسی نمایید");return }
        let request = getRequest(body, header, url)
        let seassion = getSeassion()
        let task = seassion.dataTask(with: request) { [self] (data, response, error) in
            if error == nil{
                let statusCode = (response as! HTTPURLResponse).statusCode
                if statusCode == 200 || statusCode == 201{
                    guard let data = data else { self.delegate?.onFaild("خطا در دریافت اطلاعات لطفا مجددا تلاش فرمایید"); return}
                    do{
                        let modularData = try JSONDecoder().decode(PayResponseModel.self, from: data)
                        self.delegate?.onSucced(modularData)
                    }
                    catch{
                        self.delegate?.onFaild("خطا در پردازش اطلاعات لطفا مجددا تلاش فرمایید ")
                    }
                }
                else{
                    if statusCode == 400{
                        guard let data = data else { self.delegate?.onFaild("خطا در دریافت اطلاعات لطفا مجددا تلاش فرمایید"); return}
                        do{
                            let modularData = try JSONDecoder().decode(PaymentErrorModels.self, from: data)
                            self.delegate?.onError(modularData)
                        }
                        catch{
                            self.delegate?.onFaild("خطا در پردازش اطلاعات لطفا مجددا تلاش فرمایید ")
                        }
                    }
                    else{
                        self.delegate?.onFaild("خطای ناشناخته لطفا با پشتیبانی تماس خاصل فرمایید")
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
            "x-api-key": AppDelegate.apiKey,
            "Content-Type": "application/json"
        ]
    }
    private func bodyArgs(_ data:BodyModel) -> Data?{
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
        guard let data = try? JSONSerialization.data(withJSONObject: jsonBodyData,options: []) else { self.delegate?.onFaild("خطا در داده ها لطفا ورودی ها را بررسی نمایید");return nil}
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
