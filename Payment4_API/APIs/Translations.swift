//
//  Translations.swift
//  Payment4_API
//
//  Created by Macvps on 7/23/24.
//

import Foundation
class Translete{
    //MARK: Start Server Side Error Translation
    private func getNotFoundErrorTranslation(_ lang: Languages) -> (errorTitle: String, message: String) {
        switch lang {
        case .english:
            return (errorTitle: "Error code not found", message: "We are not found error code for translate error message for your language.\nMaybe your payment UUID is wrong.\nPlease contact with support app.")
        case .farsi:
            return (errorTitle: "کد خطا یافت نشد", message: "ما کد خطا را برای ترجمه پیام خطا به زبان شما پیدا نکردیم.\nممکن است شناسه پرداخت شما نادرست باشد.\nلطفا با پشتیبانی تماس بگیرید.")
        case .french:
            return (errorTitle: "Code d'erreur introuvable", message: "Nous n'avons pas trouvé le code d'erreur pour traduire le message d'erreur dans votre langue.\nPeut-être que votre UUID de paiement est incorrect.\nVeuillez contacter le support de l'application.")
        case .arabic:
            return (errorTitle: "رمز الخطأ غير موجود", message: "لم نعثر على رمز الخطأ لترجمة رسالة الخطأ إلى لغتك.\nربما يكون معرف الدفع الخاص بك خاطئًا.\nيرجى الاتصال بدعم التطبيق.")
        case .turkey:
            return (errorTitle: "Hata kodu bulunamadı", message: "Diliniz için hata mesajını çevirmek üzere hata kodunu bulamadık.\nBelki ödeme UUID'niz yanlış.\nLütfen uygulama desteği ile iletişime geçin.")
        case .spanish:
            return (errorTitle: "Código de error no encontrado", message: "No encontramos el código de error para traducir el mensaje de error a su idioma.\nTal vez su UUID de pago sea incorrecto.\nPor favor, contacte con el soporte de la aplicación.")
        }
    }
    func getAPITranslationError(_ code:Int?,_ language:Languages) -> (errorTitle:String,message:String){
        guard let code = code else { return getNotFoundErrorTranslation(language) }
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
        case .spanish:
            let error = getSpanishError(code)
            let message = getSpanishErrorMessage(code)
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
        case 1006:
            return "payment not found"
        case 1010:
            return "invalid amount"
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
        case 1006:
            return "پرداخت پیدا نشد"
        case 1010:
            return "مقدار نامعتبر"
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
        case 1006:
            return "paiement introuvable"
        case 1010:
            return "montant invalide"
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
        case 1006:
            return "ödeme bulunamadı"
        case 1010:
            return "geçersiz miktar"
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
    private func getSpanishError(_ code:Int) -> String{
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
        case 1006:
            return "pago no encontrado"
        case 1010:
            return "Monto invalido"
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
        case 1006:
            return "لم يتم العثور على الدفع"
        case 1010:
            return "مبلغ غير صحيح"
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
        case 1006:
            return "This error is raised when the specified payment could not be found in the system. Ensure that you are providing the correct payment information."
        case 1010:
            return "This error is raised when the payment amount provided in the request is invalid or not within the accepted range. Ensure that the amount is within the specified limits."
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
        case 1006:
            return "این خطا زمانی ایجاد می شود که پرداخت مشخص شده در سیستم یافت نشود. اطمینان حاصل کنید که اطلاعات پرداخت صحیح را ارائه می دهید."
        case 1010:
            return "این خطا زمانی ایجاد می شود که مبلغ پرداختی ارائه شده در درخواست نامعتبر باشد یا در محدوده پذیرفته شده نباشد. اطمینان حاصل کنید که مقدار در محدوده مشخص شده است."
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
        case 1006:
            return "Cette erreur est générée lorsque le paiement spécifié est introuvable dans le système. Assurez-vous de fournir les informations de paiement correctes."
        case 1010:
            return "Cette erreur se produit lorsque le montant du paiement fourni dans la demande n'est pas valide ou n'est pas dans la fourchette acceptée. Assurez-vous que le montant se situe dans les limites spécifiées."
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
        case 1006:
            return "Bu hata, belirtilen ödemenin sistemde bulunamaması durumunda ortaya çıkar. Doğru ödeme bilgilerini sağladığınızdan emin olun."
        case 1010:
            return "Bu hata, istekte belirtilen ödeme tutarı geçersiz olduğunda veya kabul edilen aralıkta olmadığında ortaya çıkar. Tutarın belirtilen limitler dahilinde olduğundan emin olun."
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
    private func getSpanishErrorMessage(_ code:Int) -> String{
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
        case 1006:
            return "Este error aparece cuando el pago especificado no se pudo encontrar en el sistema. Asegúrese de proporcionar la información de pago correcta."
        case 1010:
            return "Este error aparece cuando el monto de pago proporcionado en la solicitud no es válido o no está dentro del rango aceptado. Asegúrese de que la cantidad esté dentro de los límites especificados."
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
        case 1006:
            return "ينشأ هذا الخطأ عندما لا يمكن العثور على الدفعة المحددة في النظام. تأكد من أنك تقدم معلومات الدفع الصحيحة."
        case 1010:
            return "يظهر هذا الخطأ عندما يكون مبلغ الدفع المقدم في الطلب غير صالح أو لا يقع ضمن النطاق المقبول. التأكد من أن المبلغ ضمن الحدود المحددة."
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
    //MARK: End Server Side Error Translation
    
    //MARK: Start Client Side Faild Translation
    func getFaildErrorTranslation(_ data:Int,_ lang:LanguagesName) -> String{
        switch lang {
        case .english:
            return EnglishFaildErrorsMessage(data)
        case .farsi:
            return PersianFaildErrorsMessage(data)
        case .french:
            return FrenchFaildErrorsMessage(data)
        case .arabic:
            return ArabicFaildErrorsMessage(data)
        case .turkey:
            return TurkishFaildErrorsMessage(data)
        case .spanish:
            return SpanishFaildErrorsMessage(data)
        }
    }
    private func EnglishFaildErrorsMessage(_ data: Int) -> String {
        switch data {
        case 1:
            return "Please check the input data"
        case 2:
            return "Error in receiving information, please try again"
        case 3:
            return "Error in processing information, please try again"
        case 4:
            return "Unknown error, please contact support"
        case 5:
            return "Data error, please check the inputs"
        default:
            return "Unspecified error, please contact support"
        }

    }
    private func PersianFaildErrorsMessage(_ data: Int) -> String {
        switch data {
        case 1:
            return "ورودی داده ها را بررسی نمایید"
        case 2:
            return "خطا در دریافت اطلاعات لطفا مجددا تلاش فرمایید"
        case 3:
            return "خطا در پردازش اطلاعات لطفا مجددا تلاش فرمایید "
        case 4:
            return "خطای ناشناخته لطفا با پشتیبانی تماس خاصل فرمایید"
        case 5:
            return "خطا در داده ها لطفا ورودی ها را بررسی نمایید"
        default:
            return "خطای نامشخص لطفا با پشتیبانی تماس بگیرید"
        }
    }
    private func FrenchFaildErrorsMessage(_ data: Int) -> String {
        switch data {
        case 1:
            return "Veuillez vérifier les données d'entrée"
        case 2:
            return "Erreur lors de la réception des informations, veuillez réessayer"
        case 3:
            return "Erreur lors du traitement des informations, veuillez réessayer"
        case 4:
            return "Erreur inconnue, veuillez contacter le support"
        case 5:
            return "Erreur de données, veuillez vérifier les entrées"
        default:
            return "Erreur non spécifiée, veuillez contacter le support"
        }

    }
    private func ArabicFaildErrorsMessage(_ data: Int) -> String {
        switch data {
        case 1:
            return "يرجى التحقق من البيانات المدخلة"
        case 2:
            return "خطأ في استلام المعلومات، يرجى المحاولة مرة أخرى"
        case 3:
            return "خطأ في معالجة المعلومات، يرجى المحاولة مرة أخرى"
        case 4:
            return "خطأ غير معروف، يرجى الاتصال بالدعم"
        case 5:
            return "خطأ في البيانات، يرجى التحقق من المدخلات"
        default:
            return "خطأ غير محدد، يرجى الاتصال بالدعم"
        }

    }
    private func TurkishFaildErrorsMessage(_ data: Int) -> String {
        switch data {
        case 1:
            return "Giriş verilerini kontrol edin"
        case 2:
            return "Bilgi alınırken hata oluştu, lütfen tekrar deneyin"
        case 3:
            return "Bilgi işlenirken hata oluştu, lütfen tekrar deneyin"
        case 4:
            return "Bilinmeyen hata, lütfen destek ile iletişime geçin"
        case 5:
            return "Veri hatası, lütfen girdileri kontrol edin"
        default:
            return "Belirtilmemiş hata, lütfen destek ile iletişime geçin"
        }

    }
    private func SpanishFaildErrorsMessage(_ data: Int) -> String {
        switch data {
        case 1:
            return "Por favor, verifique los datos de entrada"
        case 2:
            return "Error al recibir información, por favor intente de nuevo"
        case 3:
            return "Error al procesar información, por favor intente de nuevo"
        case 4:
            return "Error desconocido, por favor contacte soporte"
        case 5:
            return "Error de datos, por favor verifique las entradas"
        default:
            return "Error no especificado, por favor contacte soporte"
        }

    }
    //MARK: End Client Side Faild Translation
    func getTranslatePaymentStatusonVerify(_ error: String, _ lang: LanguagesName) -> String {
        switch lang {
        case .english:
            return getEnglishVerifyError(error)
        case .farsi:
            return getFarsiVerifyError(error)
        case .french:
            return getFrenchVerifyError(error)
        case .arabic:
            return getArabicVerifyError(error)
        case .turkey:
            return getTurkeyVerifyError(error)
        case .spanish:
            return getSpanishVerifyError(error)
        }
    }

    private func getEnglishVerifyError(_ error: String) -> String {
        switch error {
        case "PENDING":
            return "Pending For Pay on Payer"
        case "EXPIRED":
            return "Payer didn't Pay and Payment was Expired"
        case "ACCEPTABLE":
            return "Transaction is Acceptable for Verifing"
        case "MISMATCH":
            return "Some Parameter to Verifying Your Transaction isn't Match"
        default:
            return error
        }
    }

    private func getFarsiVerifyError(_ error: String) -> String {
        switch error {
        case "PENDING":
            return "در انتظار پرداخت توسط پرداخت‌ کننده"
        case "EXPIRED":
            return "پرداخت ‌کننده پرداخت نکرد و پرداخت منقضی شد"
        case "ACCEPTABLE":
            return "تراکنش برای تأیید قابل قبول است"
        case "MISMATCH":
            return "برخی پارامترهای تأیید تراکنش شما مطابقت ندارند"
        default:
            return error
        }
    }

    private func getFrenchVerifyError(_ error: String) -> String {
        switch error {
        case "PENDING":
            return "En attente de paiement par le payeur"
        case "EXPIRED":
            return "Le payeur n'a pas payé et le paiement a expiré"
        case "ACCEPTABLE":
            return "La transaction est acceptable pour vérification"
        case "MISMATCH":
            return "Certains paramètres de vérification de votre transaction ne correspondent pas"
        default:
            return error
        }
    }

    private func getArabicVerifyError(_ error: String) -> String {
        switch error {
        case "PENDING":
            return "قيد الانتظار للدفع من قبل الدافع"
        case "EXPIRED":
            return "لم يدفع الدافع وانتهت صلاحية الدفع"
        case "ACCEPTABLE":
            return "المعاملة مقبولة للتحقق"
        case "MISMATCH":
            return "بعض معايير التحقق من معاملتك غير متطابقة"
        default:
            return error
        }
    }

    private func getTurkeyVerifyError(_ error: String) -> String {
        switch error {
        case "PENDING":
            return "Ödeyici tarafından ödeme bekleniyor"
        case "EXPIRED":
            return "Ödeyici ödemedi ve ödeme süresi doldu"
        case "ACCEPTABLE":
            return "İşlem doğrulama için kabul edilebilir"
        case "MISMATCH":
            return "İşleminizi doğrulamak için bazı parametreler uyuşmuyor"
        default:
            return error
        }
    }

    private func getSpanishVerifyError(_ error: String) -> String {
        switch error {
        case "PENDING":
            return "Pendiente de pago por el pagador"
        case "EXPIRED":
            return "El pagador no pagó y el pago caducó"
        case "ACCEPTABLE":
            return "La transacción es aceptable para verificar"
        case "MISMATCH":
            return "Algunos parámetros para verificar su transacción no coinciden"
        default:
            return error
        }
    }
}
