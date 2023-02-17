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

enum buttonstate: String {
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
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!

    var button1Time = 0
    var timer1 : Timer?
    var button1state = buttonstate.empty.rawValue
    
    var button2Time = 0
    var timer2 : Timer?
    var button2state = buttonstate.empty.rawValue
    
    var button3Time = 0
    var timer3 : Timer?
    var button3state = buttonstate.empty.rawValue
    
    var button4Time = 0
    var timer4 : Timer?
    var button4state = buttonstate.empty.rawValue
    
    var button5Time = 0
    var timer5 : Timer?
    var button5state = buttonstate.empty.rawValue
    
    var button6Time = 0
    var timer6 : Timer?
    var button6state = buttonstate.empty.rawValue
    
    var button7Time = 0
    var timer7 : Timer?
    var button7state = buttonstate.empty.rawValue
    
    var button8Time = 0
    var timer8 : Timer?
    var button8state = buttonstate.empty.rawValue
    
    var button9Time = 0
    var timer9 : Timer?
    var button9state = buttonstate.empty.rawValue
    
    var timeLimitTimer: Timer?
    var timeLimit = 60
    var currentActionType: String = ""
    var score = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gifImageView.animate(withGIFNamed: "문어움짤.gif")
        startButton.layer.cornerRadius = 13
        startButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        startButton.layer.borderWidth = 3
        makeAllbuttonIsEnabled(bool: false)
    }

    @IBAction func startButtonPressed(_ sender: UIButton) {
        if startButton.currentTitle == "Reset" {
            startButton.setTitle("Start", for: .normal)
            timeLimitLabel.text = String(timeLimit)
            reset()
        } else {
            startButton.alpha = 0.5
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
            gameOver()
            timeLimit = 60
            startButton.isEnabled = true
            startButton.setTitle("Reset", for: .normal)
            startButton.alpha = 1
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
        
        if button1state == buttonstate.empty.rawValue {
            if currentActionType == actionType.반죽.rawValue {
                button1state = buttonstate.반죽.rawValue
                button1.setImage(UIImage(named: button1state), for: .normal)
            }
        } else if button1state == buttonstate.반죽.rawValue {
            if currentActionType == actionType.문어.rawValue {
                button1state = buttonstate.문어.rawValue
                button1.setImage(UIImage(named: button1state), for: .normal)
            }
        } else if button1state == buttonstate.문어.rawValue {
            if currentActionType == actionType.뒤집기.rawValue {
                timer1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(button1Timer), userInfo: nil, repeats: true)
                button1state = buttonstate.뒤집기.rawValue
                button1.setImage(UIImage(named: button1state), for: .normal)
            }
        } else if currentActionType == actionType.빼기.rawValue {
            if button1state == buttonstate.완성.rawValue {
                score += 1
                scoreLabel.text = String(score)
                button1state = buttonstate.empty.rawValue
                button1.setImage(UIImage(named: button1state), for: .normal)
                timer1?.invalidate()
                button1Time = 0
            } else if button1state == buttonstate.실패.rawValue {
                score -= 1
                scoreLabel.text = String(score)
                button1state = buttonstate.empty.rawValue
                button1.setImage(UIImage(named: button1state), for: .normal)
                timer1?.invalidate()
                button1Time = 0
            }
        }
    }
    
    @IBAction func button2Pressed(_ sender: UIButton) {
        if button2state == buttonstate.empty.rawValue {
            if currentActionType == actionType.반죽.rawValue {
                button2state = buttonstate.반죽.rawValue
                button2.setImage(UIImage(named: button2state), for: .normal)
            }
        } else if button2state == buttonstate.반죽.rawValue {
            if currentActionType == actionType.문어.rawValue {
                button2state = buttonstate.문어.rawValue
                button2.setImage(UIImage(named: button2state), for: .normal)
            }
        } else if button2state == buttonstate.문어.rawValue {
            if currentActionType == actionType.뒤집기.rawValue {
                timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(button2Timer), userInfo: nil, repeats: true)
                button2state = buttonstate.뒤집기.rawValue
                button2.setImage(UIImage(named: button2state), for: .normal)
            }
        } else if currentActionType == actionType.빼기.rawValue {
            if button2state == buttonstate.완성.rawValue {
                score += 1
                scoreLabel.text = String(score)
                button2state = buttonstate.empty.rawValue
                button2.setImage(UIImage(named: button2state), for: .normal)
                timer2?.invalidate()
                button2Time = 0
            } else if button2state == buttonstate.실패.rawValue {
                score -= 1
                scoreLabel.text = String(score)
                button2state = buttonstate.empty.rawValue
                button2.setImage(UIImage(named: button2state), for: .normal)
                timer2?.invalidate()
                button2Time = 0
            }
        }
    }
    
    @IBAction func button3Pressed(_ sender: UIButton) {
        if button3state == buttonstate.empty.rawValue {
            if currentActionType == actionType.반죽.rawValue {
                button3state = buttonstate.반죽.rawValue
                button3.setImage(UIImage(named: button3state), for: .normal)
            }
        } else if button3state == buttonstate.반죽.rawValue {
            if currentActionType == actionType.문어.rawValue {
                button3state = buttonstate.문어.rawValue
                button3.setImage(UIImage(named: button3state), for: .normal)
            }
        } else if button3state == buttonstate.문어.rawValue {
            if currentActionType == actionType.뒤집기.rawValue {
                timer3 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(button3Timer), userInfo: nil, repeats: true)
                button3state = buttonstate.뒤집기.rawValue
                button3.setImage(UIImage(named: button3state), for: .normal)
            }
        } else if currentActionType == actionType.빼기.rawValue {
            if button3state == buttonstate.완성.rawValue {
                score += 1
                scoreLabel.text = String(score)
                button3state = buttonstate.empty.rawValue
                button3.setImage(UIImage(named: button3state), for: .normal)
                timer3?.invalidate()
                button3Time = 0
            } else if button3state == buttonstate.실패.rawValue {
                score -= 1
                scoreLabel.text = String(score)
                button3state = buttonstate.empty.rawValue
                button3.setImage(UIImage(named: button3state), for: .normal)
                timer3?.invalidate()
                button3Time = 0
            }
        }
    }
    
    @IBAction func button4Pressed(_ sender: UIButton) {
        if button4state == buttonstate.empty.rawValue {
            if currentActionType == actionType.반죽.rawValue {
                button4state = buttonstate.반죽.rawValue
                button4.setImage(UIImage(named: button4state), for: .normal)
            }
        } else if button4state == buttonstate.반죽.rawValue {
            if currentActionType == actionType.문어.rawValue {
                button4state = buttonstate.문어.rawValue
                button4.setImage(UIImage(named: button4state), for: .normal)
            }
        } else if button4state == buttonstate.문어.rawValue {
            if currentActionType == actionType.뒤집기.rawValue {
                timer4 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(button4Timer), userInfo: nil, repeats: true)
                button4state = buttonstate.뒤집기.rawValue
                button4.setImage(UIImage(named: button4state), for: .normal)
            }
        } else if currentActionType == actionType.빼기.rawValue {
            if button4state == buttonstate.완성.rawValue {
                score += 1
                scoreLabel.text = String(score)
                button4state = buttonstate.empty.rawValue
                button4.setImage(UIImage(named: button4state), for: .normal)
                timer4?.invalidate()
                button4Time = 0
            } else if button4state == buttonstate.실패.rawValue {
                score -= 1
                scoreLabel.text = String(score)
                button4state = buttonstate.empty.rawValue
                button4.setImage(UIImage(named: button4state), for: .normal)
                timer4?.invalidate()
                button4Time = 0
            }
        }
    }
    @IBAction func button5Pressed(_ sender: UIButton) {
        if button5state == buttonstate.empty.rawValue {
            if currentActionType == actionType.반죽.rawValue {
                button5state = buttonstate.반죽.rawValue
                button5.setImage(UIImage(named: button5state), for: .normal)
            }
        } else if button5state == buttonstate.반죽.rawValue {
            if currentActionType == actionType.문어.rawValue {
                button5state = buttonstate.문어.rawValue
                button5.setImage(UIImage(named: button5state), for: .normal)
            }
        } else if button5state == buttonstate.문어.rawValue {
            if currentActionType == actionType.뒤집기.rawValue {
                timer5 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(button5Timer), userInfo: nil, repeats: true)
                button5state = buttonstate.뒤집기.rawValue
                button5.setImage(UIImage(named: button5state), for: .normal)
            }
        } else if currentActionType == actionType.빼기.rawValue {
            if button5state == buttonstate.완성.rawValue {
                score += 1
                scoreLabel.text = String(score)
                button5state = buttonstate.empty.rawValue
                button5.setImage(UIImage(named: button5state), for: .normal)
                timer5?.invalidate()
                button5Time = 0
            } else if button5state == buttonstate.실패.rawValue {
                score -= 1
                scoreLabel.text = String(score)
                button5state = buttonstate.empty.rawValue
                button5.setImage(UIImage(named: button5state), for: .normal)
                timer5?.invalidate()
                button5Time = 0
            }
        }
    }
    @IBAction func button6Pressed(_ sender: UIButton) {
        if button6state == buttonstate.empty.rawValue {
            if currentActionType == actionType.반죽.rawValue {
                button6state = buttonstate.반죽.rawValue
                button6.setImage(UIImage(named: button6state), for: .normal)
            }
        } else if button6state == buttonstate.반죽.rawValue {
            if currentActionType == actionType.문어.rawValue {
                button6state = buttonstate.문어.rawValue
                button6.setImage(UIImage(named: button6state), for: .normal)
            }
        } else if button6state == buttonstate.문어.rawValue {
            if currentActionType == actionType.뒤집기.rawValue {
                timer6 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(button6Timer), userInfo: nil, repeats: true)
                button6state = buttonstate.뒤집기.rawValue
                button6.setImage(UIImage(named: button6state), for: .normal)
            }
        } else if currentActionType == actionType.빼기.rawValue {
            if button6state == buttonstate.완성.rawValue {
                score += 1
                scoreLabel.text = String(score)
                button6state = buttonstate.empty.rawValue
                button6.setImage(UIImage(named: button6state), for: .normal)
                timer6?.invalidate()
                button6Time = 0
            } else if button6state == buttonstate.실패.rawValue {
                score -= 1
                scoreLabel.text = String(score)
                button6state = buttonstate.empty.rawValue
                button6.setImage(UIImage(named: button6state), for: .normal)
                timer6?.invalidate()
                button6Time = 0
            }
        }
    }
    @IBAction func button7Pressed(_ sender: UIButton) {
        if button7state == buttonstate.empty.rawValue {
            if currentActionType == actionType.반죽.rawValue {
                button7state = buttonstate.반죽.rawValue
                button7.setImage(UIImage(named: button7state), for: .normal)
            }
        } else if button7state == buttonstate.반죽.rawValue {
            if currentActionType == actionType.문어.rawValue {
                button7state = buttonstate.문어.rawValue
                button7.setImage(UIImage(named: button7state), for: .normal)
            }
        } else if button7state == buttonstate.문어.rawValue {
            if currentActionType == actionType.뒤집기.rawValue {
                timer7 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(button7Timer), userInfo: nil, repeats: true)
                button7state = buttonstate.뒤집기.rawValue
                button7.setImage(UIImage(named: button7state), for: .normal)
            }
        } else if currentActionType == actionType.빼기.rawValue {
            if button7state == buttonstate.완성.rawValue {
                score += 1
                scoreLabel.text = String(score)
                button7state = buttonstate.empty.rawValue
                button7.setImage(UIImage(named: button7state), for: .normal)
                timer7?.invalidate()
                button7Time = 0
            } else if button7state == buttonstate.실패.rawValue {
                score -= 1
                scoreLabel.text = String(score)
                button7state = buttonstate.empty.rawValue
                button7.setImage(UIImage(named: button7state), for: .normal)
                timer7?.invalidate()
                button7Time = 0
            }
        }
    }
    @IBAction func button8Pressed(_ sender: UIButton) {
        if button8state == buttonstate.empty.rawValue {
            if currentActionType == actionType.반죽.rawValue {
                button8state = buttonstate.반죽.rawValue
                button8.setImage(UIImage(named: button8state), for: .normal)
            }
        } else if button8state == buttonstate.반죽.rawValue {
            if currentActionType == actionType.문어.rawValue {
                button8state = buttonstate.문어.rawValue
                button8.setImage(UIImage(named: button8state), for: .normal)
            }
        } else if button8state == buttonstate.문어.rawValue {
            if currentActionType == actionType.뒤집기.rawValue {
                timer8 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(button8Timer), userInfo: nil, repeats: true)
                button8state = buttonstate.뒤집기.rawValue
                button8.setImage(UIImage(named: button8state), for: .normal)
            }
        } else if currentActionType == actionType.빼기.rawValue {
            if button8state == buttonstate.완성.rawValue {
                score += 1
                scoreLabel.text = String(score)
                button8state = buttonstate.empty.rawValue
                button8.setImage(UIImage(named: button8state), for: .normal)
                timer8?.invalidate()
                button8Time = 0
            } else if button8state == buttonstate.실패.rawValue {
                score -= 1
                scoreLabel.text = String(score)
                button8state = buttonstate.empty.rawValue
                button8.setImage(UIImage(named: button8state), for: .normal)
                timer8?.invalidate()
                button8Time = 0
            }
        }
    }
    @IBAction func button9Pressed(_ sender: UIButton) {
        if button9state == buttonstate.empty.rawValue {
            if currentActionType == actionType.반죽.rawValue {
                button9state = buttonstate.반죽.rawValue
                button9.setImage(UIImage(named: button9state), for: .normal)
            }
        } else if button9state == buttonstate.반죽.rawValue {
            if currentActionType == actionType.문어.rawValue {
                button9state = buttonstate.문어.rawValue
                button9.setImage(UIImage(named: button9state), for: .normal)
            }
        } else if button9state == buttonstate.문어.rawValue {
            if currentActionType == actionType.뒤집기.rawValue {
                timer9 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(button9Timer), userInfo: nil, repeats: true)
                button9state = buttonstate.뒤집기.rawValue
                button9.setImage(UIImage(named: button9state), for: .normal)
            }
        } else if currentActionType == actionType.빼기.rawValue {
            if button9state == buttonstate.완성.rawValue {
                score += 1
                scoreLabel.text = String(score)
                button9state = buttonstate.empty.rawValue
                button9.setImage(UIImage(named: button9state), for: .normal)
                timer9?.invalidate()
                button9Time = 0
            } else if button9state == buttonstate.실패.rawValue {
                score -= 1
                scoreLabel.text = String(score)
                button9state = buttonstate.empty.rawValue
                button9.setImage(UIImage(named: button9state), for: .normal)
                timer9?.invalidate()
                button9Time = 0
            }
        }
    }
    
    
    
    
    @objc func button1Timer() {
        button1Time += 1
        
        if button1Time == 7 {
            button1state = buttonstate.완성.rawValue
            button1.setImage(UIImage(named: button1state), for: .normal)
        }
        
        if button1Time == 14 {
            button1state = buttonstate.실패.rawValue
            button1.setImage(UIImage(named: button1state), for: .normal)
        }
    }
    
    @objc func button2Timer() {
        button2Time += 1
        
        if button2Time == 7 {
            button2state = buttonstate.완성.rawValue
            button2.setImage(UIImage(named: button2state), for: .normal)
        }
        
        if button2Time == 14 {
            button2state = buttonstate.실패.rawValue
            button2.setImage(UIImage(named: button2state), for: .normal)
        }
    }
    
    @objc func button3Timer() {
        button3Time += 1
        
        if button3Time == 7 {
            button3state = buttonstate.완성.rawValue
            button3.setImage(UIImage(named: button3state), for: .normal)
        }
        
        if button3Time == 14 {
            button3state = buttonstate.실패.rawValue
            button3.setImage(UIImage(named: button3state), for: .normal)
        }
    }
    
    @objc func button4Timer() {
        button4Time += 1
        
        if button4Time == 7 {
            button4state = buttonstate.완성.rawValue
            button4.setImage(UIImage(named: button4state), for: .normal)
        }
        
        if button4Time == 14 {
            button4state = buttonstate.실패.rawValue
            button4.setImage(UIImage(named: button4state), for: .normal)
        }
    }
    
    @objc func button5Timer() {
        button5Time += 1
        
        if button5Time == 7 {
            button5state = buttonstate.완성.rawValue
            button5.setImage(UIImage(named: button5state), for: .normal)
        }
        
        if button5Time == 14 {
            button5state = buttonstate.실패.rawValue
            button5.setImage(UIImage(named: button5state), for: .normal)
        }
    }
    
    @objc func button6Timer() {
        button6Time += 1
        
        if button6Time == 7 {
            button6state = buttonstate.완성.rawValue
            button6.setImage(UIImage(named: button6state), for: .normal)
        }
        
        if button6Time == 14 {
            button6state = buttonstate.실패.rawValue
            button6.setImage(UIImage(named: button6state), for: .normal)
        }
    }
    
    @objc func button7Timer() {
        button7Time += 1
        
        if button7Time == 7 {
            button7state = buttonstate.완성.rawValue
            button7.setImage(UIImage(named: button7state), for: .normal)
        }
        
        if button7Time == 14 {
            button7state = buttonstate.실패.rawValue
            button7.setImage(UIImage(named: button7state), for: .normal)
        }
    }
    
    @objc func button8Timer() {
        button8Time += 1
        
        if button8Time == 7 {
            button8state = buttonstate.완성.rawValue
            button8.setImage(UIImage(named: button8state), for: .normal)
        }
        
        if button8Time == 14 {
            button8state = buttonstate.실패.rawValue
            button8.setImage(UIImage(named: button8state), for: .normal)
        }
    }
    
    @objc func button9Timer() {
        button9Time += 1
        
        if button9Time == 7 {
            button9state = buttonstate.완성.rawValue
            button9.setImage(UIImage(named: button9state), for: .normal)
        }
        
        if button9Time == 14 {
            button9state = buttonstate.실패.rawValue
            button9.setImage(UIImage(named: button9state), for: .normal)
        }
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
            button2.isEnabled = true
            button3.isEnabled = true
            button4.isEnabled = true
            button5.isEnabled = true
            button6.isEnabled = true
            button7.isEnabled = true
            button8.isEnabled = true
            button9.isEnabled = true
            
            반죽버튼.isEnabled = true
            문어버튼.isEnabled = true
            뒤집기버튼.isEnabled = true
            빼기버튼.isEnabled = true
        } else {
            button1.isEnabled = false
            button2.isEnabled = false
            button3.isEnabled = false
            button4.isEnabled = false
            button5.isEnabled = false
            button6.isEnabled = false
            button7.isEnabled = false
            button8.isEnabled = false
            button9.isEnabled = false
            
            반죽버튼.isEnabled = false
            문어버튼.isEnabled = false
            뒤집기버튼.isEnabled = false
            빼기버튼.isEnabled = false
        }
    }
    
    func gameOver() {
        makeAllbuttonIsEnabled(bool: false)
        timer1?.invalidate()
        timer2?.invalidate()
        timer3?.invalidate()
        timer4?.invalidate()
        timer5?.invalidate()
        timer6?.invalidate()
        timer7?.invalidate()
        timer8?.invalidate()
        timer9?.invalidate()
    }
    
    func reset() {
        score = 0
        scoreLabel.text = String(score)
        
        currentActionType = ""
        
        반죽버튼.setImage(UIImage(named: "notSelected0"), for: .normal)
        문어버튼.setImage(UIImage(named: "notSelected1"), for: .normal)
        뒤집기버튼.setImage(UIImage(named: "notSelected2"), for: .normal)
        빼기버튼.setImage(UIImage(named: "notSelected3"), for: .normal)
        
        button1Time = 0
        button2Time = 0
        button3Time = 0
        button4Time = 0
        button5Time = 0
        button6Time = 0
        button7Time = 0
        button8Time = 0
        button9Time = 0
        
        button1state = buttonstate.empty.rawValue
        button2state = buttonstate.empty.rawValue
        button3state = buttonstate.empty.rawValue
        button4state = buttonstate.empty.rawValue
        button5state = buttonstate.empty.rawValue
        button6state = buttonstate.empty.rawValue
        button7state = buttonstate.empty.rawValue
        button8state = buttonstate.empty.rawValue
        button9state = buttonstate.empty.rawValue
        
        button1.setImage(UIImage(named: button1state), for: .normal)
        button2.setImage(UIImage(named: button2state), for: .normal)
        button3.setImage(UIImage(named: button3state), for: .normal)
        button4.setImage(UIImage(named: button4state), for: .normal)
        button5.setImage(UIImage(named: button5state), for: .normal)
        button6.setImage(UIImage(named: button6state), for: .normal)
        button7.setImage(UIImage(named: button7state), for: .normal)
        button8.setImage(UIImage(named: button8state), for: .normal)
        button9.setImage(UIImage(named: button9state), for: .normal)
    }
}
