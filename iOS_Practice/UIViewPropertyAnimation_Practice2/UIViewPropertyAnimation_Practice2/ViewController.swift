//
//  ViewController.swift
//  UIViewPropertyAnimation_Practice2
//
//  Created by 이현호 on 2023/08/16.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var slider: UISlider!
    @IBOutlet var redView: UIView!
    @IBOutlet var greenView: UIView!
    @IBOutlet var blueView: UIView!
    
    var animator: UIViewPropertyAnimator?
    
    
    override func viewDidLoad() {
        self.setAnimator()
    }
    
    private func setAnimator(){
        self.animator = UIViewPropertyAnimator(duration: 5, timingParameters: UICubicTimingParameters(animationCurve: .easeInOut))
        self.animator?.addAnimations {
            UIView.animateKeyframes(withDuration: 0, delay: 0.3/1, animations: {self.redView.alpha = 0})
            UIView.animateKeyframes(withDuration: 0, delay: 0.6/1, animations: {self.greenView.alpha = 0})
            UIView.animateKeyframes(withDuration: 0, delay: 0.9/1, animations: {self.blueView.alpha = 0})
        }
        self.animator?.addCompletion({ [weak self] _ in
            [self?.redView, self?.greenView, self?.blueView].forEach{$0?.alpha = 1}
            self?.animator = nil
            self?.setAnimator()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animator?.startAnimation()
    }

    @IBAction func sliderAction(_ sender: UISlider) {
        self.animator?.fractionComplete = CGFloat(sender.value)
    }
    
}

