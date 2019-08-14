//
//  ShineButton.swift
//  BrooklynnApp
//
//  Created by William Savary on 2019-08-07.
//  Copyright © 2019 William Savary. All rights reserved.
//

import UIKit

@IBDesignable
public class ShineButton: UIControl {
    
    public var params: ShineParams {
        didSet {
            clickLayer.animDuration = params.animDuration/3
            shineLayer.params       = params
        }
    }
    
    @IBInspectable public var color: UIColor = UIColor.lightGray {
        willSet {
            clickLayer.color = newValue
        }
    }
    
    @IBInspectable public var fillColor: UIColor = UIColor(rgb: (255, 102, 102)) {
        willSet {
            clickLayer.fillColor = newValue
            shineLayer.fillColor = newValue
        }
    }
    
    public var image: ShineImage = .heart {
        willSet {
            clickLayer.image = newValue
        }
    }
    
    public override var isSelected: Bool {
        didSet {
            clickLayer.clicked = isSelected
        }
    }
    
    private var clickLayer = ShineClickLayer()
    
    private var shineLayer = ShineLayer()
    
    public init(frame: CGRect, params: ShineParams) {
        self.params = params
        super.init(frame: frame)
        initLayers()
    }
    
    public override init(frame: CGRect) {
        params = ShineParams()
        super.init(frame: frame)
        initLayers()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        params = ShineParams()
        super.init(coder: aDecoder)
        layoutIfNeeded()
        initLayers()
    }
    
    public func setClicked(_ clicked: Bool, animated: Bool = true) {
        guard clicked != clickLayer.clicked else {
            return
        }
        if clicked {
            shineLayer.endAnim = { [weak self] in
                self?.clickLayer.clicked = clicked
                if animated {
                    self?.clickLayer.startAnim()
                }
                self?.isSelected = clicked
            }
            if animated {
                shineLayer.startAnim()
            } else {
                shineLayer.endAnim?()
            }
        } else {
            clickLayer.clicked = clicked
            isSelected = clicked
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if clickLayer.clicked == false {
            shineLayer.endAnim = { [weak self] in
                self?.clickLayer.clicked = !(self?.clickLayer.clicked ?? false)
                self?.clickLayer.startAnim()
                self?.isSelected = self?.clickLayer.clicked ?? false
                self?.sendActions(for: .valueChanged)
            }
            shineLayer.startAnim()
        }else {
            clickLayer.clicked = !clickLayer.clicked
            isSelected = clickLayer.clicked
            sendActions(for: .valueChanged)
        }
    }
    
    private func initLayers() {
        clickLayer.animDuration = params.animDuration/3
        shineLayer.params       = params
        clickLayer.frame = bounds
        shineLayer.frame = bounds
        layer.addSublayer(clickLayer)
        layer.addSublayer(shineLayer)
    }
}
