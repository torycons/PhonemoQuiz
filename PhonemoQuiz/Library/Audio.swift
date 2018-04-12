//
//  Audio.swift
//  PhonemoQuiz
//
//  Created by Thanapat Sorralump on 23/3/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import AVFoundation

struct Audio {
  
  static let shared = Audio()
  
  func setupAudioFile(audioPlayer: inout AVAudioPlayer, sound: URL?) -> AVAudioPlayer {
    guard let sound = sound else { return audioPlayer }
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: sound)
      audioPlayer.prepareToPlay()
      audioPlayer.volume = 1.0
      return audioPlayer
    } catch {
      print("Error: Can't play sound")
    }
    return audioPlayer
  }
  
  func setupAudioDownload(audioPlayer: inout AVAudioPlayer, soundData: Data?) -> AVAudioPlayer {
    guard let sound = soundData else { return audioPlayer }
    do {
      audioPlayer = try AVAudioPlayer(data: sound)
      audioPlayer.prepareToPlay()
      audioPlayer.volume = 1.0
      return audioPlayer
    } catch {
      print("Error: Can't play word sound")
    }
    return audioPlayer
  }
  
  func useAllSpeaker() {
    do {
      try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
    } catch {
      print("Can't use all speakers")
    }
  }
}

