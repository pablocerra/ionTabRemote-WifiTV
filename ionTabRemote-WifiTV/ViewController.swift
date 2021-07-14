//
//  ViewController.swift
//  ionTabRemote-WifiTV
//
//  Created by pablo Gutierrez on 7/7/21.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBPeripheralDelegate, CBCentralManagerDelegate {
   
    
    

    @IBOutlet weak var PowerButton: UIButton!
    @IBOutlet weak var chanelUpButton: UIButton!
    @IBOutlet weak var chanelDownButton: UIButton!
    @IBOutlet weak var volumeDownButton: UIButton!
    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var volumUpButton: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var configuracionTV: configTV!
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

            configuracionTV  = appDelegate.configtv

            centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)

    }
     
//    metodo encargado de realizar acciones cuando cambia el estado del Bluetooth., Si esta encendido, se buscara el dispoitivo que que tiene asigando a traves de un servicio.
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Central state update")
        if central.state != .poweredOn {
            print("Central is not powered on")
        } else {
          print("Central scanning");
        
            centralManager.scanForPeripherals(withServices: nil,options: nil)
//            centralManager.scanForPeripherals(withServices: [mandoUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
            
//            mandoUID = CBUUID.init(string: "A3EE8092-7BB9-0324-4D6B-BCD569E6644A")
            
        }

            
            
        
    }

    // Busca el dispositivo
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {

        print("Did discover peri", peripheral)
        if peripheral.name == configuracionTV.ble_name {
            print("Connect with", configuracionTV.ble_name)
//            mandoUID = CBUUID.init(string: peripheral.identifier.uuidString)
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
    
    

    
    // se encarga de gestionar los diferntes botones que tiene el mando.
    
        func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
            if let services = peripheral.services {
                print("Services", services)
                for service in services {
                    print("service found")
                    //Now kick off discovery of characteristics
                    /*
                    peripheral.discoverCharacteristics([peripheralCustom.VOLUME_UP,
                                                        peripheralCustom.VOLUME_DW,
                                                        peripheralCustom.CHANNEL_UP,
                                                        peripheralCustom.CHANNEL_DW,
                                                        peripheralCustom.MUTE,
                                                        peripheralCustom.POWER,], for: service)*/
                    peripheral.discoverCharacteristics(nil, for: service)
                }
            } else {
                print("Peripherals", peripheral)
            }
        }
    
    // se encarga de lanzar las peticiones al dispositivo.
    

        func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
            print("Discover ch", service)
            if let characteristics = service.characteristics {
                print("Characteristicsssss", characteristics)
                for characteristic in characteristics {
                    print("Characteristic", characteristic)
                   
                    
                    self.ch = characteristic
                    
                    var parameter = "12345678"
                    let data = NSData(bytes: &parameter, length: parameter.count)
                    self.peripheral.writeValue(data as Data, for: self.ch, type: .withResponse)
                    
                }
            }
        }
    
    func peripheral(_ peripheral: CBPeripheral,
                    didWriteValueFor characteristic: CBCharacteristic,
                    error: Error?) {
        if error != nil {
            print("Error write value", error!)
        } else {
            print("Did write value", characteristic)
        }
    }
 
    private func senAccionToRemote( withCharacteristic characteristic: CBCharacteristic, withValue value: Data) {

                // Check if it has the write property
                if characteristic.properties.contains(.writeWithoutResponse) && peripheral != nil {

                    //peripheral.writeValue(value, for: characteristic, type: .withoutResponse)
                    //let data = NSData(bytes: value, length: 1)

                    peripheral.writeValue(value, for: characteristic, type: .withResponse)
                    
                }

        
            }
    
    @IBAction func powerAccion(_ sender: Any) {
        
//        senAccionToRemote(withCharacteristic: POWER!, withValue: peripheralCustom.POWER.data )
        
        let parameter = [0xFE, 0xA8, 0x57]
        let data = NSData(bytes: parameter, length: parameter.count)
        self.peripheral.writeValue(data as Data, for: self.ch, type: .withResponse)
        
    }
    
    @IBAction func muteAccion(_ sender: Any) {
        
        let parameter = [0xFE, 0x68, 0x97]
        let data = NSData(bytes: parameter, length: parameter.count)
        self.peripheral.writeValue(data as Data, for: self.ch, type: .withResponse)
        
    }
    
    @IBAction func upVolAccion(_ sender: Any) {
      print("Vol up")
        //senAccionToRemote(withCharacteristic: VOLUME_DW!, withValue: peripheralCustom.VOLUME_DW.data )
        let parameter = [0xFE, 0xD8, 0x27] // 0xFED827
        let data = NSData(bytes: parameter, length: parameter.count)
        self.peripheral.writeValue(data as Data, for: self.ch, type: .withResponse)
    }
    
    @IBAction func dowVolAccion(_ sender: Any) {
        
        let parameter = [0xFE, 0x58, 0xA7]
        let data = NSData(bytes: parameter, length: parameter.count)
        self.peripheral.writeValue(data as Data, for: self.ch, type: .withResponse)
        
    }
    
    @IBAction func upchanelAccion(_ sender: Any) {
        
        let parameter = [0xFE, 0x98, 0x67]
        let data = NSData(bytes: parameter, length: parameter.count)
        self.peripheral.writeValue(data as Data, for: self.ch, type: .withResponse)
        
    }
    
    @IBAction func dowchanelAccion(_ sender: Any) {
        
        let parameter = [0xFE, 0x18, 0xE7]
        let data = NSData(bytes: parameter, length: parameter.count)
        self.peripheral.writeValue(data as Data, for: self.ch, type: .withResponse)
        
    }
}

