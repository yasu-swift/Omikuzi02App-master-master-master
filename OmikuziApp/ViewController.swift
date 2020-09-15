//
//  ViewController.swift
//  OmikuziApp
//
//  Created by 高橋康之 on 2020/09/15.
//  Copyright © 2020 yasu.com. All rights reserved.
//

import UIKit
import AVFoundation //この1行を追記



class ViewController: UIViewController {
    
    
    // 下の1行を追加。結果を表示したときに音を出すための再生オブジェクトを格納します。
    var resultAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    

    @IBOutlet var stickView: UIView!
    @IBOutlet var stickLabel: UILabel!
    @IBOutlet var stickHeight: NSLayoutConstraint!
    @IBOutlet var stickBottomMargin: NSLayoutConstraint!
    @IBOutlet var overView: UIView!
    @IBOutlet var bigLabel: UILabel!
    
    @IBAction func tapRetryButton(_ sender: Any) {
        overView.isHidden = true
        stickBottomMargin.constant = 0
        
    }
    //この下から追記！→ 結果表示するときに鳴らす音の準備
    func setupSound() {
        if let sound = Bundle.main.path(forResource: "drum", ofType: ".mp3") {
            resultAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            resultAudioPlayer.prepareToPlay()
        }
    }
    //ここまで追記！
    
    let resultTexts: [String] = [
        "大吉",
        "中吉",
        "小吉",
        "吉",
        "末吉",
        "凶",
        "大凶"
    ]
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {

        if motion != UIEvent.EventSubtype.motionShake || overView.isHidden == false {
                   // シェイクモーション以外では動作させない
                   // 結果の表示中は動作させない
            // シェイクモーション以外では動作させない
            return
        }
        let resultNum = Int( arc4random_uniform(UInt32(resultTexts.count)) )
        stickLabel.text = resultTexts[resultNum]
        stickBottomMargin.constant = stickHeight.constant * -1

        UIView.animate(withDuration: 1, animations: {

            self.view.layoutIfNeeded()

            }, completion: { (finished: Bool) in
                // 後ほど記述します。
                UIView.animate(withDuration: 1.0, animations: {

                    self.view.layoutIfNeeded()

                    }, completion: { (finished: Bool) in
                        self.bigLabel.text = self.stickLabel.text
                        self.overView.isHidden = false
                })
                //次の1行を追加 -> 結果表示のときに音を再生(Play)する！
                self.resultAudioPlayer.play()
        })
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSound() //この1行を追加
        // Do any additional setup after loading the view.
    }
    
    
    
}

