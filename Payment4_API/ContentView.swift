//
//  ContentView.swift
//  Payment4_API
//
//  Created by Macvps on 7/17/24.
//

import SwiftUI

struct ContentView: View {
    @State var pay = Payment()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear{
            pay.delegate = self
            let model = PaymentModel(amount: 10, language: .farsi, currencyName: .usd)
            pay.pay(model)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
extension ContentView:PaymentDelegates{
    func onSucced(_ data: PayResponseModel) {
        
    }
    
    func onFaild(_ msg: String) {
        
    }
    
    func onError(_ data: PaymentErrorExtractModels) {
        
    }
}
