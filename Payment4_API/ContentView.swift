//
//  ContentView.swift
//  Payment4_API
//
//  Created by Macvps on 7/17/24.
//

import SwiftUI
/// a Class for When App Become Active do Somethings
class BecomeActiveApp:ObservableObject{
    /// Hold Data for When App Become Active Verify Transaction
    @Published var data:paymentSuccessResponseModel?
    var NC = NotificationCenter.default
    /// a Object for Sending Verify Transaction Paid by User Request
    @State var verify = Verify(apiKeyModel: AppDelegate.payment4)
    /// Add Observe Become Active for Verify Transaction
    func addObseve(_ data:paymentSuccessResponseModel?){
        self.data = data
        NC.addObserver(self, selector: #selector(verifyObserv), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    /// Verify Transaction When App Become Active
    @objc func verifyObserv(){
        if let data = data {
            let model = VerifyModel(paymentUid: data.paymentResponse.paymentUid, amount: data.amount, currency: data.currencyMark)
            verify.getVerify(model, data.languages)
        }
    }
}
/// Some Types of Data Values callbackParameterValue or webhoockParameterValue will Convert to that Type
enum ParameterType:String,CaseIterable{
    case int = "Integer"
    case string = "String"
    case float = "Float"
    case double = "Double"
    case uint = "UInt"
    case url = "URL"
}
struct ContentView: View {
    /// a Observe Object for Initialize Background App Observe and When App Become Activated from Background Verify Transaction
    @ObservedObject var becomeActiveObserve:BecomeActiveApp = BecomeActiveApp()
    /// a Payment Object for Sending Create Transaction Request's Payment and Receiving Payment Information for Paid by the User
    @State var pay = Payment(apiKeyModel: AppDelegate.payment4)
    /// a Object for Sending Verify Transaction Paid by User Request
    @State var verify = Verify(apiKeyModel: AppDelegate.payment4)
    /// a Observe for Shared Data Between Sample Views and Parrent View
    @ObservedObject var observ = Selected_Items()
    /// Amount of User Entred
    @State private var amount:String = ""
    /// Description of Why You're Reciving Errors Some Times Reciving Errors by API and Describe that Error on Your Selected Language's at View
    @State private var errorMessage:String = ""
    /// the Title of Your Error for Showing in Alert View Some Times Reciving Error's Title by API and Change's Defualt is "Error:"
    @State private var errorTitle = "Error:"
    /// Boolean for Showing Errors
    @State private var isErrorPresent:Bool = false
    /// a Type of callbackParameterValue Will be Convert to That
    @State private var callbackParameterType:ParameterType = .string
    /// the Value of Callback Parameter for Sending to API with User or Programmer Side Setted
    @State private var callbackParameterValue:String = ""
    /// the Key of Callback Parameter for Sending to API with User or Programmer Side Setted
    @State private var callbackParameterKey:String = ""
    /// a Type of webhoockParameterValue Will be Convert to That
    @State private var webhoockParameterType:ParameterType = .string
    /// the Value of Webhoock Parameter for Sending to API with User or Programmer Side Setted
    @State private var webhoockParameterValue:String = ""
    /// the Key of Webhoock Parameter for Sending to API with User or Programmer Side Setted
    @State private var webhoockParameterKey:String = ""
    /// Show Error Alert in Anywhere Called When Set Title Change errorTitle Replace of "Error:" for Showing in Alert
    func showErrorAlert(_ message:String,_ title:String = ""){
        errorMessage = message
        if title != "" {
            errorTitle = title
        }
        isErrorPresent.toggle()
    }
    var body: some View {
        VStack(spacing:40) {
            // Reciving Amount from User
            HStack{
                Text("Amount:")
                TextField("Amount",text:$amount).keyboardType(.numberPad).multilineTextAlignment(.center).background(Color.gray.opacity(0.4)).font(.title2)
            }
            // Reciving Currency Type from User for Pay with ObservedObject to be Name of observ
            HStack{
                Text("Currency of Your as Pay:").multilineTextAlignment(.center)
                Currencies_Swiftui(selectedItem: observ).font(.callout).foregroundStyle(Color.black).background( LinearGradient(colors: [Color.blue,.orange], startPoint: .leading, endPoint: .trailing)).cornerRadius(16)
            }
            // Reciving Language's from User for Translation with ObservedObject to be Name of observ
            HStack{
                Text("Your Webpage Payment Language:").multilineTextAlignment(.center)
                Languages_Swiftui(selectedItem: observ).font(.title2).foregroundStyle(Color.black).background( LinearGradient(colors: [Color.blue,.orange], startPoint: .leading, endPoint: .trailing)).cornerRadius(16)
            }
            // a Callback Parameter for Testing API
            HStack{
                Text("Callback Parameter:").multilineTextAlignment(.center)
                TextField("Key",text:$callbackParameterKey).multilineTextAlignment(.center).background(Color.gray.opacity(0.4)).font(.title2)
                Text(":")
                TextField("Value",text:$callbackParameterValue).keyboardType(.numberPad).multilineTextAlignment(.center).background(Color.gray.opacity(0.4)).font(.title2)
                // Menu for Value's Convert to Witch One of Them
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
            // a Webhoock Parameter for Testing API
            HStack{
                Text("Webhoock Parameter:").multilineTextAlignment(.center)
                TextField("Key",text:$webhoockParameterKey).multilineTextAlignment(.center).background(Color.gray.opacity(0.4)).font(.title2)
                Text(":")
                TextField("Value",text:$webhoockParameterValue).keyboardType(.numberPad).multilineTextAlignment(.center).background(Color.gray.opacity(0.4)).font(.title2)
                // Menu for Value's Convert to Witch One of Them
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
                    // Converted Callback Parameter Value Type
                    var CPV:Any? = nil
                    if callbackParameterKey != ""{
                        // Convert Callback Parameter Value Type as a Selected in callbackParameterType Variable's
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
                    }
                    // Converted Webhoock Parameter Value Type
                    var WPV:Any? = nil
                    // Convert Webhoock Parameter Value Type as a Selected in callbackParameterType Variable's
                    if webhoockParameterKey != ""{
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
                    }
                    if amount == ""{ showErrorAlert("Amount is not Entery")}
                    else if observ.language == .none{ showErrorAlert("Language not selected")}
                    else if observ.currency == .none{ showErrorAlert("Currency not selected")}
                    else{
                        do{
                            // Convert Amount Type From String To Int
                            guard let amount = try NumberFormatter().number(from: amount)?.intValue else { showErrorAlert("please enter number only"); return }
                            if callbackParameterKey != ""{
                                guard let CPV = CPV else { showErrorAlert("please enter callback parameter value"); return }
                            }
                            if webhoockParameterKey != ""{
                                guard let WPV = WPV else { showErrorAlert("please enter webhoock parameter value"); return }
                            }
                            // Create a Model for Pass Data for lRequest Create Transaction for Pay
                            let model = PaymentModel(amount: amount,callbackParams:[callbackParameterKey:CPV ?? ""],webhookParams:[webhoockParameterKey:WPV ?? ""], language: observ.language, currencyName: observ.currency)
                            pay.pay(model)
                        }
                        catch {
                            print(error.localizedDescription)
                        }
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
            // Set Delegates for Reciving Payment and Verify Classes for Response
            pay.delegate = self
            verify.delegate = self
        }
        .alert(errorTitle, isPresented: $isErrorPresent, actions: {}, message: {
            Text(errorMessage)
        })
        .onChange(of: isErrorPresent) { oldValue, newValue in
            // Every Times is Error Alert Dissappear errorTitle Setted to Default Value
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
        // Add Observe for When User Come From Background to Application Strat Verifying of Transaction
        becomeActiveObserve.addObseve(data)
        // Initioalize URL and Redirect User to URL for Payment
        guard let url = try URL(string:data.paymentResponse.paymentUrl) else { showErrorAlert("URL Not Found Please Try Again!"); return}
        UIApplication.shared.open(url)
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
