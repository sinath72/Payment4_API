//
//  Payment4 Languages Swiftui.swift
//  Payment4_API
//
//  Created by Macvps on 8/22/24.
//

import SwiftUI
/// Create of Arrays of Boolean for Statement Each of Language's Name for Checkmark Confronting  of the Language's Name
func createCheckedStateLanguages() -> [Bool]{
    var states:[Bool] = []
    let count = getLanguagesNameCount()
    for _ in 0..<count{
        states.append(false)
    }
    return states
}
/// a Type of Using for Show Languages in View & Selected Language Diffrence Which od Them in View
typealias LanguageItems = (languages:[LanguagesName],checked:[Bool])
/// a Custom View for Showing Languages in a Menu for Select Language's by User
/// - Parameters:
///  - select: the Name of Selected Language by User for Showing on Text Lable's at Menu View
///  - languages: All Languages & Language Selected State's
///  - selectedItem: a Object of Selected_Items Observable Class's for Share Data Selected Language's or Currenccy's with Parrent View & Initialize with Parrent View
struct Languages_Swiftui: View {
    /// Language Selected Name for Showing on Text Lable's at Menu View
    @State private var select:String = "Please Select Your Language"
    /// All Languages & Language Selected State's
    @State private var languages:LanguageItems = LanguageItems(LanguagesName.allCases,createCheckedStateLanguages())
    /// a Object of Selected_Items Observable Class's for Share Data Selected Language's or Currenccy's with Parrent View & Initialize with Parrent View
    @StateObject var selectedItem:Selected_Items = Selected_Items()
    var body: some View {
        Menu {
            ForEach(languages.languages,id: \.self) { item in
                if item == .none{
                    // if Item Selected None Showing Please Select Your Language on Menu Text Lable
                    // and Seperate with Other Name for Better UI User for Select User Which Other
                    Divider()
                    Button("None") {
                        for i in 0..<languages.checked.count{
                            languages.checked[i] = false
                        }
                        select = "Please Select Your Language"
                        selectedItem.language = .none
                    }
                }
                else{
                    // Create All Languages Name with Checkmark Confronting on that Selected Name
                    // and Share Selected Item with Parrent View and Toggle Checked State to True
                    // and Change Menu Text to That's Name
                    Button{
                        for i in 0..<languages.checked.count{
                            languages.checked[i] = false
                        }
                        select = item.rawValue
                        selectedItem.language = item
                        let data = languages.languages.filter({$0.rawValue.contains(item.rawValue)}).first!
                        let index = languages.languages.firstIndex(of: data)!
                        languages.checked[index].toggle()
                    } label: {
                        HStack{
                            Image(systemName: selectLanguageState(item.rawValue, languages) ? "checkmark":"")
                            Text(item.rawValue)
                        }
                    }
                }
            }
        } label: {
            Text(select).padding()
        }
        .onAppear{
            // Sort All Languages by Name
            languages.languages.sort { lhs, rhs in
                lhs.rawValue > rhs.rawValue
            }
        }
    }
}

#Preview {
    Languages_Swiftui()
}
extension Languages_Swiftui{
    /// Return State's Each of Languages in Array for Using Checkmark in View or Not Using
    func selectLanguageState(_ str:String,_ all:LanguageItems) -> Bool{
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
