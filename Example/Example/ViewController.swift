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
        
        setView()
    }
    
    
    func setView(){
        swipe.containerViewBackgroundColor(color: .blue)
        swipe.containerViewBackgroundCornerRedius(cornerRadius: 20)
        swipe.containerViewBorder(borderWidth: 2, with: .red)
        swipe.containerViewBackgroundImage(image: <#T##UIImage?#>, contentMode: <#T##UIView.ContentMode?#>)
//        swipe.containerViewGradient(colors: .red,.blue,.cyan, startPoint: .topLeft, endPoint: .bottomRight)
        
        
        swipe.swipeViewBackgroundColor(color: .red)
        swipe.containerViewBackgroundColor(color: .blue)
    }


}

