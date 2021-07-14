//
//  configTV.swift
//  ionTabRemote-WifiTV
//
//  Created by pablo Gutierrez on 8/7/21.
//

import Foundation

// objeto encargado de recoger los dato de la tv.

class configTV {
    
    var ble_token : String
    var ble_name : String

//    inizalizador del objeto con parametros.

    init(ble_token : String, ble_name : String) {
        self.ble_token  = ble_token
        self.ble_name = ble_name
        
    }
    
//    inicializador con los parametros en blaco.
    
    init(){
        
        self.ble_token  = "12345678"
        self.ble_name = "WIFITV1234"//"WIFITV616"//"b4250400-fb4b-4746-b2b0-93f0e61122c6" WIFITV616
        
    }
    
}
