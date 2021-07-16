//
//  configTV.swift
//  ionTabRemote-WifiTV
//
//  Created by pablo Gutierrez on 8/7/21.
//

import Foundation

// object in charge of collecting data from the tv.

class configTV {
    
    var ble_token : String
    var ble_name : String

//    object initializer with parameters.

    init(ble_token : String, ble_name : String) {
        self.ble_token  = ble_token
        self.ble_name = ble_name
        
    }
    
//    initializer with blank parameters.
    
    init(){
        
        self.ble_token  = ""
        self.ble_name = ""
        
    }
    
}
