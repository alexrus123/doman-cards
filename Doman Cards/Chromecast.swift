//
//  Chromecast.swift
//  Doman Cards
//
//  Created by Aliaksei Lyskovich on 7/11/16.
//  Copyright © 2016 Aliaksei Lyskovich. All rights reserved.
//

import Foundation

class Chromecast : GCKDeviceScanner, GCKDeviceScannerListener {
    private let kReceiverAppID = "666B12A9"
    private var deviceScanner:GCKDeviceScanner?
    
    func CCinit(){
        //Chromecast setup:
        // Establish filter criteria.
        let filterCriteria = GCKFilterCriteria(forAvailableApplicationWithID: kReceiverAppID)
        
        // Initialize device scanner.
        deviceScanner = GCKDeviceScanner(filterCriteria: filterCriteria)
        if let deviceScanner = deviceScanner {
            deviceScanner.addListener(self)
            deviceScanner.startScan()
            deviceScanner.passiveScan = true
        }
    }
}