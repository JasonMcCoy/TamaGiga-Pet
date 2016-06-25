//
//  ViewController.swift
//  TamaGiga Pet
//
//  Created by Jason McCoy on 6/20/16.
//  Copyright © 2016 Jason McCoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    @IBOutlet weak var penaltyOneImg: UIImageView!
    @IBOutlet weak var penaltyTwoImg: UIImageView!
    @IBOutlet weak var penaltyThreeImg: UIImageView!
    
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: Timer!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        penaltyOneImg.alpha = DIM_ALPHA
        penaltyTwoImg.alpha = DIM_ALPHA
        penaltyThreeImg.alpha = DIM_ALPHA
        
        NotificationCenter.default().addObserver(self, selector: #selector(itemDroppedOnCharacter), name: "onTargetDropped", object: nil)
        
        startTimer()
        
    }
    
    func itemDroppedOnCharacter(notify: AnyObject) {
        
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
            timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        
        penalties += 1
            
        if penalties == 1 {
            penaltyOneImg.alpha = OPAQUE
            penaltyTwoImg.alpha = DIM_ALPHA
        } else if penalties == 2 {
            penaltyTwoImg.alpha = OPAQUE
            penaltyThreeImg.alpha = DIM_ALPHA
        } else if penalties >= 3 {
            penaltyThreeImg.alpha = OPAQUE
        } else {
            penaltyOneImg.alpha = DIM_ALPHA
            penaltyTwoImg.alpha = DIM_ALPHA
            penaltyThreeImg.alpha = DIM_ALPHA
        }
        if penalties >= MAX_PENALTIES {
            gameOver()
        }
    }
    
    func gameOver() {
        timer.invalidate()
        monsterImg.playDeathAnimation()
    }

}

