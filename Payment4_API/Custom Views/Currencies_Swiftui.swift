//
//  Currencies_Swiftui.swift
//  Payment4_API
//
//  Created by Macvps on 8/22/24.
//

import SwiftUI
/// Create of Arrays of Boolean for Statement Each of Currency's Name for Checkmark Confronting  of the Currency's Name
func createCheckedStateCurrencies() -> [Bool]{
    var states:[Bool] = []
    let count = getCurrencyPaymentNameCount()
    for _ in 0..<count{
        states.append(false)
    }
    return states
}
/// a Type of Using for Show Currencies in View & Selected Currency Diffrence Which od Them in View
typealias CurrencyItems = (currency:[CurrencyPaymentName],checked:[Bool])
/// a Custom View for Showing Currencies in a Menu for Select User Currency for Payment
/// - Parameters:
///  - select: the Name of Selected Currency by User for Showing on Text Lable's at Menu View
///  - currency: All Currencies & Currency Selected State's
///  - selectedItem: a Object of Selected_Items Observable Class's for Share Data Selected Language's or Currenccy's with Parrent View & Initialize with Parrent View
struct Currencies_Swiftui: View {
    /// Currency Selected Name for Showing on Text Lable's at Menu View
    @State private var select:String = "Please Select Your Currency for Payment"
    /// All Currencies & Currency Selected State
    @State private var currency:CurrencyItems = CurrencyItems(CurrencyPaymentName.allCases,createCheckedStateCurrencies())
    /// a Object of Selected_Items Observable Class's for Share Data Selected Language's or Currenccy's with Parrent View & Initialize with Parrent View
    @StateObject var selectedItem:Selected_Items = Selected_Items()
    var body: some View {
        Menu {
            ForEach(currency.currency,id: \.self) { item in
                if item == .none{
                    // if Item Selected None Showing Please Select Your Currency for Payment on Menu Text Lable
                    // and Seperate with Other Name for Better UI User for Select User Which Other
                    Divider()
                    Button("None") {
                        for i in 0..<currency.checked.count{
                            currency.checked[i] = false
                        }
                        select = "Please Select Your Currency for Payment"
                        selectedItem.currency = .none
                    }
                }
                else{
                    // Create All Currencies Name with Checkmark Confronting on that Selected Name
                    // and Share Selected Item with Parrent View and Toggle Checked State to True
                    // and Change Menu Text to That's Name
                    Button{
                        for i in 0..<currency.checked.count{
                            currency.checked[i] = false
                        }
                        select = item.rawValue
                        selectedItem.currency = item
                        let data = try! currency.currency.filter({$0.rawValue.contains(select)}).first
                        let index = try! currency.currency.firstIndex(of: data!)
                        currency.checked[index!].toggle()
                    } label: {
                        HStack{
                            Image(systemName: selectCurrencyState(item.rawValue, currency) ? "checkmark":"")
                            Text(item.rawValue)
                        }
                    }
                }
            }
        } label: {
            Text(select).padding()
        }
        .onAppear{
            // Sort All Currencies by Name
            currency.currency.sort { lhs, rhs in
                lhs.rawValue > rhs.rawValue
            }
        }
    }
}

#Preview {
    Currencies_Swiftui(selectedItem: Selected_Items())
}
extension Currencies_Swiftui{    
    /// Return State's Each of Currencies in Array for Using Checkmark in View or Not Using
    func selectCurrencyState(_ str:String,_ all:CurrencyItems) -> Bool{
        do{
            guard let data = try all.currency.filter({$0.rawValue.contains(str)}).first else { return false }
            guard let index = try all.currency.firstIndex(of: data) else { return false }
            return all.checked[index]
        }
        catch{
            return false
        }
    }
}
