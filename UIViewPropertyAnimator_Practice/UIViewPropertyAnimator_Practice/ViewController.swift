//
//  ViewController.swift
//  UIViewPropertyAnimator_Practice
//
//  Created by 이현호 on 2023/08/16.
//
//참고 : https://ios-development.tistory.com/922
import UIKit

class ViewController: UIViewController {
    
    //1. 프로퍼티 선언
    var animator: UIViewPropertyAnimator?

    @IBOutlet var myView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2. 프로퍼티 초기화
        self.animator = UIViewPropertyAnimator(duration: 5.0, curve: .easeOut, animations: {self.myView.transform = .init(scaleX: 2.0, y: 1.3)})
        
        //3. completion
        self.animator?.addCompletion({ position in
            switch position{
            case.start:
                print("start")
            case .end:
                print("end")
            case .current:
                print("current")
            @unknown default:
                fatalError()
            }
        })
    }
    @IBAction func didTapStartButton(_ sender: Any) {
        self.animator?.startAnimation()
    }
    @IBAction func didTapPauseButton(_ sender: Any) {
        self.animator?.pauseAnimation()
    }
    @IBAction func didTapStopButton(_ sender: Any) {
        self.animator?.stopAnimation(true)
    }
    @IBAction func didTapAddButton(_ sender: Any) {
        self.animator?.addAnimations {
            self.myView.transform = .init(scaleX: 0.5, y: 0.5)
        }
    }
}

