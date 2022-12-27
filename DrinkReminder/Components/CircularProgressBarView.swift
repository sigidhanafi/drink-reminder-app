//
//  CircularProgressBarView.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 22/12/22.
//

import UIKit

class CircularProgressBarView: UIView {
    
    // MARK: view
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    internal var targetLayer = CATextLayer()
    internal var percentageLayer = CATextLayer()
    
    // MARK: properties
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
        circleLayer.strokeColor = UIColor.secondaryBlue.cgColor
        
        // added circleLayer to layer
        layer.addSublayer(circleLayer)
        
        progressLayer.path = circularPath.cgPath
        
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 15.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.primaryBlue.cgColor
        
        // added progressLayer to layer
        layer.addSublayer(progressLayer)
        
        targetLayer.fontSize = 16
        targetLayer.string = "0.25 of 2 liters"
        targetLayer.foregroundColor = UIColor.black.withAlphaComponent(0.3).cgColor
        targetLayer.isWrapped = true
        targetLayer.alignmentMode = .center
        targetLayer.truncationMode = .end
        targetLayer.frame = CGRect(x: UIScreen.main.bounds.width/2 - 100, y: 0 + 20, width: 200, height: 100)
        targetLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(targetLayer)
        
        percentageLayer.fontSize = 56
        percentageLayer.string = "100%"
        percentageLayer.foregroundColor = UIColor.primaryBlue.cgColor
        percentageLayer.isWrapped = true
        percentageLayer.alignmentMode = .center
        percentageLayer.truncationMode = .end
        percentageLayer.frame = CGRect(x: UIScreen.main.bounds.width/2 - 100, y: 0 - 40, width: 200, height: 100)
        percentageLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(percentageLayer)
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
