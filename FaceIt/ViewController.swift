//
//  ViewController.swift
//  FaceIt
//
//  Created by Murari Varma on 16/11/17.
//  Copyright © 2017 murarivarma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleEyes(byReactingTo:)))
            tapRecognizer.numberOfTapsRequired = 1
            faceView.addGestureRecognizer(tapRecognizer)
            
            let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(decreasingHappiness))
            swipeUpRecognizer.direction = .up
            faceView.addGestureRecognizer(swipeUpRecognizer)
            let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(increasingHappiness))
            faceView.addGestureRecognizer(swipeDownRecognizer)
            swipeDownRecognizer.direction = .down
            updateUI()
        }
    }
    
    @objc func increasingHappiness() {
        expression = expression.happier
    }

    @objc func decreasingHappiness() {
        expression = expression.sadder
    }
    
    @objc func toggleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open: .closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
    }
    
    
    var expression = FacialExpression(eyes: .closed, mouth: .frown) {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        
        switch expression.eyes {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squinting:
            faceView?.eyesOpen = false
        }
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    
    private let mouthCurvatures = [FacialExpression.Mouth.grin: 0.5,.frown: -1.0,.smile: 1.0,.neutral:0.0,.smirk: -0.5]
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


}

