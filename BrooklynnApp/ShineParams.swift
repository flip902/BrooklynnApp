//
//  ShineParams.swift
//  BrooklynnApp
//
//  Created by William Savary on 2019-08-07.
//  Copyright © 2019 William Savary. All rights reserved.
//

import UIKit

public struct ShineParams {
    public var allowRandomColor: Bool = false
    public var animDuration: Double = 1
    public var bigShineColor: UIColor = UIColor(rgb: (255, 102, 102))
    public var enableFlashing: Bool = false
    public var shineCount: Int = 7
    public var shineTurnAngle: Float = 20
    public var shineDistanceMultiple: Float = 1.5
    public var smallShineOffsetAngle: Float = 20
    public var smallShineColor: UIColor = UIColor.lightGray
    public var shineSize: CGFloat = 0
    public var colorRandom: [UIColor] = [
        UIColor(rgb: (255, 255, 153)),
        UIColor(rgb: (255, 204, 204)),
        UIColor(rgb: (153, 102, 153)),
        UIColor(rgb: (255, 102, 102)),
        UIColor(rgb: (255, 255, 102)),
        UIColor(rgb: (244, 67, 54)),
        UIColor(rgb: (102, 102, 102)),
        UIColor(rgb: (204, 204, 0)),
        UIColor(rgb: (102, 102, 102)),
        UIColor(rgb: (153, 153, 51))
    ]
    
    public init() {}
}

public enum ShineImage {
    case heart
    case like
    case smile
    case star
    case custom(UIImage)
    case defaultAndSelect(UIImage, UIImage)
    
    func getImages() -> [UIImage] {
        switch self {
        case .heart:
            return [UIImage(named: "heart")!]
        case .like:
            return [UIImage(named: "like")!]
        case .smile:
            return [UIImage(named: "smile")!]
        case .star:
            return [UIImage(named: "star")!]
        case .custom(let image):
            return [image]
        case .defaultAndSelect(let defaultImage, let selectImage):
            return [defaultImage, selectImage]
        }
    }
    
    func isDefaultAndSelect() -> Bool {
        return self.getValue() == 5
    }
    
    func isCustom() -> Bool {
        return self.getValue() == 4
    }
    
    func getValue() -> Int {
        switch self {
            case .heart:
                return 0
            case .like:
                return 1
            case .smile:
                return 2
            case .star:
                return 3
            case .custom(_):
                return 4
            case .defaultAndSelect(_, _):
                return 5
        }
    }
}

var isIOS10: Bool {
    if #available(iOS 10.0, *) {
        return true
    }else {
        return false
    }
}
