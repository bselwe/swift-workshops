//
//  CircleView.swift
//  CircleSpawn
//
//  Created by Bartosz Selwesiuk on 16/03/2019.
//  Copyright © 2019 Bartosz Selwesiuk. All rights reserved.
//

import UIKit

class CircleView: UIView {
    private let circleSize: CGFloat = 100
    
    var beginCoordinate: CGPoint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    convenience init(center: CGPoint) {
        self.init()
        initialize(center: center)
    }
    
    func initialize(frame: CGRect? = nil, center: CGPoint? = nil) {
        if let frame = frame {
            self.frame = frame
        } else {
            self.frame = CGRect(origin: .zero, size: CGSize(width: circleSize, height: circleSize))
        }
        
        if let center = center {
            self.center = center
        }
        
        self.backgroundColor = .randomBrightColor()
        self.layer.cornerRadius = self.frame.width * 0.5
    }
    
    func showWithAnimation() {
        self.alpha = 0
        self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 1
            self.transform = .identity
        })
    }
    
    func removeWithAnimation() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: { completed in
            self.removeFromSuperview()
        })
    }
    
    func animateZoomIn(_ beginTap: UILongPressGestureRecognizer) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.alpha = 0.5
            self.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            self.beginCoordinate = beginTap.location(in: self)
        })
    }
    
    func animateZoomOut() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 1
            self.transform = .identity
        })
    }
    
    func move(_ tap: CGPoint) {
        guard let beginCoordinate = self.beginCoordinate else { return }
        let dx = tap.x - beginCoordinate.x
        let dy = tap.y - beginCoordinate.y
        self.center = CGPoint(x: self.center.x + dx, y: self.center.y + dy)
    }
}
