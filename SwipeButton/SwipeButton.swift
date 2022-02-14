//
//  SwipeButton.swift
//  SwipeButton
//
//  Created by Rajesh Kumar Sahil on 12/02/2022.
//

import Foundation
import UIKit

public class SwipeButton: BaseView {
    
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
    
    // MARK: Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromNib()
    }
    
    public override func draw(_ rect: CGRect) {
        setCorners()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    func setupFromNib() {
        super.nibName = String(describing: Self.self)
        super.setupFromNib()
        
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
    
    func setCorners(){
        swipeView.layer.cornerRadius = swipeView.frame.size.height / 2
        swipeView.clipsToBounds = true
        
        containerView.layer.cornerRadius = containerView.frame.size.height / 2
        containerView.clipsToBounds = true
    }
    
    func setupView(){
        self.backgroundColor = .clear
        containerView.backgroundColor = .systemGreen
        swipeView.backgroundColor = .cyan
    }
    
    func getGradientLayer(colors: [UIColor], startPoint: Point, endPoint: Point) -> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
        var cgColurs = [CGColor]()
        for colur in colors {
            cgColurs.append(colur.cgColor)
        }
        gradientLayer.colors = cgColurs
        gradientLayer.startPoint = startPoint.point
        gradientLayer.endPoint = endPoint.point
        gradientLayer.locations = [0, 1]
        return gradientLayer
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
    
    public func containerViewBorder(borderWidth: CGFloat, with color: UIColor?){
        self.containerView.layer.borderWidth = borderWidth
        self.containerView.layer.borderColor = color?.cgColor
    }

    public func containerViewGradient(colors: [UIColor], startPoint: Point, endPoint: Point){
        let gradientLayer = getGradientLayer(colors: colors, startPoint: startPoint, endPoint: endPoint)
        gradientLayer.frame = containerView.bounds
        containerView.layer.insertSublayer(gradientLayer, at: 0)
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
        let gradientLayer = getGradientLayer(colors: colors, startPoint: startPoint, endPoint: endPoint)
        gradientLayer.frame = bounds
        swipeView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    public func swipeViewBackgroundImage(image: UIImage?, contentMode: UIView.ContentMode?){
        swipeViewImage.image = image
        if let contentMode = contentMode {
            swipeViewImage.contentMode = contentMode
        }
    }
}
