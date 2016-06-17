//
//  ViewController.swift
//  Doman Cards
//
//  Created by Aliaksei Lyskovich on 6/14/16.
//  Copyright © 2016 Aliaksei Lyskovich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Animals: UIButton!
    @IBOutlet weak var bttnColor: UIButton!
    @IBOutlet weak var testLabel: UILabel!
    
    @IBAction func bttnColor(sender: AnyObject) {
        testLabel.text = "tested"
        print(Animals.currentTitle)
        performSegueWithIdentifier("showCard", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showCard") {
            let svc = segue.destinationViewController as! Card_ViewController;
            svc.toPass = "Colors"
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

