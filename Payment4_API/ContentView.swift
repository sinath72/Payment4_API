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
    @ObservedObject var observ = Selected_Items()
    @State private var amount:String = ""
    @State private var errorMessage:String = ""
    @State private var errorTitle = "Error:"
    @State private var isErrorPresent:Bool = false
    var body: some View {
        VStack {
            HStack{
                Text("Amount:")
                TextField("Amount",text:$amount).keyboardType(.numberPad).multilineTextAlignment(.center).background(Color.gray.opacity(0.4)).font(.title2)
            }
            HStack{
                Text("Currency of Your as Pay:").multilineTextAlignment(.center)
                Currencies_Swiftui(selectedItem: observ).font(.callout).foregroundStyle(Color.black).background( LinearGradient(colors: [Color.blue,.orange], startPoint: .leading, endPoint: .trailing)).cornerRadius(16)
            }
            HStack{
                Text("Your Webpage Payment Language:")
                Languages_Swiftui(selectedItem: observ).font(.title2).foregroundStyle(Color.black).background( LinearGradient(colors: [Color.blue,.orange], startPoint: .leading, endPoint: .trailing)).cornerRadius(16)
            }
            Spacer()
            HStack{
                Spacer()
                Button{
                    if amount == ""{ errorMessage = "Amount is not Entery";isErrorPresent.toggle()}
                    else if observ.language == .none{ errorMessage = "Language not selected";isErrorPresent.toggle()}
                    else if observ.currency == .none{ errorMessage = "Currency not selected";isErrorPresent.toggle()}
                    else{
                        guard let amount = try! NumberFormatter().number(from: amount)?.intValue else { return }
                        let model = PaymentModel(amount: amount,callbackParams:["ki":1],webhookParams:["km":5], language: observ.language, currencyName: observ.currency)
                        pay.pay(model)
                    }
                } label: {
                    ZStack{
                        LinearGradient(colors: [.green,.red,.blue], startPoint: .leading, endPoint: .trailing)
                        Text("Pay").font(.title).foregroundStyle(Color.black)
                    }.cornerRadius(18).frame(height: 80)
                }
                Spacer()
            }
        }.padding(.vertical)
        .onAppear{
            pay.delegate = self
            verify.delegate = self
        }
        .alert(errorTitle, isPresented: $isErrorPresent, actions: {}, message: {
            Text(errorMessage)
        })
        .onChange(of: isErrorPresent) { oldValue, newValue in
            if !newValue{
                errorTitle = "Error:"
            }
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
        self.errorMessage = msg
        self.isErrorPresent.toggle()
    }
    
    func onError(_ data: ErrorExtractModels) {
        self.errorMessage = data.description
        self.errorTitle = data.message
        self.isErrorPresent.toggle()
    }
}
extension ContentView:VerifyProrocol{
    func onSuccedVerify(_ data: VerifyResponseModel) {
        print(data)
    }
    
    func onFaildVerifiing(_ msg: String) {
        self.errorMessage = msg
        self.isErrorPresent.toggle()
    }
    
    func onErrorVerifing(_ data: ErrorExtractModels) {
        self.errorMessage = data.description
        self.errorTitle = data.message
        self.isErrorPresent.toggle()
    }
    
}
