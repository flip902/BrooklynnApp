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
    
    var image: ShineImage = .heart {
        didSet {
            if image.isDefaultAndSelect() {
                mask     = nil
                contents = image.getImages().first?.cgImage
            }else {
                maskLayer.contents = image.getImages().first?.cgImage
                mask = maskLayer
            }
        }
    }
    
    var animDuration: Double = 0.5
    
    var clicked: Bool = false {
        didSet {
            if image.isDefaultAndSelect() {
                backgroundColor = UIColor.clear.cgColor
                if clicked {
                    contents = image.getImages().last?.cgImage
                }else {
                    contents = image.getImages().first?.cgImage
                }
            }else {
                if clicked {
                    backgroundColor = fillColor.cgColor
                }else {
                    backgroundColor = color.cgColor
                }
            }
        }
    }
    
    let maskLayer = CALayer()
    
    //MARK: Public Methods
    func startAnim() {
        let anim = CAKeyframeAnimation(keyPath: "transform.scale")
        anim.duration  = animDuration
        anim.values = [0.4, 1, 0.9, 1]
        anim.calculationMode = CAAnimationCalculationMode.cubic
        if image.isDefaultAndSelect() {
            add(anim, forKey: "scale")
        }else {
            maskLayer.add(anim, forKey: "scale")
        }
    }
    
    override func layoutSublayers() {
        if image.isDefaultAndSelect() {
            backgroundColor = UIColor.clear.cgColor
        }else {
            maskLayer.frame = bounds
            maskLayer.contents = image.getImages().first?.cgImage
            mask = maskLayer
            if clicked {
                backgroundColor = fillColor.cgColor
            }else {
                backgroundColor = color.cgColor
            }
        }
    }
}
