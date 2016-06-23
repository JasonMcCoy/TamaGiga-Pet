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
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        NotificationCenter.default().addObserver(self, selector: #selector(itemDroppedOnCharacter), name: "onTargetDropped", object: nil)
        
    }
    
    func itemDroppedOnCharacter(notify: AnyObject) {
        print("PRINT ITEM DROPPED ON THE CHARACTER")
    }

}

