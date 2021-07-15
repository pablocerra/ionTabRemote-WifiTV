//
//  peripheral.swift
//  ionTabRemote-WifiTV
//
//  Created by pablo Gutierrez on 12/7/21.
//

import Foundation
import CoreBluetooth

class peripheralCustom:NSObject {

    // Volume
    public static let VOLUME_UP:[UInt8] = [ 0xFE, 0xD8, 0x27 ]
    public static let VOLUME_DW:[UInt8] = [ 0xFE, 0x58, 0xA7 ]
    public static let MUTE:[UInt8] = [ 0xFE, 0x68, 0x97 ]

    // Channel
    public static let CHANNEL_UP:[UInt8] = [ 0xFE, 0x98, 0x67 ]
    public static let CHANNEL_DW:[UInt8] = [ 0xFE, 0x18, 0xE7 ]

    // Power
    public static let POWER:[UInt8] = [ 0xFE, 0xA8, 0x57 ]
}
