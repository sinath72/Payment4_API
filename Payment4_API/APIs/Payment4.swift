//
//  Payment4.swift
//  Payment4_API
//
//  Created by Macvps on 7/23/24.
//

import Foundation
/// a Necessarily Data for Request to Payment4 API Looking for Payment4 Website Dashbord and Fill This
/// - Parameters:
///  - apiKey: the Uniqe Your API Key in Payment4 Website Dashbord
///  - callbackUrl: when Payment User is Done Where Website or App Back to User
///  - webhoockUrl: when Payment User is Done What Webhoock URL Called
struct Payment4{
    /// the Uniqe Your API Key in Payment4 Website Dashbord
    var apiKey:String
    /// when Payment User is Done Where Website or App Back to User
    var callbackUrl:String
    /// when Payment User is Done What Webhoock URL Called
    var webhoockUrl:String
}
