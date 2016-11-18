//
//  ViewController.swift
//  ProjectRide
//
//  Created by Yannick Winter on 03.11.16.
//  Copyright © 2016 Yannick Winter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var locationTracker: LocationTracker?
    var locationGatherer: LocationGatherer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.locationTracker = LocationTracker.sharedInstance()
//        self.locationGatherer = LocationGatherer(delegate: self.locationTracker!)
//        do {
//            try locationGatherer?.startUpdatingLocation()
//        } catch {
//            print("Error starting, not authed")
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
