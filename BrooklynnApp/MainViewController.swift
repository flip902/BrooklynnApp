//
//  MainViewController.swift
//  Brooklynn's App
//
//  Created by William Savary on 2019-07-17.
//  Copyright © 2019 William Savary. All rights reserved.
//

import UIKit
import BSAdditions

class MainViewController: UIViewController {
    
    private lazy var youTubeButton: BSCalculatorButton = {
        let button = BSCalculatorButton(frame: CGRect(x: view.center.x - 220, y: view.center.y, width: 100, height: 100))
        button.value = 9
        return button
    }()
    
    var params = ShineParams()
    lazy var shineButton: ShineButton = ShineButton(frame: CGRect(x: view.center.x, y: view.center.y, width: 100, height: 100), params: params)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
    
    func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        params.bigShineColor = .red
        params.smallShineColor = #colorLiteral(red: 0.9255749583, green: 0.2385140657, blue: 0.8625372052, alpha: 1)
        params.allowRandomColor = false
        params.enableFlashing = true
        params.shineCount = 15
        params.animDuration = 2
        params.smallShineOffsetAngle = 8
        shineButton.image = .custom(UIImage(imageLiteralResourceName: "heart"))
        
        view.addSubview(shineButton)
        view.addSubview(youTubeButton)
    }
    
    @objc private func startGame() {
        print("Start game button pressed")
    }

}
