//
//  ViewController.swift
//  Doman Cards
//
//  Created by Aliaksei Lyskovich on 6/14/16.
//  Copyright © 2016 Aliaksei Lyskovich. All rights reserved.
//
//sleep
import UIKit

class ViewController: UIViewController, UIActionSheetDelegate, GCKDeviceManagerDelegate, GCKDeviceScannerListener {

    @IBOutlet weak var bttnAnimals: UIButton!
    @IBOutlet weak var bttnColor: UIButton!
    @IBOutlet weak var bttnVeggie: UIButton!
    @IBOutlet weak var sendText: UIButton!
    var str: String!
    
    //Chromecast vars
    private let kCancelTitle = "Cancel"
    private let kDisconnectTitle = "Disconnect"
    // Publicly available receiver to demonstrate sending messages - replace this with your
    // own custom app ID.
    private let kReceiverAppID = "666B12A9"
    //"74F6413F"//kGCKMediaDefaultReceiverApplicationID
    private lazy var btnImage:UIImage = {
        return UIImage(named: "icon-cast-identified.png")!
    }()
    private lazy var btnImageselected:UIImage = {
        return UIImage(named: "icon-cast-connected.png")!
    }()
    
    private lazy var textChannel:TextChannel = {
        //return TextChannel(namespace: "urn:x-cast:com.google.cast.sample.helloworld")
        return TextChannel(namespace: "urn:x-cast:com.google.cast.qatsys")
    }()
    
    private var deviceScanner:GCKDeviceScanner?
    private var deviceManager:GCKDeviceManager?
    private var mediaInformation:GCKMediaInformation?
    private var selectedDevice:GCKDevice?
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var googleCastButton: UIBarButtonItem!
    
    @IBAction func bttnColor(sender: AnyObject) {
        print(sender.currentTitle)
        str = sender.currentTitle
        textChannel.sendTextMessage(str)
        performSegueWithIdentifier("card-view", sender: self)
    }
    
    @IBAction func bttnAnimals(sender: AnyObject) {
        print(sender.currentTitle)
        str = sender.currentTitle
        textChannel.sendTextMessage(str)
        performSegueWithIdentifier("card-view", sender: self)
    }
    
    @IBAction func bttnVeggie(sender: AnyObject) {
        print(sender.currentTitle)
        str = sender.currentTitle
        textChannel.sendTextMessage(str)
        performSegueWithIdentifier("card-view", sender: self)
    }
    
    @IBAction func sendText(sender: AnyObject?) {
        
        if (!(self.deviceManager?.connectionState == GCKConnectionState.Connected)) {
            let alert = UIAlertController(title: "Not Connected", message: "Please connect to a Cast device.", preferredStyle: UIAlertControllerStyle.Alert);
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                return;
            }
            /*
            // [START custom-channel-2]
            let textChannel = // [START_EXCLUDE]
                self.textChannel
            // [END_EXCLUDE]
            let textMessage = // [START_EXCLUDE silent]
                messageField.text
            // [END_EXCLUDE]
            // a String
            */
            textChannel.sendTextMessage("My message here YAY!!!")
            // [END custom-channel-2]
        //textChannel.sendTextMessage("YA LUBLYU NATASHENKU :)")
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "card-view") {
            let svc = segue.destinationViewController as! Card_ViewController;
            svc.toPass = str
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Chromecast().CCinit()
    }
    
    func connectToDevice() {
        if (selectedDevice == nil) {
            return
        }
        // [START device-selection]
        let identifier = NSBundle.mainBundle().bundleIdentifier
        deviceManager = GCKDeviceManager(device: selectedDevice, clientPackageName: identifier)
        deviceManager!.delegate = self
        deviceManager!.connect()
        // [END device-selection]
    }
    
    func deviceDisconnected() {
        selectedDevice = nil
        deviceManager = nil
    }
    
    func showError(error: NSError) {
        let alert = UIAlertController(title: "Error", message: error.description,
                                      preferredStyle: UIAlertControllerStyle.Alert);
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    

    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if let deviceScanner = deviceScanner {
            deviceScanner.passiveScan = true
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                return;
            } else if (selectedDevice == nil) {
                if (buttonIndex < deviceScanner.devices.count) {
                    selectedDevice = deviceScanner.devices[buttonIndex] as? GCKDevice;
                    print("Selected device: \(selectedDevice!.friendlyName)");
                    connectToDevice();
                }
            } else if (actionSheet.buttonTitleAtIndex(buttonIndex) == kDisconnectTitle) {
                // Disconnect button.
                deviceManager!.leaveApplication();
                deviceManager!.disconnect();
                deviceDisconnected();
                updateButtonStates();
            }
        }
    }
    
    
    func updateButtonStates() {
        if (deviceScanner!.devices.count > 0) {
            // Show the Cast button.
            navigationItem.rightBarButtonItems = [googleCastButton!]
            if (deviceManager != nil && deviceManager?.connectionState == GCKConnectionState.Connected) {
                // Show the Cast button in the enabled state.
                googleCastButton!.tintColor = UIColor.blueColor()
            } else {
                // Show the Cast button in the disabled state.
               googleCastButton!.tintColor = UIColor.grayColor()
            }
        } else{
            // Don't show Cast button.
            navigationItem.rightBarButtonItems = []
        }
    }
    
    // MARK: GCKDeviceScannerListener
    
    func deviceDidComeOnline(device: GCKDevice!) {
        print("Device found: \(device.friendlyName)");
        updateButtonStates();
    }
    
    func deviceDidGoOffline(device: GCKDevice!) {
        print("Device went away: \(device.friendlyName)");
        updateButtonStates();
    }

    @IBAction func chooseDevice(sender:AnyObject) {
        if (selectedDevice == nil) {
            // [START showing-devices]
            let sheet : UIActionSheet = UIActionSheet(title: "Connect to Device", delegate: self, cancelButtonTitle: nil, destructiveButtonTitle:nil)
            
            // [END_EXCLUDE]
            if let deviceScanner = deviceScanner {
                deviceScanner.passiveScan = false
                for device in deviceScanner.devices  {
                    sheet.addButtonWithTitle(device.friendlyName)
                }
            }
            // [START_EXCLUDE]
            // Add the cancel button at the end so the indices of the titles map to the array indices.
            sheet.addButtonWithTitle(kCancelTitle);
            sheet.cancelButtonIndex = sheet.numberOfButtons - 1;
            // [END_EXCLUDE]
            
            sheet.showInView(self.view)
            // [END showing-devices]
            
        } else {
            let friendlyName = "Casting to \(selectedDevice!.friendlyName)";
            
            let sheet : UIActionSheet = UIActionSheet(title: friendlyName, delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil);
            
            var buttonIndex = 0;
            
            if let info = mediaInformation {
                sheet.addButtonWithTitle((info.metadata.objectForKey(kGCKMetadataKeyTitle) as! String));
                buttonIndex += 1;
            }
            
            // Offer disconnect option.
            sheet.addButtonWithTitle(kDisconnectTitle);
            sheet.addButtonWithTitle(kCancelTitle);
            sheet.destructiveButtonIndex = buttonIndex++;
            sheet.cancelButtonIndex = buttonIndex;
            
            sheet.showInView(self.view);
        }
    }
    
    // [START launch-application]
    // MARK: GCKDeviceManagerDelegate
    func deviceManagerDidConnect(deviceManager: GCKDeviceManager!) {
        print("Connected.");
        
        // [START_EXCLUDE silent]
        updateButtonStates();
        // [END_EXCLUDE]
        deviceManager.launchApplication(kReceiverAppID);
    }
    // [END launch-application]
    
    func deviceManager(deviceManager: GCKDeviceManager!,
                       didConnectToCastApplication
        applicationMetadata: GCKApplicationMetadata!,
        sessionID: String!,
        launchedApplication: Bool) {
        print("Application has launched.");
        deviceManager.addChannel(self.textChannel)
        print("------Post launch message.");
    }
    
    func deviceManager(deviceManager: GCKDeviceManager!,
                       didFailToConnectToApplicationWithError error: NSError!) {
        print("Received notification that device failed to connect to application.");
        
        showError(error);
        deviceDisconnected();
        updateButtonStates();
    }
    
    func deviceManager(deviceManager: GCKDeviceManager!,
                       didFailToConnectWithError error: NSError!) {
        print("Received notification that device failed to connect.");
        
        showError(error);
        deviceDisconnected();
        updateButtonStates();
    }
    
    func deviceManager(deviceManager: GCKDeviceManager!,
                       didDisconnectWithError error: NSError!) {
        print("Received notification that device disconnected.");
        
        if (error != nil) {
            showError(error)
        }
        
        deviceDisconnected();
        updateButtonStates();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

