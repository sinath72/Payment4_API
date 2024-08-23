//
//  Payment4 Languages Swiftui.swift
//  Payment4_API
//
//  Created by Macvps on 8/22/24.
//

import SwiftUI
enum customLanguage:String,CaseIterable{
    case english = "English"
    case farsi = "فارسی"
    case french = "Français"
    case arabic = "العربية"
    case turkey = "Türkçe"
    case spanish = "Español"
}
struct Languages_Swiftui: View {
    @State var select:String = "Please Select Your Language"
    @State private var languages:(languages:[customLanguage],checked:[Bool]) = (customLanguage.allCases,[])
    @StateObject var selectedItem:Selected_Items = Selected_Items()
    var body: some View {
        Menu {
            Button("None") {
                for i in 0..<languages.checked.count{
                    languages.checked[i] = false
                }
                select = "Please Select Your Language"
                selectedItem.language = .none
            }
            Divider()
            ForEach(languages.languages,id: \.self) { item in
                Button{
                    for i in 0..<languages.checked.count{
                        languages.checked[i] = false
                    }
                    select = item.rawValue
                    switch item{
                    case .english:
                        selectedItem.language = .english
                    case .farsi:
                        selectedItem.language = .farsi
                    case .french:
                        selectedItem.language = .french
                    case .arabic:
                        selectedItem.language = .arabic
                    case .turkey:
                        selectedItem.language = .turkey
                    case .spanish:
                        selectedItem.language = .spanish
                    }
                    let data = languages.languages.filter({$0.rawValue.contains(item.rawValue)}).first!
                    let index = languages.languages.firstIndex(of: data)!
                    languages.checked[index].toggle()
                } label: {
                    HStack{
                        Image(systemName: selectDataState(item.rawValue, languages) ? "checkmark":"")
                        Text(item.rawValue)
                    }
                }
            }
        } label: {
            Text(select).padding()
        }
        .onAppear{
            languages.languages.sort { lhs, rhs in
                lhs.rawValue > rhs.rawValue
            }
            for _ in 0..<languages.languages.count{
                languages.checked.append(false)
            }
        }
    }
}

#Preview {
    Languages_Swiftui()
}
extension Languages_Swiftui{
    func selectDataState(_ str:String,_ all:(languages:[customLanguage],checked:[Bool])) -> Bool{
        do{
            guard let data = try all.languages.filter({$0.rawValue.contains(str)}).first else { return false }
            guard let index = try all.languages.firstIndex(of: data) else { return false }
            return all.checked[index]
        }
        catch{
            return false
        }
    }
}
