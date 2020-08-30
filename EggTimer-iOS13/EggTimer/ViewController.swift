//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var bar: UIProgressView!
    var secondsPassed = 0
    var totalTime = 0
    var timer = Timer()
    var sonido: AVAudioPlayer?
    
    let eggTimes = ["Soft" : 3,
        "Medium" : 2, "Hard" : 5]
    
    @IBAction func hardnessSelected (_sender:UIButton){
        timer.invalidate()
        let hardness = _sender.currentTitle!
        let result = eggTimes[hardness]!
        totalTime = result
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(strtTimer), userInfo: nil, repeats: true)
     // Actualizar para cuando se oprima de nuevo un botón
        secondsPassed = 0
        bar.progress = 0.0
        titulo.text = hardness
    }
    
    //Timer
    
    @objc func strtTimer() {
        
            if secondsPassed < totalTime {
                // progress bar
                secondsPassed += 1
                let division = Float(secondsPassed)/Float(totalTime)
                print(division)
                bar.progress = division
                
            } else {
                timer.invalidate()
                titulo.text = "Done!"
                bar.progress = 1.0
                
                // Load sound
                let path = Bundle.main.path(forResource: "alarm_sound.mp3", ofType:nil)!
                let url = URL(fileURLWithPath: path)

                do {
                    sonido = try AVAudioPlayer(contentsOf: url)
                    sonido?.play()
                } catch {
                    // couldn't load file :(
                }
                
            }
        }
    }



