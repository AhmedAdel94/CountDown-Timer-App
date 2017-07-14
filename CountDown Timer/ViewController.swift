//
//  ViewController.swift
//  CountDown Timer
//
//  Created by Ahmed Adel on 7/11/17.
//  Copyright © 2017 Ahmed Adel. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var seconds = 30
    var timer = Timer()
    
    var audioPlayer = AVAudioPlayer()
    
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var timeSlider: UISlider!
    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var stopButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            let audioPath = Bundle.main.path(forResource: "1", ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        }catch{
            // Error
        }
    }

   
    @IBAction func sliderChanged(_ sender: UISlider) {
        seconds = Int(sender.value)
        timeLabel.text = String(seconds) + " Seconds"
    }
    
    
    @IBAction func startButton(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.counter), userInfo: nil, repeats: true)
        
        timeSlider.isEnabled = false
        startButton.isEnabled = false
        stopButton.isEnabled = true
        
    }
    
    
    func counter(){
        seconds -= 1
        timeLabel.text = String(seconds) + " Seconds"
        
        if seconds == 0{
            timer.invalidate()
            startButton.isEnabled = true
            audioPlayer.play()
            timeSlider.value = 0
        }
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        
        timer.invalidate()
        seconds = 30
        timeSlider.setValue(30, animated: true)
        
        timeLabel.text = "30 Seconds"
        
        timeSlider.isEnabled = true
        startButton.isEnabled = true
        stopButton.isEnabled = false
        
        audioPlayer.stop()
    }

}

