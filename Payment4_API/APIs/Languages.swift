//
//  Languages.swift
//  Payment4_API
//
//  Created by Macvps on 7/17/24.
//

import Foundation
/// All Languages Name Supported with Payment4 for Displaying in a View like Languages_Swiftui View for Translations Errors and Payment Page
enum LanguagesName:String{
    case none = ""
    case english = "English"
    case farsi = "فارسی"
    case french = "Français"
    case arabic = "العربية"
    case turkey = "Türkçe"
    case spanish = "Español"
}
///Abbreviation Each of Selected Language Name for Sendding to API
enum Languages:String{
    case none = ""
    case english = "en"
    case farsi = "fa"
    case french = "fr"
    case arabic = "ar"
    case turkey = "tr"
    case spanish = "es"
}
