//
//  Card-view.swift
//  Doman Cards
//
//  Created by Aliaksei Lyskovich on 6/15/16.
//  Copyright © 2016 Aliaksei Lyskovich. All rights reserved.
//

import Foundation

import UIKit

class Card_ViewController: UIViewController {
    
    @IBOutlet var navTitle: UINavigationItem!
    @IBOutlet weak var tlabel: UILabel!
    @IBOutlet weak var testimg: UIImageView!
    var toPass:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navTitle.title = "Cards: " + toPass
        tlabel.text = toPass
        testimg.image = UIImage(named: "animals-alligator")
        getF()
    }
    
    func getF(){
        
        let filemanager:NSFileManager = NSFileManager()
        let files = filemanager.enumeratorAtPath(NSHomeDirectory())
        while let file = files?.nextObject() {
            print(file)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}