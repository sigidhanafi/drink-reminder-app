//
//  CircularProgressBarView.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 22/12/22.
//

import UIKit

class CircularProgressBarView: UIView {
    
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    internal var targetLayer = CATextLayer()
    private let startPoint = CGFloat(-Double.pi / 2)
    private let endPoint = CGFloat(3 * Double.pi / 2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func createCircularPath() {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: UIScreen.main.bounds.width/2, y: 0), radius: UIScreen.main.bounds.width * 1 / 3, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        
        circleLayer.path = circularPath.cgPath
        
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 20.0
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = UIColor.blue.withAlphaComponent(0.1).cgColor
        
        // added circleLayer to layer
        layer.addSublayer(circleLayer)
        
        progressLayer.path = circularPath.cgPath
        
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 15.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.blue.withAlphaComponent(0.5).cgColor
        
        // added progressLayer to layer
        layer.addSublayer(progressLayer)
        
        targetLayer.fontSize = 32
        targetLayer.string = "0 liters"
        targetLayer.foregroundColor = UIColor.blue.withAlphaComponent(0.5).cgColor
        targetLayer.isWrapped = true
        targetLayer.alignmentMode = .center
        targetLayer.truncationMode = .end
        targetLayer.frame = CGRect(x: UIScreen.main.bounds.width/2 - 50, y: 0 - 40, width: 100, height: 100)
        layer.addSublayer(targetLayer)
    }
    
    internal func progressAnimation(fromValue: CGFloat, toValue: CGFloat) {
        // created circularProgressAnimation with keyPath
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        // set the end time
        circularProgressAnimation.duration = toValue - fromValue < 0.15 ? 1 : 2
        circularProgressAnimation.toValue = toValue
        circularProgressAnimation.fromValue = fromValue
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
    
}
