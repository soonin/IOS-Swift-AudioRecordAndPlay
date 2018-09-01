//
//  ViewController.swift
//  IOS-Swift-AudioRecordAndPlay
//
//  Created by Pooya on 2018-09-01.
//  Copyright © 2018 Pooya. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    
    @IBOutlet weak var recordBTN: UIButton!
    @IBOutlet weak var playBTN: UIButton!
    
    var soundRecorder : AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!
    
    var fileName : String = "audioFile.m4a"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecorder()
        playBTN.isEnabled = false
        
    }


    func getDocumentsDirector() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func setupRecorder() {
        let audioFilename = getDocumentsDirector().appendingPathComponent(fileName)
        let recordSetting = [ AVFormatIDKey : kAudioFormatAppleLossless ,
                              AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                              AVEncoderBitRateKey : 320000,
                              AVNumberOfChannelsKey : 2,
                              AVSampleRateKey : 44100.2 ] as [String : Any]
        do {
            soundRecorder = try AVAudioRecorder(url: audioFilename, settings: recordSetting)
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
        } catch {
            print(error)
        }
    }
    
    func setupPlayer() {
        let audioFilename = getDocumentsDirector().appendingPathComponent(fileName)
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.volume = 1.0
        } catch {
            print(error)
        }

    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        playBTN.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordBTN.isEnabled = true
        playBTN.setTitle("Play", for: .normal)
    }
    
    
    
    
    @IBAction func recordAct(_ sender: Any) {
        if recordBTN.titleLabel?.text == "Record" {
            soundRecorder.record()
            recordBTN.setTitle("Stop", for: .normal)
            playBTN.isEnabled = false
        } else {
            soundRecorder.stop()
            recordBTN.setTitle("Record", for: .normal)
            playBTN.isEnabled = false
        }
    
    }
    
    
    @IBAction func playAct(_ sender: Any) {
        if playBTN.titleLabel?.text == "Play" {
            playBTN.setTitle("Stop", for: .normal)
            recordBTN.isEnabled = false
            setupPlayer()
            soundPlayer.play()
        } else {
            soundPlayer.stop()
            playBTN.setTitle("Play", for: .normal)
            recordBTN.isEnabled = false
        }

    
    
    }
    

}

