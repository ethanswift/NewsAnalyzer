//
//  RecordViewController.swift
//  Objectify
//
//  Created by ehsan sat on 3/18/20.
//  Copyright © 2020 ehsan sat. All rights reserved.
//

import UIKit
import AVFoundation
import Speech

class RecordViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var recordButton: UIButton!
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    private let audioEngine = AVAudioEngine()
    
    var transcriptionText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordButton.isEnabled = false
        requestAuthorization()
        speechRecognizer?.delegate = self
 
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recordButtonPressed(_ sender: UIButton) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            recordButton.isEnabled = false
            recordButton.setTitle("Start Recording", for: .normal)
            if transcriptionText != "" {
                performSegue(withIdentifier: "goToTabBar", sender: self)
            } else {
                self.textView.text = "Nothing has been recorded! Try Again!"
            }
        } else {
            startRecording()
            recordButton.setTitle("Stop Recording", for: .normal)
        }
    }
    
    func requestAuthorization () {
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            var isButtonEnabled = false
            switch authStatus {
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition has not yet been authorized")
            case .denied:
                isButtonEnabled = false
                print("User was denied access to speech recognition")
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition is restricted on this device")
            case .authorized:
                isButtonEnabled = true
            }
            OperationQueue.main.addOperation {
                self.recordButton.isEnabled = isButtonEnabled
            }
        }
    }

    func startRecording() {
        
        if self.recognitionTask != nil {
            self.recognitionTask!.cancel()
            self.recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
         print(error)
        }
        
        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let node = audioEngine.inputNode

        let recognitionRequest = self.recognitionRequest
        
        recognitionRequest!.shouldReportPartialResults = true
        
        var recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest!, resultHandler: { (result, err) in
        
            var isFinal = false
            
            if result != nil {
                self.textView.text = result?.bestTranscription.formattedString
                self.transcriptionText = self.textView.text
                isFinal = (result?.isFinal)!
            }
            
            if err != nil || isFinal {
                self.audioEngine.stop()
                node.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.recordButton.isEnabled = true
                
            }
        })
        
        let recognitionFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recognitionFormat) { (buffer, time) in
            self.recognitionRequest!.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audio engine couldn't start because of an error")
        }
        
        textView.text = "Say Something I'm Listening"
        
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            recordButton.isEnabled = true
        } else {
            recordButton.isEnabled = false
        }
        
    }
    

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTabBar" {
            let tbc = segue.destination as! UITabBarController
            
            let secondVC = tbc.viewControllers![0] as! ResultViewController
            secondVC.textViewText = transcriptionText
            
            let thirdVC = tbc.viewControllers![1] as! SearchTableViewController
            thirdVC.textViewText = transcriptionText
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
