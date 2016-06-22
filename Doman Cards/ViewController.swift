//
//  ViewController.swift
//  Doman Cards
//
//  Created by Aliaksei Lyskovich on 6/14/16.
//  Copyright © 2016 Aliaksei Lyskovich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bttnAnimals: UIButton!
    @IBOutlet weak var bttnColor: UIButton!
    var str: String!
    
    @IBAction func bttnColor(sender: AnyObject) {
        print(sender.currentTitle)
        str = sender.currentTitle
        performSegueWithIdentifier("card-view", sender: self)
    }
    
    @IBAction func bttnAnimals(sender: AnyObject) {
        print(sender.currentTitle)
        str = sender.currentTitle
        performSegueWithIdentifier("card-view", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "card-view") {
            let svc = segue.destinationViewController as! Card_ViewController;
            svc.toPass = str
        }
    }
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!, str:String) {
        if (segue.identifier == "showCard") {
            let svc = segue.destinationViewController as! Card_ViewController;
            svc.toPass = "Colors"
        }
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

