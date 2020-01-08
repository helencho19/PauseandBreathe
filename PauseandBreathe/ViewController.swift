//
//  ViewController.swift
//  Pause and Breathe
//
//  Created by Helen Cho on 12/1/19.
//  Copyright © 2019 CS50. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    @IBOutlet var inhaleSlider: UISlider!
    @IBOutlet var exhaleSlider: UISlider!
    @IBOutlet var inhaleLabel: UILabel!
    @IBOutlet var exhaleLabel: UILabel!
    @IBOutlet var instructions: UILabel!
    @IBOutlet var timerCount: UILabel!
    @IBOutlet var wavesButton: UIButton!
    @IBOutlet var raindropsButton: UIButton!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var hideTimerButton: UIButton!
    
    // Inhale/Exhale length
    var inhaleDuration = 4.0
    var exhaleDuration = 6.0
    
    // Playing sounds
    var wavesPlayer = AVAudioPlayer()
    var rainPlayer = AVAudioPlayer()

    // Number of seconds app has been running
    var count = 0
    
    // Declare global timer variable
    var timer = Timer()
    
    // Timer boolean variable
    var started = false
    
    // Timer shown variable
    var show = true
    
    // Screen size variables
    // https://stackoverflow.com/questions/24110762/swift-determine-ios-screen-size
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    
    // Expand circle
    func scaleUp(shape: UIView, duration: Double)
    {
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       animations: {
                        shape.transform = CGAffineTransform(scaleX: 4.0, y: 4.0)
        }, completion: { finished in
            if finished {
                self.scaleDown(shape: shape, duration: self.exhaleDuration)
            }
        })

        self.instructions.text = "Breathe in"
    }

    // Contract circle
    func scaleDown(shape: UIView, duration: Double)
    {
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       animations: {
                        shape.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
        }, completion: { finished in
            if finished {
                self.scaleUp(shape: shape, duration: self.inhaleDuration)
            }
        })
        
        self.instructions.text = "Breathe out"
    }
    
    // Formats timer output on UI
    // http://www.popcornomnom.com/countdown-timer-in-swift-5-for-ios/
    func timeString(from timeInterval: Int) -> String {
        let seconds = Int(Double(timeInterval).truncatingRemainder(dividingBy: 60))
        let minutes = Int(timeInterval / 60)
        let hours = Int(timeInterval / 3600)
        return String(format: "%.2d:%.2d:%.2d", hours, minutes, seconds)
    }
    
    // Increments stopwatch by 1 second
    @objc func updateCount() {
        count = count + 1
        timerCount.text = timeString(from: count)
    }
    
    // https://www.ioscreator.com/tutorials/slider-ios-tutorial
    @IBAction func inhaleSliderValueChanged(_ sender: UISlider) {
        inhaleDuration = Double(sender.value)
        
        // Forces inhale to be at least one second shorter than exhale
        if inhaleDuration >= exhaleDuration {
            inhaleDuration = exhaleDuration - 1
            inhaleSlider.value = Float(inhaleDuration)
        }
        
        // Set label to current value of slider
        inhaleLabel.text = "\(Int(inhaleDuration))"
    }
    
    @IBAction func exhaleSliderValueChanged(_ sender: UISlider) {
        exhaleDuration = Double(sender.value)
        
        // Forces inhale to be at least one second shorter than exhale
        if exhaleDuration <= inhaleDuration {
            exhaleDuration = inhaleDuration + 1
            exhaleSlider.value = Float(exhaleDuration)
        }
        
        // Set label to current value of slider
        exhaleLabel.text = "\(Int(exhaleDuration))"
    }
    
    // Pauses/plays wave sound
    @IBAction func wavesButtonPressed() {
        if rainPlayer.isPlaying {
            rainPlayer.pause()
            wavesPlayer.numberOfLoops = -1
            wavesPlayer.play()
        }
        else {
            if wavesPlayer.isPlaying {
                wavesPlayer.pause()
            }
            else {
                wavesPlayer.numberOfLoops = -1
                wavesPlayer.play()
            }
        }
    }
    
    // Pauses/plays rain sound
    @IBAction func rainButtonPressed() {
        if wavesPlayer.isPlaying {
            wavesPlayer.pause()
            
            // Loop sound forever
            // https://www.hackingwithswift.com/example-code/media/how-to-loop-audio-using-avaudioplayer-and-numberofloops
            rainPlayer.numberOfLoops = -1
            rainPlayer.play()
        }
        else {
            if rainPlayer.isPlaying {
                rainPlayer.pause()
            }
            else {
                rainPlayer.numberOfLoops = -1
                rainPlayer.play()
            }
        }
    }
    
    // https://stackoverflow.com/questions/37677345/pausing-and-resuming-a-timer-in-ios/37677648
    @IBAction func startStopTimer() {
        // Timer not started or paused
        if !started {
            // https://learnappmaking.com/timer-swift-how-to/
            timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateCount), userInfo: nil, repeats: true)
            // Add timer to a thread and let timer run during UI interactions
            // https://www.hackingwithswift.com/articles/117/the-ultimate-guide-to-timer
            RunLoop.current.add(timer, forMode: RunLoop.Mode.common)

            // Change boolean value
            started = true
        
            // Change button label
            startButton.setTitle("Stop", for: UIControl.State.normal)
        }
        // Timer started
        else if started {
            // Pause
            timer.invalidate()
            
            // Change boolean value
            started = false

            // Change button label
            startButton.setTitle("Start", for: UIControl.State.normal)
        }
    }
    
    @IBAction func resetTimer() {
        // Stop timer
        timer.invalidate()
        
        // Reset timer
        count = 0
        timerCount.text = timeString(from: count)
        
        // Change stop button label to start
        if started {
            startButton.setTitle("Start", for: UIControl.State.normal)
        }
        
        // Change boolean value
        started = false
    }
    
    @IBAction func hideShowTimer() {
        if show {
            // Hide timer-related labels and buttons
            timerCount.isHidden = true
            startButton.isEnabled = false
            startButton.isHidden = true
            resetButton.isEnabled = false
            resetButton.isHidden = true
            
            show = false
            
            hideTimerButton.setTitle("Show", for: UIControl.State.normal)
        }
        else {
            // Show timer-related labels and buttons
            timerCount.isHidden = false
            startButton.isEnabled = true
            startButton.isHidden = false
            resetButton.isEnabled = true
            resetButton.isHidden = false
            
            show = true
            
            hideTimerButton.setTitle("Hide", for: UIControl.State.normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Make breathing circle
        // https://medium.com/better-programming/ui-animations-with-swift-2ebb5e6d2292
        let frame = CGRect(x: screenWidth/2.5, y: screenHeight/3, width: 64.0, height: 64.0)
        let circle = UIView(
            frame: frame
        )
        
        circle.backgroundColor = UIColor.gray
        circle.layer.cornerRadius = 32.0
        self.view.addSubview(circle)
        
        // Start animation
        scaleUp(shape: circle, duration: inhaleDuration)
        
        // Create audio players for sound files
        // https://codewithchris.com/avaudioplayer-tutorial/
        // Audio file recorded by Mike Koenig: http://soundbible.com/1935-Ocean-Waves.html
        let waveSound = Bundle.main.path(forResource: "waves", ofType: "wav")
        do {
            wavesPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: waveSound!))
        }
        catch {
            print(error)
        }
        
        // Audio file recorded by Mark DiAngelo: http://soundbible.com/2065-Rain-Inside-House.html
        let rainSound = Bundle.main.path(forResource: "rain", ofType: "wav")
        do {
            rainPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: rainSound!))
        }
        catch {
            print(error)
        }
        
        // https://stackoverflow.com/questions/24110762/swift-determine-ios-screen-size
        // Dimensions of screen for iPhone 11 Pro Max: 414 by 896 pts
    }
}
