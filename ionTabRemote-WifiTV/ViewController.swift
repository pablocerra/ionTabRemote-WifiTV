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
        PowerButton.round()
        chanelUpButton.roundUPButton()
        chanelDownButton.roundDowButton()
        volumeDownButton.roundDowButton()
        muteButton.round()
        volumUpButton.roundUPButton()
        
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
                    peripheral.discoverCharacteristics(nil, for: service)
                }
            } else {
                print("Peripherals", peripheral)
            }
        }
    
    // se encarga de lanzar las peticiones al dispositivo.
    

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

