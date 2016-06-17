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
    
    @IBOutlet weak var tlabel: UILabel!
    @IBOutlet weak var testimg: UIImageView!
    var toPass:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tlabel.text = toPass
        testimg.image = UIImage(named: "alligator")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}