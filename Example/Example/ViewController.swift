//
//  ViewController.swift
//  Example
//
//  Created by Rajesh Kumar Sahil on 13/02/2022.
//

import UIKit
import SwipeButton

class ViewController: UIViewController {

    @IBOutlet weak var gradient: UIView!
    @IBOutlet weak var swipe: SwipeButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
    }
    
    
    func setView(){
        
//        swipe.containerViewBorder(borderWidth: 2, with: .red)
//        swipe.swipeViewGradient(colors: .blue,.orange, startPoint: .bottomRight, endPoint: .topLeft)
    }
}

