//
//  BrooklynnAppTests.swift
//  BrooklynnAppTests
//
//  Created by William Savary on 2019-07-25.
//  Copyright © 2019 William Savary. All rights reserved.
//

import XCTest
@testable import BrooklynnApp

class BrooklynnAppTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        
    }
    
    func test_MainViewController_isFirstViewController() {
        // given
        let appDelegate = AppDelegate()
        
        // when
        _ = appDelegate.application(.shared, didFinishLaunchingWithOptions: nil)
        
        // then
        XCTAssertTrue(appDelegate.window?.rootViewController is MainViewController)
    }

}
