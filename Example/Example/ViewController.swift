//
//  ViewController.swift
//  Example
//
//  Created by Rajesh Kumar Sahil on 13/02/2022.
//

import UIKit
import SwipeButton

class ViewController: UIViewController {

    @IBOutlet weak var swipe: SwipeButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        swipe.swipeViewBackgroundColor(color: .cyan)
        
    }


}

