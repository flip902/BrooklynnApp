//
//  CalculatorButton.swift
//  BrooklynnApp
//
//  Created by William Savary on 2019-08-13.
//  Copyright © 2019 William Savary. All rights reserved.
//

import UIKit

class BSCalculatorButton: UIControl {
    // The value to display on the button
    public var value: Int = 0 {
        didSet {
            label.text = "\(value)"
        }
    }
    
    private var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private var animator = UIViewPropertyAnimator()
    
    private let normalColor: UIColor = .systemGray
    private let highlightedColor = UIColor(white: 1, alpha: 0.8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    private func sharedInit() {
        backgroundColor = normalColor
        
        addTarget(self, action: #selector(touchDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(touchUp), for: [.touchDragExit, .touchCancel])
        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        
        addSubview(label)
        label.center(in: self)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 75, height: 75)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
    
    @objc private func touchDown() {
        animator.stopAnimation(true)
        backgroundColor = highlightedColor
    }
    
    @objc private func touchUp() {
        animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut, animations: {
            self.backgroundColor = self.normalColor
        })
        animator.startAnimation()
    }
    
    @objc private func touchUpInside() {
        animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut, animations: {
            self.backgroundColor = self.normalColor
        })
        animator.startAnimation()
        print("YouTube button pressed")
    }
}

extension UIView {
    func center(in view: UIView, offset: UIOffset = .zero) {
        UIView.activate(constraints: [
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset.horizontal),
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset.vertical)
        ])
    }
    
    static func activate(constraints: [NSLayoutConstraint]) {
        constraints.forEach { ($0.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate(constraints)
    }
}

extension UIColor {
    public convenience init(rgb: (r: CGFloat, g: CGFloat, b: CGFloat)) {
        self.init(red: rgb.r/255, green: rgb.g/255, blue: rgb.b/255, alpha: 1.0)
    }
}
