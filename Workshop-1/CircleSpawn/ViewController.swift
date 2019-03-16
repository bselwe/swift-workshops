//
//  ViewController.swift
//  CircleSpawn
//
//  Created by Bartosz Selwesiuk on 12/03/2019.
//  Copyright © 2019 Bartosz Selwesiuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    private var addGesture: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeGestures()
    }
    
    private func initializeGestures() {
        addGesture = UITapGestureRecognizer(target: self, action: #selector(handleAdd(_:)))
        addGesture!.numberOfTapsRequired = 2
        view.addGestureRecognizer(addGesture!)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return otherGestureRecognizer == addGesture
    }
    
    @objc func handleAdd(_ tap: UITapGestureRecognizer) {
        let spawnedView = CircleView(center: tap.location(in: view))
        view.addSubview(spawnedView)
        
        let removeGesture = UITapGestureRecognizer(target: self, action: #selector(handleRemove(_:)))
        removeGesture.numberOfTapsRequired = 3
        removeGesture.delegate = self
        
        let moveGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleMove(_:)))
        
        spawnedView.addGestureRecognizer(removeGesture)
        spawnedView.addGestureRecognizer(moveGesture)
        
        spawnedView.showWithAnimation()
    }
    
    @objc func handleRemove(_ tap: UITapGestureRecognizer) {
        let spawnedView = tap.view as! CircleView
        spawnedView.removeWithAnimation()
    }
    
    @objc func handleMove(_ tap: UILongPressGestureRecognizer) {
        let spawnedView = tap.view as! CircleView
        
        switch tap.state {
        case .began:
            spawnedView.animateZoomIn(tap)
        case .cancelled, .ended, .failed:
            spawnedView.animateZoomOut()
        case .changed:
            spawnedView.move(tap.location(in: spawnedView))
        default:
            break
        }
    }
}

