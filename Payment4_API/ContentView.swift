//
//  ContentView.swift
//  Payment4_API
//
//  Created by Macvps on 7/17/24.
//

import SwiftUI

struct ContentView: View {
    @State var pay = Payment(apiKeyModel: AppDelegate.payment4)
    @State var verify = Verify(apiKeyModel: AppDelegate.payment4)
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear{
            pay.delegate = self
            verify.delegate = self
            let model = PaymentModel(amount: 50, language: .farsi, currencyName: .usd)
            pay.pay(model)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
extension ContentView:PaymentDelegates{
    func onSucced(_ data: PayResponseModel, _ currencyMark: CurrencyPayment, _ amount: Int,_ lang:LanguagesName) {
        print(data,currencyMark,amount)
        let model = VerifyModel(paymentUid: data.paymentUid, amount: amount, currency: currencyMark)
        verify.getVerify(model, lang)
        
    }
    
    func onFaild(_ msg: String) {
        print(msg)
    }
    
    func onError(_ data: ErrorExtractModels) {
        print("Payment",data)
        
    }
}
extension ContentView:VerifyProrocol{
    func onSuccedVerify(_ data: VerifyResponseModel) {
        print(data)
    }
    
    func onFaildVerifiing(_ msg: String) {
        print("verifying",msg)
    }
    
    func onErrorVerifing(_ data: ErrorExtractModels) {
        print("verifying",data)
    }
    
}
