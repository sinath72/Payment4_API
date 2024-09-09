//
//  ContentView.swift
//  Payment4_API
//
//  Created by Macvps on 7/17/24.
//

import SwiftUI
enum ParameterType:String,CaseIterable{
    case int = "Integer"
    case string = "String"
    case float = "Float"
    case double = "Double"
    case uint = "UInt"
    case url = "URL"
}
struct ContentView: View {
    @State var pay = Payment(apiKeyModel: AppDelegate.payment4)
    @State var verify = Verify(apiKeyModel: AppDelegate.payment4)
    @ObservedObject var observ = Selected_Items()
    @State private var amount:String = ""
    @State private var errorMessage:String = ""
    @State private var errorTitle = "Error:"
    @State private var isErrorPresent:Bool = false
    @State private var callbackParameterType:ParameterType = .int
    @State private var callbackParameterValue:String = ""
    @State private var callbackParameterKey:String = ""
    @State private var webhoockParameterType:ParameterType = .int
    @State private var webhoockParameterValue:String = ""
    @State private var webhoockParameterKey:String = ""
    func showErrorAlert(_ message:String,_ title:String = ""){
        errorMessage = message
        if title != "" {
            errorTitle = title
        }
        isErrorPresent.toggle()
    }
    var body: some View {
        VStack(spacing:40) {
            HStack{
                Text("Amount:")
                TextField("Amount",text:$amount).keyboardType(.numberPad).multilineTextAlignment(.center).background(Color.gray.opacity(0.4)).font(.title2)
            }
            HStack{
                Text("Currency of Your as Pay:").multilineTextAlignment(.center)
                Currencies_Swiftui(selectedItem: observ).font(.callout).foregroundStyle(Color.black).background( LinearGradient(colors: [Color.blue,.orange], startPoint: .leading, endPoint: .trailing)).cornerRadius(16)
            }
            HStack{
                Text("Your Webpage Payment Language:").multilineTextAlignment(.center)
                Languages_Swiftui(selectedItem: observ).font(.title2).foregroundStyle(Color.black).background( LinearGradient(colors: [Color.blue,.orange], startPoint: .leading, endPoint: .trailing)).cornerRadius(16)
            }
            HStack{
                Text("Callback Parameter:").multilineTextAlignment(.center)
                TextField("Key",text:$callbackParameterKey).multilineTextAlignment(.center).background(Color.gray.opacity(0.4)).font(.title2)
                Text(":")
                TextField("Value",text:$callbackParameterValue).keyboardType(.numberPad).multilineTextAlignment(.center).background(Color.gray.opacity(0.4)).font(.title2)
                Menu {
                    ForEach(ParameterType.allCases,id:\.self){ item in
                        Button(item.rawValue) {
                            callbackParameterType = item
                        }
                    }
                } label: {
                    Text(callbackParameterType.rawValue)
                }
            }
            HStack{
                Text("Webhoock Parameter:").multilineTextAlignment(.center)
                TextField("Key",text:$webhoockParameterKey).multilineTextAlignment(.center).background(Color.gray.opacity(0.4)).font(.title2)
                Text(":")
                TextField("Value",text:$webhoockParameterValue).keyboardType(.numberPad).multilineTextAlignment(.center).background(Color.gray.opacity(0.4)).font(.title2)
                Menu {
                    ForEach(ParameterType.allCases,id:\.self){ item in
                        Button(item.rawValue) {
                            webhoockParameterType = item
                        }
                    }
                } label: {
                    Text(webhoockParameterType.rawValue)
                }
            }
            Spacer()
            HStack{
                Spacer()
                Button{
                    //MARK: change callback parameter value type
                    var CPV:Any? = nil
                    switch callbackParameterType {
                    case .int:
                        guard let tempData = try? NumberFormatter().number(from: callbackParameterValue)?.intValue else{showErrorAlert("Callback Parameter Value isn't Valid for " + callbackParameterType.rawValue + " Type");return}
                        CPV = tempData
                    case .string:
                        CPV = callbackParameterValue
                    case .float:
                        guard let tempData = try? NumberFormatter().number(from: callbackParameterValue)?.floatValue else{showErrorAlert("Callback Parameter Value isn't Valid for " + callbackParameterType.rawValue + " Type");return}
                        CPV = tempData
                    case .double:
                        guard let tempData = try? NumberFormatter().number(from: callbackParameterValue)?.doubleValue else{showErrorAlert("Callback Parameter Value isn't Valid for " + callbackParameterType.rawValue + " Type");return}
                        CPV = tempData
                    case .uint:
                        guard let tempData = try? NumberFormatter().number(from: callbackParameterValue)?.uintValue else{showErrorAlert("Callback Parameter Value isn't Valid for " + callbackParameterType.rawValue + " Type");return}
                        CPV = tempData
                    case .url:
                        guard let tempData = try? URL(string: callbackParameterValue) else { showErrorAlert("Callback Parameter Value isn't Valid for " + callbackParameterType.rawValue + " Type");return}
                        CPV = tempData
                    }
                    
                    //MARK: change Webhoock parameter value type
                    var WPV:Any? = nil
                    switch webhoockParameterType {
                    case .int:
                        guard let tempData = try? NumberFormatter().number(from: webhoockParameterValue)?.intValue else{showErrorAlert("Webhoock Parameter Value isn't Valid for " + webhoockParameterType.rawValue + " Type");return}
                        WPV = tempData
                    case .string:
                        WPV = webhoockParameterValue
                    case .float:
                        guard let tempData = try? NumberFormatter().number(from: webhoockParameterValue)?.floatValue else{showErrorAlert("Webhoock Parameter Value isn't Valid for " + webhoockParameterType.rawValue + " Type");return}
                        WPV = tempData
                    case .double:
                        guard let tempData = try? NumberFormatter().number(from: webhoockParameterValue)?.doubleValue else{showErrorAlert("Webhoock Parameter Value isn't Valid for " + webhoockParameterType.rawValue + " Type");return}
                        WPV = tempData
                    case .uint:
                        guard let tempData = try? NumberFormatter().number(from: webhoockParameterValue)?.uintValue else{showErrorAlert("Webhoock Parameter Value isn't Valid for " + webhoockParameterType.rawValue + " Type");return}
                        WPV = tempData
                    case .url:
                        guard let tempData = try? URL(string: webhoockParameterValue) else { showErrorAlert("Webhoock Parameter Value isn't Valid for " + webhoockParameterType.rawValue + " Type");return}
                        WPV = tempData
                    }
                    if amount == ""{ showErrorAlert("Amount is not Entery")}
                    else if observ.language == .none{ showErrorAlert("Language not selected")}
                    else if observ.currency == .none{ showErrorAlert("Currency not selected")}
                    else{
                        guard let amount = try! NumberFormatter().number(from: amount)?.intValue else { showErrorAlert("please enter number only"); return }
                        guard let CPV = CPV else { showErrorAlert("please enter callback parameter value"); return }
                        guard let WPV = WPV else { showErrorAlert("please enter webhoock parameter value"); return }
                        let model = PaymentModel(amount: amount,callbackParams:[callbackParameterKey:CPV],webhookParams:[webhoockParameterKey:WPV], language: observ.language, currencyName: observ.currency)
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
    func onSucced(_ data: paymentSuccessResponseModel) {
        print(data.paymentResponse,data.currencyMark,data.amount)
        let model = VerifyModel(paymentUid: data.paymentResponse.paymentUid, amount: data.amount, currency: data.currencyMark)
        verify.getVerify(model, data.languages)
    }
    func onFaild(_ msg: String) {
        showErrorAlert(msg)
    }
    
    func onError(_ data: ErrorExtractModels) {
        showErrorAlert(data.description, data.message)
    }
}
extension ContentView:VerifyProrocol{
    func onSuccedVerify(_ data: VerifyResponseModel) {
        print(data)
    }
    
    func onFaildVerifiing(_ msg: String) {
        showErrorAlert(msg)
    }
    
    func onErrorVerifing(_ data: ErrorExtractModels) {
        showErrorAlert(data.description, data.message)
    }
    
}
