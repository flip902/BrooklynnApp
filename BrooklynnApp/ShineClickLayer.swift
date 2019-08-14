//
//  ShineClickLayer.swift
//  BrooklynnApp
//
//  Created by William Savary on 2019-08-10.
//  Copyright © 2019 William Savary. All rights reserved.
//

import UIKit

class ShineClickLayer: CALayer {
    
    var color: UIColor = UIColor.lightGray
    
    var fillColor: UIColor = UIColor(rgb: (255, 102, 102))
    
    var animDuration: Double = 0.5
    
    let maskLayer = CALayer()
    
    var image: ShineImage = .heart {
        didSet {
            if image.isDefaultAndSelect() || image.isCustom() {
                mask = nil
                contents = image.getImages().first?.cgImage
            } else {
                maskLayer.contents = image.getImages().first?.cgImage
                mask = maskLayer
            }
        }
    }
    
    var clicked: Bool = false {
        didSet {
            if image.isCustom() {
                // Do custom action here
                print("Custom Button Pressed")
            } else if image.isDefaultAndSelect() {
                backgroundColor = UIColor.clear.cgColor
                contents = clicked == true ? image.getImages().last?.cgImage : image.getImages().first?.cgImage
            } else {
                backgroundColor = clicked == true ? fillColor.cgColor : color.cgColor
            }
        }
    }
    
    func startAnim() {
        let anim = CAKeyframeAnimation(keyPath: "transform.scale")
        anim.duration = animDuration
        anim.values = [0.4, 1, 0.9, 1]
        anim.calculationMode = CAAnimationCalculationMode.cubic
        image.isDefaultAndSelect() ? add(anim, forKey: "scale") : maskLayer.add(anim, forKey: "scale")
    }
    
    override func layoutSublayers() {
        if image.isDefaultAndSelect() || image.isCustom() {
            backgroundColor = UIColor.clear.cgColor
        } else {
            maskLayer.frame = bounds
            maskLayer.contents = image.getImages().first?.cgImage
            mask = maskLayer
            backgroundColor = clicked ? fillColor.cgColor : color.cgColor
        }
    }
}
