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
import Alamofire
import SwiftyJSON
import SVProgressHUD

class RecordViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var recordButton: UIButton!
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    var items: [Item] = []
    
    var categories: [Categories] = []
    
    var docs: [Doc] = []
    
    private let audioEngine = AVAudioEngine()
    
    var transcriptionText: String = ""
    
//    "President Trump on Friday openly encouraged right-wing protests of social distancing restrictions in states with stay-at-home orders, a day after announcing guidelines for how the nation’s governors should carry out an orderly reopening of their communities on their own timetables.In a series of all-caps tweets that started two minutes after a Fox News report on the protesters, the president declared, “LIBERATE MICHIGAN!” and “LIBERATE MINNESOTA!” — two states whose Democratic governors have imposed strict social distancing restrictions. He also lashed out at Virginia, where the state’s Democratic governor and legislature have pushed for strict gun control measures, saying: “LIBERATE VIRGINIA, and save your great 2nd Amendment. It is under siege!”His stark departure from the more bipartisan tone of his announcement on Thursday night suggested Mr. Trump was ceding any semblance of national leadership on the pandemic, and choosing instead to divide the country by playing to his political base.Echoed across the internet and on cable television by conservative pundits and ultraright conspiracy theorists, his tweets were a remarkable example of a president egging on demonstrators and helping to stoke an angry fervor that in its anti-government rhetoric was eerily reminiscent of the birth of the Tea Party movement a decade ago."
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1)
        recordButton.layer.cornerRadius = 25
        recordButton.layer.backgroundColor = #colorLiteral(red: 0.7242990732, green: 0.7850584388, blue: 0.9598841071, alpha: 1)
        recordButton.setTitleColor(#colorLiteral(red: 0.2265214622, green: 0.2928299606, blue: 0.5221264958, alpha: 1), for: .normal)
        recordButton.imageView?.contentMode = .scaleAspectFill
        
        textView.layer.cornerRadius = 25
        textView.layer.backgroundColor = #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)
        textView.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        recordButton.isEnabled = false
//        recordButton.setTitle("Start Recording!", for: .normal)
        recordButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        requestAuthorization()
        speechRecognizer?.delegate = self
        
        SVProgressHUD.setBackgroundColor(UIColor.clear)
 
        // Do any additional setup after loading the view.
    }
    
    // MARK: -Button Pressed
    
    @IBAction func recordButtonPressed(_ sender: UIButton) {
//        retrieveDataFromAPI()
//        performSegue(withIdentifier: "goToTabBar", sender: self)
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            recordButton.isEnabled = false
            recordButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            recordButton.setTitle("Start Recording!", for: .normal)
            if transcriptionText != "" {
                SVProgressHUD.show()
                self.retrieveDataFromAPI()
            } else {
                self.textView.text = "Nothing Has Been recorded! Try Again!"
            }
        } else {
            startRecording()
            recordButton.tintColor = #colorLiteral(red: 0.920953393, green: 0.447560966, blue: 0.4741248488, alpha: 1)
//            recordButton.setTitle("Stop Recording!", for: .normal)
        }
    }
    
    // MARK: -Speech Recognition
    
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
    
    // MARK: -Recording Process

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
    
    // MARK: - Retrieve All API Data
    
    // Retrieve API data and send them to tab bars
    
    func retrieveDataFromAPI () {
        let url = "http://api.text2data.com/v3/analyze"
        let headers = ["Accept": "application/json",
                       "Content-Type": "application/json"]
        let params = ["DocumentText": transcriptionText,
                      "IsTwitterContent": false,
                      "PrivateKey": "8A13C9BB-7762-46E5-830B-980EF1E12426 ",
                      "Secret": "8A13C9BB-7762-46E5",
                      "UserCategoryModelName": "",
                      "DocumentLanguage": "en",
                      "SerializeFormat": 1,
                      "RequestIdentifier": "" ] as [String : Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.error != nil || response.data == nil {
                print("Client Error: ",response.error!.localizedDescription)
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "Connection Failed", message: "Your connection to the internet has been failed, Please try agian later!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                // with alert ; please try again; this is not the command
//                self.startRecording()
//                self.recordButton.setTitle("Stop Recording", for: .normal)
                return
            }

            do {
                guard let json = try? JSON(data: response.data!) else {return}
                print("json recieved!")
                if let autoCategories = json["AutoCategories"].array {

                    for autoCategory in autoCategories {
                        let categoryName = autoCategory["CategoryName"].string ?? "Not Found"
                        let categoryNameScore = autoCategory["Score"].double ?? 0.0
                        let categories = Categories(categoryName: categoryName, score: categoryNameScore)
                        self.categories.append(categories)
                    }
                }
                if let coreSentences = json["CoreSentences"].array {

                    for coreSentence in coreSentences {
                        let magnitude = coreSentence["Magnitude"].double ?? 0.0
                        let sentenceNumber = coreSentence["SentenceNumber"].double ?? 00
                        let sentimentPolarity = coreSentence["SentimentPolarity"].string ?? "Not Found"
                        let sentimentResultString = coreSentence["SentimentResultString"].string ?? "Not Found"
                        let sentimentValue = coreSentence["SentimentValue"].double ?? 0.0
                        let text = coreSentence["Text"].string ?? "Not Found"
                        // text and sentence text are the same here
                        let item = Item(sentenceText: text, sentencePartType: "coreSentence", sentenceNumber: sentenceNumber, text: text, keywordType: "Sentence", mentions: 0.0, sentimentPolarity: sentimentPolarity, sentimentResult: sentimentResultString, sentimentValue: sentimentValue, magnitude: magnitude)
                        self.items.append(item)
                    }
                }
                
                let docSentimentPolarity = json["DocSentimentPolarity"].string ?? "Not Found"

                let docSentimentResultString = json["DocSentimentResultString"].string ?? "Not Found"

                let docSentimentValue = json["DocSentimentValue"].double ?? 0.0

                if let entities = json["Entities"].array {

                    for entity in entities {
                        let keywordType = entity["KeywordType"].string ?? "Not Found"
                        let magnitude = entity["Magnitude"].double ?? 0.0
                        let mentions = entity["Mentions"].double ?? 0.0
                        let sentencePartType = entity["SentencePartType"].string ?? "Not Found"
                        let sentenceText = entity["SentenceText"].string ?? "Not Found"
                        let sentimentPolarity = entity["SentimentPolarity"].string ?? "Not Found"
                        let sentimentResult = entity["SentimentResult"].string ?? "Not Found"
                        let sentimentValue = entity["SentimentValue"].double ?? 0.0
                        let text = entity["Text"].string ?? "Not Found"
                        let item = Item(sentenceText: sentenceText, sentencePartType: sentencePartType, sentenceNumber: 0.0, text: text, keywordType: keywordType, mentions: mentions, sentimentPolarity: sentimentPolarity, sentimentResult: sentimentResult, sentimentValue: sentimentValue, magnitude: magnitude)
                        self.items.append(item)
                    }
                }
                
                if let keywords = json["Keywords"].array {

                    for keyword in keywords {
                        let keywordType = keyword["KeywordType"].string ?? "Not Found"
                        let magnitude = keyword["Magnitude"].double ?? 0.0
                        let mentions = keyword["Mentions"].double ?? 0.0
                        let sentencePartType = keyword["SentencePartType"].string ?? "Not Found"
                        let sentenceText = keyword["SentenceText"].string ?? "Not Found"
                        let sentimentPolarity = keyword["SentimentPolarity"].string ?? "Not Found"
                        let sentimentResult = keyword["SentimentResult"].string ?? "Not Found"
                        let sentimentValue = keyword["SentimentValue"].double ?? 0.0
                        let text = keyword["Text"].string ?? "Not Found"
                        let item = Item(sentenceText: sentenceText, sentencePartType: sentencePartType, sentenceNumber: 0.0, text: text, keywordType: keywordType, mentions: mentions, sentimentPolarity: sentimentPolarity, sentimentResult: sentimentResult, sentimentValue: sentimentValue, magnitude: magnitude)
                        self.items.append(item)
                    }
                }
                
                let subjectivity = json["Subjectivity"].string ?? "Not Found"
                let magnitude = json["Magnitude"].double ?? 0.0
                let doc = Doc(docSentimentPolarity: docSentimentPolarity, docSentimentResultString: docSentimentResultString, docSentimentValue: docSentimentValue, subjectivity: subjectivity, magnitude: magnitude)
                self.docs.append(doc)
                
                if let themes = json["Themes"].array {
                    for theme in themes {
                        let sentimentPolarity = theme["SentimentPolarity"].string ?? "Not Found"
                        let sentencePartType = theme["SentencePartType"].string ?? "Not Found"
                        let mentions = theme["Mentions"].double ?? 0.0
                        let sentenceText = theme["SentenceText"].string ?? "Not Found"
                        let keywordType = theme["KeywordType"].string ?? "Not Found"
                        let sentimentResult = theme["SentimentResult"].string ?? "Not Found"
                        let sentimentValue = theme["SentimentValue"].double ?? 0.0
                        let magnitude = theme["Magnitude"].double ?? 0.0
                        let text = theme["Text"].string ?? "Not Found"
                        let item = Item(sentenceText: sentenceText, sentencePartType: sentencePartType, sentenceNumber: 0.0, text: text, keywordType: keywordType, mentions: mentions, sentimentPolarity: sentimentPolarity, sentimentResult: sentimentResult, sentimentValue: sentimentValue, magnitude: magnitude)
                        self.items.append(item)
                        if self.items.count != 0 {
//                            self.performSegue(withIdentifier: "goToTabBar", sender: self)
                        }
                    }
                }
                SVProgressHUD.dismiss()
                if self.items.count != 0 {
                    self.performSegue(withIdentifier: "goToTabBar", sender: self)
                }
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTabBar" {
            let tbc = segue.destination as! UITabBarController
            
            let firstVC = tbc.viewControllers![4] as! WebSearchViewController
            firstVC.items = items
            firstVC.categories = categories
            firstVC.docs = docs
            
            let secondVC = tbc.viewControllers![0] as! UINavigationController
            let secondNavVC = secondVC.topViewController as! ResultViewController
            secondNavVC.items = items
            
            let thirdVC = tbc.viewControllers![1] as! UINavigationController
            let thirdNavVC = thirdVC.topViewController as! SentimentViewController
            thirdNavVC.items = items
            thirdNavVC.doc = docs
            
            let forthVC = tbc.viewControllers![2] as! UINavigationController
            let forthNavVC = forthVC.topViewController as! KeywordsTableViewController
            forthNavVC.items = items
            
            let fifthVC = tbc.viewControllers![3] as! UINavigationController
            let fifthNavVC = fifthVC.topViewController as! ThemesTableViewController
            fifthNavVC.items = items
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
