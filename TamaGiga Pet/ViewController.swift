//
//  ViewController.swift
//  TamaGiga Pet
//
//  Created by Jason McCoy on 6/20/16.
//  Copyright © 2016 Jason McCoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImg: UIImageView!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var imgArray = [UIImage]()
        for x in 1...4 {
            let img = UIImage(named: "idle\(x).png")
            imgArray.append(img!)
        }
        monsterImg.animationImages = imgArray
        monsterImg.animationDuration = 1.0
        monsterImg.animationRepeatCount = 0
        monsterImg.startAnimating()
    }


}

