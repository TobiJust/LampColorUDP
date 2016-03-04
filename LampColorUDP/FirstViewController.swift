//
//  ViewController.swift
//  SwiftUDPColor
//
//  Created by Tobias Just on 23.01.16.
//  Copyright © 2016 Tobias Just. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mySampleColorButton: UIButton!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var ipTextField: UITextField!
    
    let RGB_ID = 0;
    
    var client:UDPClient=UDPClient(addr: "192.168.2.105", port: 1234)
    
    
    //MARK: - Actions

    
    @IBAction func redSliderChanged(sender: UISlider) {
        let red = CGFloat(sender.value)
        sender.thumbTintColor = UIColor(
            red: red,
            green: 0.0,
            blue: 0.0,
            alpha: 1.0)
        displayColors()
    }
    
    @IBAction func greenSliderChanged(sender: UISlider) {
        let green = CGFloat(sender.value)
        sender.thumbTintColor = UIColor(
            red: 0.0,
            green: green,
            blue: 0.0,
            alpha: 1.0)
        displayColors()
        
    }
    @IBAction func blueSliderChanged(sender: UISlider) {
        let blue = CGFloat(sender.value)
        sender.thumbTintColor = UIColor(
            red: 0.0,
            green: 0.0,
            blue: blue,
            alpha: 1.0)
        displayColors()
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        // Hide the Keyboard
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(textField: UITextField){
        print(textField.text!)
        client = UDPClient(addr: textField.text!, port: 1234)
    }
    
    //MARK: - instance methods
    func displayColors(){
        //create a color from the sliders.
        let red = CGFloat(redSlider.value)
        let blue = CGFloat(blueSlider.value)
        let green = CGFloat(greenSlider.value)
        
        let color = UIColor(
            red: red,
            green: green,
            blue: blue,
            alpha: 1.0)
        //apply the color to the background or text
        mySampleColorButton.backgroundColor = color
        
        let myTitleText = String(
            format: "%6.2f,%6.2f,%6.2f",
            Float(red),
            Float(green),
            Float(blue))
        mySampleColorButton.setTitle(
            myTitleText,
            forState: .Normal)
        
        let bytes:[UInt8] = [UInt8(RGB_ID), UInt8(red * 255), UInt8(green * 255), UInt8(blue * 255)]
        print("send UDP Packet")
        print(bytes)
        client.send(data: bytes)
        //client.close()
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Set the button's back ground with a RGB specfied color
        // a hex number, and decimal and a 1-0 all work -- this is gray
        mySampleColorButton.backgroundColor = UIColor(red: 0x80/255, green: 128/255.0, blue: 0.5, alpha: 1.0)
        
        //This is syntactically correct but does nothing
        mySampleColorButton.titleLabel?.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        //the right way to set a color on a button title
        mySampleColorButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        mySampleColorButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Disabled)
        
        //set the background color to #fde8d7
        view.backgroundColor = UIColor(red: 0xfd/255, green: 0xe8/255, blue: 0xd7/255, alpha: 1.0)
        
        ipTextField.delegate = self
        
    }
    
}
