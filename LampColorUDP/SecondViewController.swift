//
//  SecondViewController.swift
//  LampColorUDP
//
//  Created by Tobias Just on 15.02.16.
//  Copyright © 2016 Tobias Just. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let EFFECT_ID = 1;
    var client:UDPClient=UDPClient(addr: "192.168.2.105", port: 1234)
    
    var items: [String] = ["Rainbow", "Rainbow Cycle", "Sunrise"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        let bytes:[UInt8] = [UInt8(EFFECT_ID), UInt8(indexPath.row)]
        print("send UDP Packet")
        print(bytes)
        client.send(data: bytes)
    }

}

