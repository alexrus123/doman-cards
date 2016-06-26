//
//  TextChannel.swift
//  Doman Cards
//
//  Created by Aliaksei Lyskovich on 6/25/16.
//  Copyright © 2016 Aliaksei Lyskovich. All rights reserved.
//

import Foundation

// [START custom-channel-1]
// This custom channel class extends GCKCastChannel.
class TextChannel : GCKCastChannel {
    
    override func didReceiveTextMessage(message: String!) {
        print("Received message: \(message)")
    }
}