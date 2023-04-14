//
//  ViewController.swift
//  pomodoroTimer_fc
//
//  Created by 이현호 on 2023/04/12.
//

import UIKit
import AudioToolbox

enum TimerStatus{
    case start
    case pause
    case end
}

class ViewController: UIViewController {
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var toggleButton: UIButton!
    @IBOutlet var tomatoImage: UIImageView!
    @IBOutlet var progressView: UIProgressView!
    
    var duration = 60
    var timerStatus: TimerStatus = .end
    var timer: DispatchSourceTimer?
    var currentSecond = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureToggleButton()
    }
    
    @IBAction func tapCancelButton(_ sender: Any) {
        switch self.timerStatus{
        case .start, .pause:
            self.stopTimer()
        default:
            return
        }
        
    }
    
    @IBAction func tabToggleButton(_ sender: Any) {
        self.duration = Int(self.datePicker.countDownDuration)
        switch self.timerStatus{
        case .end:
            self.startTimer()//timer 시작
            self.currentSecond = self.duration
            self.timerStatus = .start
            UIView.animate(withDuration: 0.5, animations: {
                self.timerLabel.alpha = 1
                self.progressView.alpha = 1
                self.datePicker.alpha = 0
            })
            self.toggleButton.isSelected = true
            self.cancelButton.isEnabled = true
        case .start:
            self.timer?.suspend() //timer 일시정지
            self.timerStatus = .pause
            self.toggleButton.isSelected = false
            
        case .pause:
            self.timerStatus = .start
            self.toggleButton.isSelected = true
            self.timer?.resume() //timer 재시작
        default:
            break
        }
    }
    
    func setTimerInfoViewVisible(isHidden: Bool){
        self.timerLabel.isHidden = isHidden
        self.progressView.isHidden = isHidden
    }
    
    func configureToggleButton(){
        self.toggleButton.setTitle("시작", for: .normal)
        self.toggleButton.setTitle("일시정지", for: .selected)
    }
    
    func startTimer(){
        if self.timer == nil {
            
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            //1초에 한 번 씩 setEventHander의 closure가 동작한다
            self.timer?.schedule(deadline: .now(), repeating: 1)
            self.timer?.setEventHandler(handler: {[weak self] in
                guard let self = self else {return}
                self.currentSecond -= 1
                let hour = self.currentSecond / 3600
                let minute = (self.currentSecond % 3600) / 60
                let seconds = (self.currentSecond % 3600) % 60
                self.timerLabel.text = String(format: "%02d:%02d:%02d", hour, minute, seconds)
                self.progressView.progress = Float(self.currentSecond) / Float(self.duration)
                
                UIView.animate(withDuration: 0.5,delay: 0 ,animations: {
                    self.tomatoImage.transform = CGAffineTransform(rotationAngle: .pi  )
                })
                UIView.animate(withDuration: 0.5,delay: 0.5 ,animations: {
                    self.tomatoImage.transform = CGAffineTransform(rotationAngle: .pi*2  )
                })
                if self.currentSecond <= 0 {
                    self.stopTimer()
                    AudioServicesPlaySystemSound(1005)
                }
            })
        self.timer?.resume() //타이버머 시작
        }
    }
    
    func stopTimer(){
        if self.timerStatus == .pause{
            self.timer?.resume()
        }
        self.timer?.cancel()
        self.timer = nil //메모리해제 메모리해제 하지 않으면 타이머가 돌아갈 수 있다.
        
        self.timerStatus = .end
        self.cancelButton.isEnabled = false
        UIView.animate(withDuration: 0.5, animations: {
            self.progressView.alpha = 0
            self.timerLabel.alpha = 0
            self.datePicker.alpha = 1
            self.tomatoImage.transform = .identity
        })

        self.toggleButton.isSelected = false
    }

   
}

