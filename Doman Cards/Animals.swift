//
//  Animals.swift
//  Doman Cards
//
//  Created by Aliaksei Lyskovich on 6/21/16.
//  Copyright © 2016 Aliaksei Lyskovich. All rights reserved.
//

import Foundation

class Animals {
    
    var animalsArray:[String] = ["Alligator","Bear","Lion","Gorilla","Elephant","Wolf"]
    
    func returnArray(index: NSInteger) -> String {
        return animalsArray[index]
    }
    
    func callMe(){
        printA(animalsArray)
    }
    
    func printA(arrayA: [String]){
        print(arrayA[1])
    }
}