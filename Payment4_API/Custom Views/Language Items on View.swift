//
//  Language Items on View.swift
//  Payment4_API
//
//  Created by Macvps on 8/24/24.
//

import Foundation
typealias LanguageItems = (languages:[LanguageViewItems],checked:[Bool])
enum LanguageViewItems:String,CaseIterable{
    case english = "English"
    case farsi = "فارسی"
    case french = "Français"
    case arabic = "العربية"
    case turkey = "Türkçe"
    case spanish = "Español"
}
