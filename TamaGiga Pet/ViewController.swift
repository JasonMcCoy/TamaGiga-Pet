//
//  ViewController.swift
//  TamaGiga Pet
//
//  Created by Jason McCoy on 6/20/16.
//  Copyright © 2016 Jason McCoy. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    @IBOutlet weak var penaltyOneImg: UIImageView!
    @IBOutlet weak var penaltyTwoImg: UIImageView!
    @IBOutlet weak var penaltyThreeImg: UIImageView!
    
    
    let DIM_ALPHA: CGFloat = 0.5
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    var penalties = 0
    var timer: Timer!
    var monsterHappy = false
    var currentItem: UInt32 = 0

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        penaltyOneImg.alpha = DIM_ALPHA
        penaltyTwoImg.alpha = DIM_ALPHA
        penaltyThreeImg.alpha = DIM_ALPHA
        
        NotificationCenter.default().addObserver(self, selector: #selector(itemDroppedOnCharacter), name: "onTargetDropped", object: nil)
        
        do {
            let resourcePath = Bundle.main().pathForResource("cave-music", ofType: "mp3")
            let url = NSURL (fileURLWithPath: resourcePath!)
            try musicPlayer = AVAudioPlayer(contentsOf: url as URL)
            
            try sfxBite = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main().pathForResource("bite", ofType: "wav")!) as URL)
            try sfxHeart = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main().pathForResource("heart", ofType: "wav")!) as URL)
            try sfxDeath = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main().pathForResource("death", ofType: "wav")!) as URL)
            try sfxSkull = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main().pathForResource("skull", ofType: "wav")!) as URL)
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxSkull.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        startTimer()
        
    }
    
    func itemDroppedOnCharacter(notify: AnyObject) {
        
        monsterHappy = true
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.isUserInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.isUserInteractionEnabled = false
        
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
            timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        
        if !monsterHappy {
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
        
        let rand = arc4random_uniform(2)
        
        if rand == 0 {
            foodImg.alpha = DIM_ALPHA
            foodImg.isUserInteractionEnabled = false
            
            heartImg.alpha = OPAQUE
            heartImg.isUserInteractionEnabled = true
        } else {
            foodImg.alpha = OPAQUE
            foodImg.isUserInteractionEnabled = true
            
            heartImg.alpha = DIM_ALPHA
            heartImg.isUserInteractionEnabled = false
        }
        
        currentItem = rand
        monsterHappy = false

    }
    
    func gameOver() {
        timer.invalidate()
        monsterImg.playDeathAnimation()
    }

}

