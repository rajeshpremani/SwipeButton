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
//        swipe.containerViewBackgroundColor(color: .blue)
        swipe.containerViewBackgroundCornerRedius(cornerRadius: 20)
        swipe.containerViewBorder(borderWidth: 2, with: .red)
//        containerViewGradient(colors: [.cyan, .blue])
//        swipe.containerViewBackgroundImage(image: UIImage(named: "imageName"), contentMode: nil)
//        swipe.containerViewGradient(colors: [.red,.cyan], startPoint: .topLeft, endPoint: .bottomRight)
//
//
//        swipe.swipeViewBackgroundColor(color: .red)
//        swipe.containerViewBackgroundColor(color: .blue)
        
        swipe.swipeViewGradient(colors: .blue,.orange, startPoint: .bottomRight, endPoint: .topLeft)
    }


    func containerViewGradient(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = gradient.bounds.size
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        gradient.layer.addSublayer(gradientLayer)
    }
}

