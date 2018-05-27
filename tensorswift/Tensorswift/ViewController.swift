//
//  ViewController.swift
//  Tensorswift
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, TensorDelegate {
    
    @IBOutlet weak var tag: UILabel!
    
    @IBOutlet weak var previewView: UIView!
    var bridge:TensorBridge = TensorBridge()
    
    var currentLabel = ""
    

     private var videoCapture: VideoCapture!
        private var ciContext : CIContext!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let videoCapture = videoCapture else {return}
        videoCapture.startCapture()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bridge.loadModel()
        bridge.delegate = self
        
        let spec = VideoSpec(fps: 3, size: CGSize(width: 640, height: 480))
        videoCapture = VideoCapture(cameraType: .back,
                                    preferredSpec: spec,
                                    previewContainer: previewView.layer)
     
        videoCapture.imageBufferHandler = {[unowned self] (imageBuffer, timestamp, outputBuffer) in
            self.bridge.runCNN(onFrame: imageBuffer)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        // Test individual labels here
        
//        presentSeenObject(label: "peanut")
    }
    

    // seen objects enter here
    
    func tensorLabelListUpdated(_ recognizedObjects:[AnyHashable : Any]){
        
        for seenObject in recognizedObjects {
            let label = String(describing: seenObject.key)
            let confidence = seenObject.value as! Double
            let conPct = (confidence * 100).rounded()
            
            let utterance = AVSpeechUtterance(string: label)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
            let synth = AVSpeechSynthesizer()
            
            // change the debug confidence here
            if confidence > 0.45 {
                print("I'm \(conPct)% sure that's a \(label)")
            }
            
            // change the trigger confidence in the Config file
            let isEqual = (label == currentLabel)
            if confidence > Config.confidence && isEqual == false {
              tag.text = label
              synth.speak(utterance)
              currentLabel = label
              //presentSeenObject(label: label)
            }
        }
    }
    
    func presentSeenObject(label:String){
        
        // Create a ViewController that shows a web page
        // You can do your own thing here, like your own view controller, or 
        // just show something in this viewcontroller
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "webView") as! SeenObjectViewController
        
        // is this label defined?
        if let url = Config.seeThisOpenThat[label] {
            vc.urlToLoad = url
            
        } else {
            // not defined explicitly, see if there is a catch-all
            
            if let catchAll = Config.seeThisOpenThat["catch-all"] {
                
                // change - with spaces in label. You can remove this
                var l = label.replacingOccurrences(of: "-", with: " ")
                
                // make the label URL friendly
                l = l.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
                
                // Replace %s with the label 
                let u = catchAll.replacingOccurrences(of: "%s", with: l)
                
                vc.urlToLoad = u
            } else {
            // not even the catch-all is in config. 
                //          Let's just improvise. Maybe a custom thing.
                
                vc.urlToLoad = "https://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords=\(label)"
            }
        }
        
        
        self.present(vc, animated: false, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

