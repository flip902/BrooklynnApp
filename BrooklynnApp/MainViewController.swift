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
        let button = BSCalculatorButton()
        button.value = 9
        return button
    }()
    
    lazy var startGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.backgroundColor = .systemBlue
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
    
    func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        #warning("put buttons in stackView")
        view.addSubview(youTubeButton)
        youTubeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: nil, bottom: nil, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 20, width: 100, height: 100)
        
        view.addSubview(startGameButton)
        startGameButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor, bottom: nil, left: nil, paddingTop: 0, paddingRight: 20, paddingBottom: 0, paddingLeft: 0, width: 100, height: 100)
    }
    
    @objc private func startGame() {
        print("Start game button pressed")
    }

}
