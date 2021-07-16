//
//  ViewController.swift
//  ionTabRemote-WifiTV
//
//  Created by pablo Gutierrez on 7/7/21.
//

import UIKit
import CoreBluetooth

var configuracionTV: configTV = configTV()

class ViewController: UIViewController, CBPeripheralDelegate, CBCentralManagerDelegate {
   
    @IBOutlet weak var PowerButton: UIButton!
    @IBOutlet weak var chanelUpButton: UIButton!
    @IBOutlet weak var chanelDownButton: UIButton!
    @IBOutlet weak var volumeDownButton: UIButton!
    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var volumUpButton: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private var mandoUID: CBUUID!

    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral!
    let heartRateServiceCBUUID = CBUUID(string: "0x180D")
    var ch: CBCharacteristic!
    
    public var VOLUME_UP:CBCharacteristic?
    public var VOLUME_DW:CBCharacteristic?

    public var CHANNEL_UP :CBCharacteristic?
    public var CHANNEL_DW :CBCharacteristic?

    public var POWER:CBCharacteristic?
    public var MUTE :CBCharacteristic?
    
    private var credencial = credentialsOBJ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.showSpiner(onView: self.view)
    
        PowerButton.round()
        chanelUpButton.roundUPButton()
        chanelDownButton.roundDowButton()
        volumeDownButton.roundDowButton()
        muteButton.round()
        volumUpButton.roundUPButton()
        
        
        communicationsServer.petition(petition:"login",
                                      credenciales: credencial)

        self.removeSpinner()
        
        
//        configuracionTV  = appDelegate.configtv
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)

    }
     
//    Method in charge of performing actions when the Bluetooth status changes. If it is on, it will search for the device that it has assigned through a service.
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Central state update")
        if central.state != .poweredOn {
            print("Central is not powered on")
        } else {
          print("Central scanning");
        
            centralManager.scanForPeripherals(withServices: nil,options: nil)

        }
        

            
            
        
    }

    // Find the device
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {

        print("Did discover peri", peripheral)
        
        if peripheral.name == configuracionTV.ble_name {
            
            print("Connect with", configuracionTV.ble_name)
            print(peripheral.identifier.uuidString)
            self.peripheral = peripheral
            self.peripheral.delegate = self
            self.centralManager.stopScan()
            self.centralManager.connect(self.peripheral, options: nil)

        }

                
        
    }
    
    // cuando el se conecta al dispositivo se lanza este metodo.
    
        func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
           
            if peripheral == self.peripheral {
                
                print("Connected and discover")
                peripheral.discoverServices(nil)
                
            }
        
        }
    
    

    
    // is in charge of managing the different buttons on the remote.
    
        func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
            if let services = peripheral.services {
                print("Services", services)
                for service in services {
                    print("service found")
                    //Now kick off discovery of characteristics
                    peripheral.discoverCharacteristics(nil, for: service)
                }
            } else {
                print("Peripherals", peripheral)
            }
        }
    
    // it is in charge of launching the requests to the device.
    
        func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
            
            if let characteristics = service.characteristics {
                for characteristic in characteristics {
                
                    print("Characteristic", characteristic)
                    self.ch = characteristic
                
                }
            }
        }
    
    func peripheral(_ peripheral: CBPeripheral,
                    didWriteValueFor characteristic: CBCharacteristic,
                    error: Error?) {
        if error != nil {
            print("Error write value", error!)
        } else {
            print("Did write value correctly")
        }
    }
 
    private func senAccionToRemote(withValue value: [UInt8]) {
        if self.peripheral != nil {
            let token = "12345678"
            let _data = NSData(bytes: token, length: token.count)
            self.peripheral.writeValue(_data as Data, for: self.ch, type: .withResponse)
            let data = NSData(bytes: value, length: value.count)
            self.peripheral.writeValue(data as Data, for: self.ch, type: .withResponse)
        }
    }

    @IBAction func powerAccion(_ sender: Any) {
        senAccionToRemote(withValue: peripheralCustom.POWER)
    }

    @IBAction func muteAccion(_ sender: Any) {
        senAccionToRemote(withValue: peripheralCustom.MUTE)
    }

    @IBAction func upVolAccion(_ sender: Any) {
        senAccionToRemote(withValue: peripheralCustom.VOLUME_UP)
    }

    @IBAction func dowVolAccion(_ sender: Any) {
        senAccionToRemote(withValue: peripheralCustom.VOLUME_DW)
    }

    @IBAction func upchanelAccion(_ sender: Any) {
        senAccionToRemote(withValue: peripheralCustom.CHANNEL_UP)
    }

    @IBAction func dowchanelAccion(_ sender: Any) {
        senAccionToRemote(withValue: peripheralCustom.CHANNEL_DW)
    }


}

