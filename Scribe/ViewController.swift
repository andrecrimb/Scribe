//
//  ViewController.swift
//  Scribe
//
//  Created by Andre Rosa on 27/07/17.
//  Copyright © 2017 Andre Rosa. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var transcription: UITextView!

    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        spinner.isHidden = true
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        spinner.stopAnimating()
        spinner.isHidden = true
    }

    func requestSpeechAuth(){
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized{
                if let path = Bundle.main.url(forResource: "teste", withExtension: "m4a"){
                    do{
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                    } catch{
                        print("error!")
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                            print("there was an error: \(error)")
                        } else {
                            self.transcription.text = result?.bestTranscription.formattedString
                        }
                    }
                    
                    
                }
            }
        }
    }
    
    @IBAction func playBtnPress(_ sender: UIButton) {
        spinner.isHidden = false
        spinner.startAnimating()
        requestSpeechAuth()
    }
    
    

}

