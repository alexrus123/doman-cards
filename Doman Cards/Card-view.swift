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
    var imageIndex: NSInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testimg.userInteractionEnabled = true
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(Card_ViewController.swiped(_:))) // put : at the end of method name
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(Card_ViewController.swiped(_:))) // put : at the end of method name
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        navTitle.title = "Cards: " + toPass
        //tlabel.text = toPass
        //testimg.image = UIImage(named: "Wolf")
        caseToDisplay(toPass)
    }
    
    func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right :
                print("User swiped right")
                imageIndex -= 1
                // check if index is in range
                if imageIndex < 0 {
                    imageIndex = 5
                }
                caseToDisplay(toPass)
                
            case UISwipeGestureRecognizerDirection.Left:
                print("User swiped Left")
                imageIndex += 1
                // check if index is in range
                if imageIndex > 5 {
                    imageIndex = 0
                }
                caseToDisplay(toPass)
            default:
                break //stops the code/codes nothing.
            }
        }
    }
    
    func caseToDisplay(str: String){
        switch str {
        case "Animals":
            displayIndex(Utils().returnArray(Animals().animalsArray, index: imageIndex))
        case "Fruits":
            displayIndex(Utils().returnArray(Fruits().fruitsArray, index: imageIndex))
        case "Veggie":
            displayIndex(Utils().returnArray(Veggie().veggieArray, index: imageIndex))
        case "Colors":
            print("")
        default:
            print(str)
        }
    }
    
    func displayIndex(str: String){
        testimg.image = UIImage(named: str)
        tlabel.text = str
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}