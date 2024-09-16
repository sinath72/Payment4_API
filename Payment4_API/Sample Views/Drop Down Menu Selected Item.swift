//
//  Drop Down Menu Selected Item.swift
//  Payment4_API
//
//  Created by Macvps on 8/24/24.
//

import Foundation
/// an  ObsevableObject for Share Data Selected on Languages_SwiftUI or Currencies_SwiftUI Views to Parent Called View for Using Programmer
/// - Parameters:
///  - currency: Currency Selected Item by User Share with Parrent View Defualt is None
///  - language: Language Selected Item by User Share with Parrent View Defualt is None
class Selected_Items: ObservableObject{
    /// Currency Selected Item by User Share with Parrent View Defualt is None
    @Published var currency:CurrencyPaymentName = .none
    /// Language Selected Item by User Share with Parrent View Defualt is None
    @Published var language:LanguagesName = .none
}
