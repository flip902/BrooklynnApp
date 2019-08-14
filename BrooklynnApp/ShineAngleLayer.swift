//
//  ShineAngleLayer.swift
//  BrooklynnApp
//
//  Created by William Savary on 2019-08-11.
//  Copyright © 2019 William Savary. All rights reserved.
//

import UIKit

class ShineAngleLayer: CALayer, CAAnimationDelegate {
    
    var params: ShineParams = ShineParams()
    var shineLayers: [CAShapeLayer] = [CAShapeLayer]()
    var smallShineLayers: [CAShapeLayer] = [CAShapeLayer]()
    var displayLink: CADisplayLink?
    
    init(frame: CGRect, params: ShineParams) {
        super.init()
        self.frame = frame
        self.params = params
        //addShines()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnim() {
        let radius = frame.size.width/2 * CGFloat(params.shineDistanceMultiple * 1.4)
        var startAngle: CGFloat = 0
        let angle = CGFloat(Double.pi*2/Double(params.shineCount)) + startAngle
        if params.shineCount % 2 != 0 {
            startAngle = CGFloat(Double.pi*2 - (Double(angle)/Double(params.shineCount)))
        }
        for i in 0..<params.shineCount {
            let bigShine = shineLayers[i]
            let bigAnim = getAngleAnim(shine: bigShine, angle: startAngle + CGFloat(angle)*CGFloat(i), radius: radius)
            let smallShine = smallShineLayers[i]
            var radiusSub = frame.size.width * 0.15 * 0.66
            if params.shineSize != 0 {
                radiusSub = params.shineSize * 0.66
            }
            let smallAnim = getAngleAnim(shine: smallShine, angle: startAngle + CGFloat(angle)*CGFloat(i) - CGFloat(params.smallShineOffsetAngle) * CGFloat(Double.pi)/180, radius: radius - radiusSub)
            bigShine.add(bigAnim, forKey: "path")
            smallShine.add(smallAnim, forKey: "path")
            if params.enableFlashing {
                let bigFlash = getFlashAnim()
                let smallFlash = getFlashAnim()
                bigShine.add(bigFlash, forKey: "bigFlash")
                smallShine.add(smallFlash, forKey: "smallFlash")
            }
        }
        let angleAnim = CABasicAnimation(keyPath: "transform.rotation")
        angleAnim.duration = params.animDuration * 0.87
        angleAnim.timingFunction = CAMediaTimingFunction(name: .linear)
        angleAnim.fromValue = 0
        angleAnim.toValue = CGFloat(params.shineTurnAngle) * CGFloat(Double.pi)/180
        angleAnim.delegate = self
        add(angleAnim, forKey: "rotate")
        if params.enableFlashing {
            startFlash()
        }
    }
    
    private func startFlash() {
        displayLink = CADisplayLink(target: self, selector: #selector(flashAction))
        if #available(iOS 10.0, *) {
            displayLink?.preferredFramesPerSecond = 10
        } else {
            displayLink?.frameInterval = 6
        }
        displayLink?.add(to: .current, forMode: .common)
    }
    
    private func addShines() {
        var startAngle: CGFloat = 0
        let angle = CGFloat(Double.pi*2/Double(params.shineCount)) + startAngle
        if params.shineCount%2 != 0 {
            startAngle = CGFloat(Double.pi*2 - (Double(angle)/Double(params.shineCount)))
        }
        let radius = frame.size.width/2 * CGFloat(params.shineDistanceMultiple)
        for i in 0..<params.shineCount {
            let bigShine = CAShapeLayer()
            var bigWidth = frame.size.width * 0.15
            if params.shineSize != 0 {
                bigWidth = params.shineSize
            }
            let center = getShineCenter(angle: startAngle + CGFloat(angle) * CGFloat(i), radius: radius)
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi) * 2, clockwise: false)
            bigShine.path = path.cgPath
            if params.allowRandomColor {
                let index = Int.random(in: 0..<params.colorRandom.count)
                bigShine.fillColor = params.colorRandom[index].cgColor
            } else {
                bigShine.fillColor = params.bigShineColor.cgColor
            }
            addSublayer(bigShine)
            shineLayers.append(bigShine)
            
            let smallShine = CAShapeLayer()
            let smallWidth = bigWidth * 0.66
            let smallCenter = getShineCenter(angle: startAngle + CGFloat(angle) * CGFloat(i) - CGFloat(params.smallShineOffsetAngle) * CGFloat(Double.pi)/180, radius: radius - bigWidth)
            let smallPath = UIBezierPath(arcCenter: smallCenter, radius: smallWidth, startAngle: 0, endAngle: CGFloat(Double.pi) * 2, clockwise: false)
            smallShine.path = smallPath.cgPath
            if params.allowRandomColor {
                let index = Int.random(in: 0..<params.colorRandom.count)
                smallShine.fillColor = params.colorRandom[index].cgColor
            } else {
                smallShine.fillColor = params.smallShineColor.cgColor
            }
            addSublayer(smallShine)
            smallShineLayers.append(smallShine)
        }
    }
    
    private func getAngleAnim(shine: CAShapeLayer, angle: CGFloat, radius: CGFloat) -> CABasicAnimation {
        let anim = CABasicAnimation(keyPath: "path")
        anim.duration = params.animDuration * 0.87
        anim.fromValue = shine.path
        let center = getShineCenter(angle: angle, radius: radius)
        let path = UIBezierPath(arcCenter: center, radius: 0.1, startAngle: 0, endAngle: CGFloat(Double.pi) * 2, clockwise: false)
        anim.toValue = path.cgPath
        anim.timingFunction = CAMediaTimingFunction(name: .easeOut)
        anim.isRemovedOnCompletion = false
        anim.fillMode = .forwards
        return anim
    }
    
    private func getFlashAnim() -> CABasicAnimation {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.fromValue = 1
        flash.toValue = 0
        //let duration = Double(arc4random()%20+60)/1000
        let duration = Double.random(in: 20...60)/1000
        flash.duration = duration
        flash.repeatCount = MAXFLOAT
        flash.isRemovedOnCompletion = false
        flash.autoreverses = true
        flash.fillMode = .forwards
        return flash
    }
    
    private func getShineCenter(angle: CGFloat, radius: CGFloat) -> CGPoint {
        let centx = bounds.midX
        let centy = bounds.midY
        var multiple: Int = 0
        if (angle >= 0 && angle <= CGFloat(90 * Double.pi/180)) {
            multiple = 1
        } else if (angle <= CGFloat(Double.pi) && angle > CGFloat(90 * Double.pi/180)) {
            multiple = 2
        } else if (angle > CGFloat(Double.pi) && angle <= CGFloat(270 * Double.pi/180)) {
            multiple = 3
        } else {
            multiple = 4
        }
        let resultAngel = CGFloat(multiple)*CGFloat(90 * Double.pi/180) - angle
        let a = sin(resultAngel) * radius
        let b = cos(resultAngel) * radius
        if (multiple == 1) {
            return CGPoint.init(x: centx + b, y: centy - a)
        } else if (multiple == 2) {
            return CGPoint.init(x: centx + a, y: centy + b)
        } else if (multiple == 3) {
            return CGPoint.init(x: centx - b, y: centy + a)
        } else {
            return CGPoint.init(x: centx - a, y: centy - b)
        }
    }
    
    @objc private func flashAction() {
        for i in 0..<params.shineCount {
            let bigShine = shineLayers[i]
            let smallShine = smallShineLayers[i]
            let index1 = Int.random(in: 0..<params.colorRandom.count)
            bigShine.fillColor = params.colorRandom[index1].cgColor
            let index2 = Int.random(in: 0..<params.colorRandom.count)
            smallShine.fillColor = params.colorRandom[index2].cgColor
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            displayLink?.invalidate()
            displayLink = nil
            removeAllAnimations()
            removeFromSuperlayer()
        }
    }
}
