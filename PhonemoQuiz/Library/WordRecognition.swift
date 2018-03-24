//
//  Speech.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 23/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import Speech

struct WordRecognition {
  
  static let shared = WordRecognition()
  
  func recordSpeech(request: inout SFSpeechAudioBufferRecognitionRequest?, audioEngine: AVAudioEngine, completionRecording: (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) -> Void) {
    request = SFSpeechAudioBufferRecognitionRequest()
    guard let request = request else { return }
    let node = audioEngine.inputNode
    let recordingFormat = node.outputFormat(forBus: 0)
    node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
      request.append(buffer)
    }
    audioEngine.prepare()
    completionRecording(audioEngine, request)
  }
  
  func recognitionTask(recognitionTask: inout SFSpeechRecognitionTask?, speechRecognizer: SFSpeechRecognizer?, request: SFSpeechAudioBufferRecognitionRequest?, completion: @escaping (SFSpeechRecognitionResult?) -> Void) {
    guard let request = request else { return }
    recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
      if error != nil {
        print(error ?? "")
        return
      }
      completion(result)
    })
  }
  
  func stopRecording(request: SFSpeechAudioBufferRecognitionRequest?, audioEngine: AVAudioEngine, recognitionTask: inout SFSpeechRecognitionTask?, completion: () -> Void) {
    request?.endAudio()
    audioEngine.stop()
    audioEngine.inputNode.removeTap(onBus: 0)
    recognitionTask?.cancel()
    completion()
  }
}
