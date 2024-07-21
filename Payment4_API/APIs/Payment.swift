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
                            let translatedError = getAPITranslationError(modularData.errorCode, bodyModel.language)
                            let model = PaymentErrorExtractModels(status: modularData.status, message: translatedError.errorTitle, errorCode: modularData.errorCode, description: translatedError.message)
                            self.delegate?.onError(model)
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
    private func getAPITranslationError(_ code:Int,_ language:Languages) -> (errorTitle:String,message:String){
        switch language {
        case .english:
            let error = getEnglishError(code)
            let message = getEnglishErrorMessage(code)
            return (errorTitle:error,message:message)
        case .farsi:
            let error = getPersianError(code)
            let message = getPersianErrorMessage(code)
            return (errorTitle:error,message:message)
        case .french:
            let error = getFrenchError(code)
            let message = getFrenchErrorMessage(code)
            return (errorTitle:error,message:message)
        case .arabic:
            let error = getArabicError(code)
            let message = getArabicErrorMessage(code)
            return (errorTitle:error,message:message)
        case .turkey:
            let error = getTurkeyError(code)
            let message = getTurkeyErrorMessage(code)
            return (errorTitle:error,message:message)
        case .espanish:
            let error = getEspanishError(code)
            let message = getEspanishErrorMessage(code)
            return (errorTitle:error,message:message)
        }
    }
    private func getEnglishError(_ code:Int) -> String{
        switch code{
        case 1001:
            return "validation error message"
        case 1002:
            return "api key not send"
        case 1003:
            return "api key not found"
        case 1004:
            return "gateway not approved"
        case 1005:
            return "assets not found"
        case 1011:
            return "payment amount lower than minimum"
        case 1012:
            return "invalid currency"
        case 1013:
            return "invalid language"
        default:
            return ""
        }
    }
    private func getPersianError(_ code:Int) -> String{
        switch code{
        case 1001:
            return "پیام خطای اعتبارسنجی"
        case 1002:
            return "کلید api ارسال نمی شود"
        case 1003:
            return "کلید api پیدا نشد"
        case 1004:
            return "دروازه تایید نشد"
        case 1005:
            return "دارایی پیدا نشد"
        case 1011:
            return "مبلغ پرداختی کمتر از حداقل"
        case 1012:
            return "ارز نامعتبر"
        case 1013:
            return "زبان نامعتبر"
        default:
            return ""
        }
    }
    private func getFrenchError(_ code:Int) -> String{
        switch code{
        case 1001:
            return "message d'erreur de validation"
        case 1002:
            return "clé API non envoyée"
        case 1003:
            return "clé API introuvable"
        case 1004:
            return "passerelle non approuvée"
        case 1005:
            return "actifs introuvables"
        case 1011:
            return "montant du paiement inférieur au minimum"
        case 1012:
            return "devise invalide"
        case 1013:
            return "langue invalide"
        default:
            return ""
        }
    }
    private func getTurkeyError(_ code:Int) -> String{
        switch code{
        case 1001:
            return "doğrulama hata mesajı"
        case 1002:
            return "API anahtarı gönderilmiyor"
        case 1003:
            return "API anahtarı bulunamadı"
        case 1004:
            return "ağ geçidi onaylanmadı"
        case 1005:
            return "varlık bulunamadı"
        case 1011:
            return "ödeme tutarı minimumdan düşük"
        case 1012:
            return "Geçersiz para birimi"
        case 1013:
            return "Geçersiz dil"
        default:
            return ""
        }
    }
    private func getEspanishError(_ code:Int) -> String{
        switch code{
        case 1001:
            return "mensaje de error de validación"
        case 1002:
            return "clave API no enviada"
        case 1003:
            return "clave API no encontrada"
        case 1004:
            return "puerta de enlace no aprobada"
        case 1005:
            return "activos no encontrados"
        case 1011:
            return "monto de pago inferior al mínimo"
        case 1012:
            return "Moneda no válida"
        case 1013:
            return "Idioma no válido"
        default:
            return ""
        }
    }
    private func getArabicError(_ code:Int) -> String{
        switch code{
        case 1001:
            return "رسالة خطأ التحقق من الصحة"
        case 1002:
            return "مفتاح API لا يرسل"
        case 1003:
            return "لم يتم العثور على مفتاح API"
        case 1004:
            return "البوابة غير معتمدة"
        case 1005:
            return "لم يتم العثور على الأصول"
        case 1011:
            return "مبلغ الدفع أقل من الحد الأدنى"
        case 1012:
            return "عملة غير صالحة"
        case 1013:
            return "لغة غير صالحة"
        default:
            return ""
        }
    }
    private func getEnglishErrorMessage(_ code:Int) -> String{
        switch code{
        case 1001:
            return "This error occurs when there are validation issues with the request."
        case 1002:
            return "This error indicates that the API key was not included in the request."
        case 1003:
            return "This error occurs when the provided API key is not found or recognized by the system."
        case 1004:
            return "This error signifies that the selected gateway is not approved or authorized for the transaction."
        case 1005:
            return "This error is triggered when the requested assets are not found."
        case 1011:
            return "This error occurs when the payment amount is below the specified minimum limit."
        case 1012:
            return "This error indicates that the provided currency is invalid or not supported."
        case 1013:
            return "This error occurs when the specified language is invalid or not supported."
        default:
            return ""
        }
    }
    private func getPersianErrorMessage(_ code:Int) -> String{
        switch code{
        case 1001:
            return "این خطا زمانی رخ می دهد که مشکلات اعتبار سنجی در درخواست وجود داشته باشد."
        case 1002:
            return "این خطا نشان می دهد که کلید API در درخواست گنجانده نشده است."
        case 1003:
            return "این خطا زمانی رخ می دهد که کلید API ارائه شده توسط سیستم پیدا یا شناسایی نشود."
        case 1004:
            return "این خطا نشان می دهد که دروازه انتخاب شده برای تراکنش تایید یا مجاز نیست."
        case 1005:
            return "این خطا زمانی ایجاد می شود که دارایی های درخواستی پیدا نشود."
        case 1011:
            return "این خطا زمانی رخ می دهد که مبلغ پرداختی کمتر از حداقل حد تعیین شده باشد."
        case 1012:
            return "این خطا نشان می دهد که ارز ارائه شده نامعتبر است یا پشتیبانی نمی شود."
        case 1013:
            return "این خطا زمانی رخ می دهد که زبان مشخص شده نامعتبر باشد یا پشتیبانی نشود."
        default:
            return ""
        }
    }
    private func getFrenchErrorMessage(_ code:Int) -> String{
        switch code{
        case 1001:
            return "Cette erreur se produit lorsqu'il y a des problèmes de validation avec la demande."
        case 1002:
            return "Cette erreur indique que la clé API n'a pas été incluse dans la requête."
        case 1003:
            return "Cette erreur se produit lorsque la clé API fournie n'est pas trouvée ou reconnue par le système."
        case 1004:
            return "Cette erreur signifie que la passerelle sélectionnée n'est pas approuvée ou autorisée pour la transaction."
        case 1005:
            return "Cette erreur est déclenchée lorsque les ressources demandées ne sont pas trouvées."
        case 1011:
            return "Cette erreur se produit lorsque le montant du paiement est inférieur à la limite minimale spécifiée."
        case 1012:
            return "Cette erreur indique que la devise fournie n'est pas valide ou n'est pas prise en charge."
        case 1013:
            return "Cette erreur se produit lorsque la langue spécifiée n'est pas valide ou n'est pas prise en charge."
        default:
            return ""
        }
    }
    private func getTurkeyErrorMessage(_ code:Int) -> String{
        switch code{
        case 1001:
            return "Bu hata, istekle ilgili doğrulama sorunları olduğunda ortaya çıkar."
        case 1002:
            return "Bu hata, API anahtarının isteğe dahil edilmediğini gösterir."
        case 1003:
            return "Bu hata, sağlanan API anahtarı sistem tarafından bulunamadığında veya tanınmadığında ortaya çıkar."
        case 1004:
            return "Bu hata, seçilen ağ geçidinin işlem için onaylanmadığı veya yetkilendirilmediği anlamına gelir."
        case 1005:
            return "Bu hata, istenen varlıklar bulunamadığında tetiklenir."
        case 1011:
            return "Bu hata, ödeme tutarının belirtilen minimum limitin altında olması durumunda ortaya çıkar."
        case 1012:
            return "Bu hata, sağlanan para biriminin geçersiz olduğunu veya desteklenmediğini gösterir."
        case 1013:
            return "Bu hata, belirtilen dil geçersiz olduğunda veya desteklenmediğinde ortaya çıkar."
        default:
            return ""
        }
    }
    private func getEspanishErrorMessage(_ code:Int) -> String{
        switch code{
        case 1001:
            return "Este error ocurre cuando hay problemas de validación con la solicitud."
        case 1002:
            return "Este error indica que la clave API no se incluyó en la solicitud."
        case 1003:
            return "Este error se produce cuando el sistema no encuentra ni reconoce la clave API proporcionada."
        case 1004:
            return "Este error significa que la puerta de enlace seleccionada no está aprobada ni autorizada para la transacción."
        case 1005:
            return "Este error se activa cuando no se encuentran los activos solicitados."
        case 1011:
            return "Este error ocurre cuando el monto del pago está por debajo del límite mínimo especificado."
        case 1012:
            return "Este error indica que la moneda proporcionada no es válida o no es compatible."
        case 1013:
            return "Este error ocurre cuando el idioma especificado no es válido o no es compatible."
        default:
            return ""
        }
    }
    private func getArabicErrorMessage(_ code:Int) -> String{
        switch code{
        case 1001:
            return "يحدث هذا الخطأ عند وجود مشكلات في التحقق من صحة الطلب."
        case 1002:
            return "يشير هذا الخطأ إلى أن مفتاح API لم يتم تضمينه في الطلب."
        case 1003:
            return "يحدث هذا الخطأ عندما لا يتم العثور على مفتاح API المقدم أو عدم التعرف عليه بواسطة النظام."
        case 1004:
            return "يعني هذا الخطأ أن البوابة المحددة غير معتمدة أو مخولة للمعاملة."
        case 1005:
            return "يحدث هذا الخطأ عندما لا يتم العثور على الأصول المطلوبة."
        case 1011:
            return "يحدث هذا الخطأ عندما يكون مبلغ الدفع أقل من الحد الأدنى المحدد."
        case 1012:
            return "يشير هذا الخطأ إلى أن العملة المقدمة غير صالحة أو غير مدعومة."
        case 1013:
            return "يحدث هذا الخطأ عندما تكون اللغة المحددة غير صالحة أو غير مدعومة."
        default:
            return ""
        }
    }
    
}
