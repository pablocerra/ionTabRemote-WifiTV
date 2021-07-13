//
//  peripheral.swift
//  ionTabRemote-WifiTV
//
//  Created by pablo Gutierrez on 12/7/21.
//

import Foundation
import CoreBluetooth

class peripheralCustom:NSObject {
    
//  variable de control del mando.

//    public static let VOLUME_UP = ["0xFE", "0xD8", "0x27"]//CBUUID.init(string: "0xFE 0xD8 0x27")
//    public static let VOLUME_DW = ["0xFE", "0x58", "0xA7"] //CBUUID.init(string: "0xFE 0x58 0xA7")
//
//    public static let CHANNEL_UP = ["0xFE", "0x98", "0x67"]//CBUUID.init(string: "0xFE 0x98 0x67")
//    public static let CHANNEL_DW = ["0xFE", "0x18", "0xE7"]//CBUUID.init(string: "0xFE 0x18 0xE7")
//
//    public static let POWER = ["0xFE", "0xA8", "0x57"] //CBUUID.init(string: "0xFE 0xA8 0x57")
//    public static let MUTE = ["0xFE", "0x68", "0x97"]//CBUUID.init(string: "0xFE 0x68 0x97")
    
    public static let VOLUME_UP = CBUUID.init(string: "0xFE") //["0xFE", "0xD8", "0x27"]
    public static let VOLUME_DW =  CBUUID.init(string: "0xFE") //["0xFE", "0x58", "0xA7"]

    public static let CHANNEL_UP = CBUUID.init(string: "0xFE") //["0xFE", "0x98", "0x67"]
    public static let CHANNEL_DW = CBUUID.init(string: "0xFE") //["0xFE", "0x98", "0x67"]

    public static let POWER = CBUUID.init(string: "0xFE")//["0xFE", "0xA8", "0x57"]
    public static let MUTE = CBUUID.init(string: "0xFE") //["0xFE", "0x68", "0x97"]

}
