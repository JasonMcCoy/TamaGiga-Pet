//
//  MonsterImg.swift
//  TamaGiga Pet
//
//  Created by Jason McCoy on 6/22/16.
//  Copyright © 2016 Jason McCoy. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg: UIImageView {
    
    override init(frame: CGRect) {
    super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
    }
    
    func playIdleAnimation() {
        
        self.image = UIImage(named: "idle1.png")
        
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        for x in 1...4 {
            let img = UIImage(named: "idle\(x).png")
            imgArray.append(img!)
            
        }
        
        animateImages(array: imgArray, loop: 0)
        
    }
    
    func playDeathAnimation() {
            
        self.image = UIImage(named: "dead5.png")
            
        self.animationImages = nil
            
        var imgArray = [UIImage]()
        for x in 1...5 {
            let img = UIImage(named: "dead\(x).png")
            imgArray.append(img!)
                
        }
        
        animateImages(array: imgArray, loop: 1)
        
    }
    
    func animateImages(array: [UIImage], loop: Int) {
        
        self.animationImages = array
        self.animationDuration = 1.2
        self.animationRepeatCount = loop
        self.startAnimating()
        
    }
    
}
