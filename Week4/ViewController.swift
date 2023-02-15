//
//  ViewController.swift
//  Week4
//
//  Created by Iksang Yoo on 2023/02/13.
//

import UIKit
import Gifu



enum actionType: String {
    case 반죽 = "반죽"
    case 문어 = "문어"
    case 뒤집기 = "뒤집기"
    case 빼기 = "빼기"
}

enum buttonStatus: String {
    case empty = "empty"
    case 반죽 = "반죽"
    case 문어 = "문어"
    case 뒤집기 = "뒤집기"
    case 완성 = "완성"
    case 실패 = "실패"
}

class ViewController: UIViewController {
    @IBOutlet weak var timeLimitLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var 반죽버튼: UIButton!
    @IBOutlet weak var 문어버튼: UIButton!
    @IBOutlet weak var 뒤집기버튼: UIButton!
    @IBOutlet weak var 빼기버튼: UIButton!
    @IBOutlet weak var gifImageView: GIFImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!

    var button1Time = 0
    var timer1 : Timer?
    var button1Status = buttonStatus.empty.rawValue
    
    var timeLimitTimer: Timer?
    var timeLimit = 10
    var currentActionType: String = ""
    var score = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gifImageView.animate(withGIFNamed: "문어움짤.gif")
        makeAllbuttonIsEnabled(bool: false)
    }

    @IBAction func startButtonPressed(_ sender: UIButton) {
        if startButton.currentTitle == "Reset" {
            startButton.setTitle("Start", for: .normal)
            timeLimitLabel.text = String(timeLimit)
            reset()
        } else {
            makeAllbuttonIsEnabled(bool: true)
            timeLimitTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeLimitContol), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timeLimitContol() {
        
        timeLimit -= 1
        timeLimitLabel.text = String(timeLimit)
        startButton.isEnabled = false
        
        if timeLimit == 0 {
            timeLimitTimer?.invalidate()
            timeLimitLabel.text = "Game Over"
            gameOver()
            timeLimit = 10
            startButton.isEnabled = true
            startButton.setTitle("Reset", for: .normal)
            
        }
    }
    
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            currentActionType = actionType.반죽.rawValue
            chageAcionButtonImage(sender: sender)
            print(currentActionType)
        } else if sender.tag == 1 {
            currentActionType = actionType.문어.rawValue
            chageAcionButtonImage(sender: sender)
            print(currentActionType)
        } else if sender.tag == 2 {
            currentActionType = actionType.뒤집기.rawValue
            chageAcionButtonImage(sender: sender)
            print(currentActionType)
        } else if sender.tag == 3 {
            currentActionType = actionType.빼기.rawValue
            chageAcionButtonImage(sender: sender)
            print(currentActionType)
        }
    }
    
    @IBAction func button1Pressed(_ sender: UIButton) {
        
        if button1Status == buttonStatus.empty.rawValue {
            if currentActionType == actionType.반죽.rawValue {
                button1Status = buttonStatus.반죽.rawValue
                button1.setImage(UIImage(named: button1Status), for: .normal)
            }
        } else if button1Status == buttonStatus.반죽.rawValue {
            if currentActionType == actionType.문어.rawValue {
                button1Status = buttonStatus.문어.rawValue
                button1.setImage(UIImage(named: button1Status), for: .normal)
            }
        } else if button1Status == buttonStatus.문어.rawValue {
            if currentActionType == actionType.뒤집기.rawValue {
                timer1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(button1Timer), userInfo: nil, repeats: true)
                button1Status = buttonStatus.뒤집기.rawValue
                button1.setImage(UIImage(named: button1Status), for: .normal)
            }
        } else if currentActionType == actionType.빼기.rawValue {
            if button1Status == buttonStatus.완성.rawValue {
                score += 1
                scoreLabel.text = String(score)
                button1Status = buttonStatus.empty.rawValue
                button1.setImage(UIImage(named: button1Status), for: .normal)
                timer1?.invalidate()
                button1Time = 0
            } else if button1Status == buttonStatus.실패.rawValue {
                score -= 1
                scoreLabel.text = String(score)
                button1Status = buttonStatus.empty.rawValue
                button1.setImage(UIImage(named: button1Status), for: .normal)
                timer1?.invalidate()
                button1Time = 0
            }
        }
        print(button1Status)
    }
    
    @objc func button1Timer() {
        button1Time += 1
        timeLabel.text = String(button1Time)
        
        if button1Time == 7 {
            button1Status = buttonStatus.완성.rawValue
            button1.setImage(UIImage(named: button1Status), for: .normal)
        }
        
        if button1Time == 14 {
            button1Status = buttonStatus.실패.rawValue
            button1.setImage(UIImage(named: button1Status), for: .normal)
        }
        
        print(button1Status)
    }
    
    func chageAcionButtonImage(sender: UIButton) {
        반죽버튼.setImage(UIImage(named: "notSelected0"), for: .normal)
        문어버튼.setImage(UIImage(named: "notSelected1"), for: .normal)
        뒤집기버튼.setImage(UIImage(named: "notSelected2"), for: .normal)
        빼기버튼.setImage(UIImage(named: "notSelected3"), for: .normal)
        
        sender.setImage(UIImage(named: "selected\(sender.tag)"), for: .normal)
    }
    
    func makeAllbuttonIsEnabled(bool: Bool) {
        if bool {
            button1.isEnabled = true
//            button2.isEnabled = true
//            button3.isEnabled = true
//            button4.isEnabled = true
//            button5.isEnabled = true
//            button6.isEnabled = true
//            button7.isEnabled = true
//            button8.isEnabled = true
//            button9.isEnabled = true
            반죽버튼.isEnabled = true
            문어버튼.isEnabled = true
            뒤집기버튼.isEnabled = true
            빼기버튼.isEnabled = true
        } else {
            button1.isEnabled = false
//            button2.isEnabled = false
//            button3.isEnabled = false
//            button4.isEnabled = false
//            button5.isEnabled = false
//            button6.isEnabled = false
//            button7.isEnabled = false
//            button8.isEnabled = false
//            button9.isEnabled = false
            
            반죽버튼.isEnabled = false
            문어버튼.isEnabled = false
            뒤집기버튼.isEnabled = false
            빼기버튼.isEnabled = false
        }
    }
    
    func gameOver() {
        makeAllbuttonIsEnabled(bool: false)
        timer1?.invalidate()
    }
    
    func reset() {
        반죽버튼.setImage(UIImage(named: "notSelected0"), for: .normal)
        문어버튼.setImage(UIImage(named: "notSelected1"), for: .normal)
        뒤집기버튼.setImage(UIImage(named: "notSelected2"), for: .normal)
        빼기버튼.setImage(UIImage(named: "notSelected3"), for: .normal)
        
        button1Time = 0
        
        button1Status = buttonStatus.empty.rawValue
        
        button1.setImage(UIImage(named: button1Status), for: .normal)
    }
}
