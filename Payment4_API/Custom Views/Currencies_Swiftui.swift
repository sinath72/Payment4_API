//
//  Currencies_Swiftui.swift
//  Payment4_API
//
//  Created by Macvps on 8/22/24.
//

import SwiftUI
struct Currencies_Swiftui: View {
    @State private var select:String = "Please Select Your Currency for Payment"
    @State private var currency:CurrencyItems = CurrencyItems(CurrencyViewItems.allCases,[])
    @StateObject var selectedItem:Selected_Items = Selected_Items()
    var body: some View {
        Menu {
            Button("None") {
                for i in 0..<currency.checked.count{
                    currency.checked[i] = false
                }
                select = "Please Select Your Currency for Payment"
                selectedItem.currency = .none
            }
            Divider()
            ForEach(currency.currency,id: \.self) { item in
                Button{
                    for i in 0..<currency.checked.count{
                        currency.checked[i] = false
                    }
                    select = item.rawValue
                    switch item{
                    case .usd:
                        selectedItem.currency = .usd
                    case .euro:
                        selectedItem.currency = .euro
                    case .gbp:
                        selectedItem.currency = .gbp
                    case .irt:
                        selectedItem.currency = .irt
                    case .TRY:
                        selectedItem.currency = .TRY
                    case .aed:
                        selectedItem.currency = .aed
                    }
                    let data = try! currency.currency.filter({$0.rawValue.contains(select)}).first
                    let index = try! currency.currency.firstIndex(of: data!)
                    currency.checked[index!].toggle()
                } label: {
                    HStack{
                        Image(systemName: findCheckeState(item.rawValue, currency) ? "checkmark":"")
                        Text(item.rawValue)
                    }
                }
            }
        } label: {
            Text(select).padding()
        }
        .onAppear{
            currency.currency.sort { lhs, rhs in
                lhs.rawValue > rhs.rawValue
            }
            for _ in 0..<currency.currency.count{
                currency.checked.append(false)
            }
        }
    }
}

#Preview {
    Currencies_Swiftui(selectedItem: Selected_Items())
}
extension Currencies_Swiftui{
    func findCheckeState(_ str:String,_ all:CurrencyItems) -> Bool{
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
