//
//  SwipeButton.swift
//  SwipeButton
//
//  Created by Rajesh Kumar Sahil on 12/02/2022.
//

import Foundation
import UIKit

public class SwipeButton: UIView{
    
    //MARK: Outlets
    @IBOutlet private var containerView: UIView!
    @IBOutlet private weak var swipeView: UIView!
    @IBOutlet private weak var swipeViewImage: UIImageView!
    @IBOutlet weak var containerViewImage: UIImageView!
    
    
    //MARK: Constants
    private let swipeButtonXibName = "SwipeButton"
    private var leftPass:Bool = false
    private var rightPass:Bool = false
    
    public var delegate:SwipeButtonDeletage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
        setupView()
    }
   
    public override func awakeFromNib() {
        setupView()
    }
    
    internal func loadNib() {
        let view = getNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    internal func getNib() -> UIView {
        let bundle = Bundle(for: SwipeButton.self)
        let nib = UINib(nibName: swipeButtonXibName, bundle: bundle)
        guard let swipeButton = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return UIView()
        }
        return swipeButton
    }
    
    
    @IBAction func didStartPanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.containerView)
        swipeView.center = CGPoint(x: swipeView.center.x + translation.x, y:swipeView.center.y)
        gesture.setTranslation(CGPoint.zero, in: self.containerView)
        
        switch gesture.state {
        case .changed:
            
            if self.swipeView.frame.maxX  >= self.containerView.frame.size.width - (self.containerView.frame.size.width / 4)
                && self.swipeView.frame.midX <= self.containerView.frame.size.width - (self.containerView.frame.size.width / 4){
                rightPass = true
                
            }else if self.swipeView.frame.minX <= self.containerView.frame.size.width / 4 && self.swipeView.frame.midX >= self.containerView.frame.size.width / 4{
                leftPass = true
            }

            
            if self.swipeView.frame.maxX  >= self.containerView.frame.size.width{
                gesture.isEnabled = false
                self.swipeView.center.x = self.containerView.layer.frame.width - self.swipeView.layer.frame.width / 2
            }else if self.swipeView.frame.minX <= .zero{
                gesture.isEnabled = false
                self.swipeView.center.x = swipeView.frame.width/2
            }
        case .ended:
            if self.swipeView.frame.midX >= self.containerView.layer.frame.width / 1.3 {
                if rightPass{
                    rightPass.toggle()
                    self.delegate?.didSwipeRight()
                }
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.swipeView.center.x = self.containerView.layer.frame.width - self.swipeView.layer.frame.width / 2
                }, completion: nil)
            }else if self.swipeView.frame.midX <= self.containerView.layer.frame.width / 5{
                if leftPass{
                    leftPass.toggle()
                    self.delegate?.didSwipeLeft()
                    
                }
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.swipeView.center.x = self.swipeView.layer.frame.width / 2
                }, completion: nil)
            }else{
                self.leftPass = false
                self.rightPass = false
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.swipeView.center.x = self.containerView.layer.frame.width / 2
                }, completion: nil)
            }
        case .cancelled:
            gesture.isEnabled = true
            if rightPass{
                rightPass.toggle()
                self.delegate?.didSwipeRight()
            }else if leftPass{
                leftPass.toggle()
                self.delegate?.didSwipeLeft()
            }
        default:
            print("")
        }
    }
    
}


//MARK: Private Functions
fileprivate extension SwipeButton{
    func setupView(){
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = containerView.frame.size.height / 2
        
        swipeView.clipsToBounds = true
        swipeView.layer.cornerRadius = swipeView.frame.size.height / 2
    }
}


//MARK: Public Functions
extension SwipeButton{
    
    public enum Point {
            case topLeft
            case centerLeft
            case bottomLeft
            case topCenter
            case center
            case bottomCenter
            case topRight
            case centerRight
            case bottomRight
        
            var point: CGPoint {
                switch self {
                case .topLeft:
                    return CGPoint(x: 0, y: 0)
                case .centerLeft:
                    return CGPoint(x: 0, y: 0.5)
                case .bottomLeft:
                    return CGPoint(x: 0, y: 1.0)
                case .topCenter:
                    return CGPoint(x: 0.5, y: 0)
                case .center:
                    return CGPoint(x: 0.5, y: 0.5)
                case .bottomCenter:
                    return CGPoint(x: 0.5, y: 1.0)
                case .topRight:
                    return CGPoint(x: 1.0, y: 0.0)
                case .centerRight:
                    return CGPoint(x: 1.0, y: 0.5)
                case .bottomRight:
                    return CGPoint(x: 1.0, y: 1.0)
                }
            }
        }
    
    //MARK: ContainerView
    public func containerViewBackgroundColor(color: UIColor){
        self.containerView.backgroundColor = color
    }
    
    public func containerViewBackgroundCornerRedius(cornerRadius: CGFloat){
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = cornerRadius
    }
    
    public func containerViewBackgroundBorder(borderWidth: CGFloat, with color: UIColor?){
        self.containerView.layer.borderWidth = borderWidth
        self.containerView.layer.borderColor = color?.cgColor
    }

    public func containerViewGradient(colors:UIColor..., startPoint: Point, endPoint: Point){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint.point
        gradientLayer.endPoint = endPoint.point
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        containerView.layer.addSublayer(gradientLayer)
    }
    
    public func containerViewBackgroundImage(image: UIImage?, contentMode: UIView.ContentMode?){
        containerViewImage.image = image
        if let contentMode = contentMode {
            containerViewImage.contentMode = contentMode
        }
    }
    
    
    //MARK: SwipeView
    public func swipeViewBackgroundColor(color: UIColor){
        self.swipeView.backgroundColor = color
    }
    
    public func swipeViewBackgroundCornerRedius(cornerRadius: CGFloat){
        self.swipeView.clipsToBounds = true
        self.containerView.layer.cornerRadius = cornerRadius
    }
    
    public func swipeViewBackgroundBorder(borderWidth: CGFloat, with color: UIColor?){
        self.swipeView.layer.borderWidth = borderWidth
        self.swipeView.layer.borderColor = color?.cgColor
    }

    public func swipeViewGradient(colors:UIColor..., startPoint: Point, endPoint: Point){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint.point
        gradientLayer.endPoint = endPoint.point
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        swipeView.layer.addSublayer(gradientLayer)
    }
    
    public func swipeViewBackgroundImage(image: UIImage?, contentMode: UIView.ContentMode?){
        swipeViewImage.image = image
        if let contentMode = contentMode {
            swipeViewImage.contentMode = contentMode
        }
    }
}



