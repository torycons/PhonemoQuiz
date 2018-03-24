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
  
  func setupAudio(audioPlayer: inout AVAudioPlayer, sound: URL?) -> AVAudioPlayer {
    guard let sound = sound else { return audioPlayer }
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: sound)
      audioPlayer.prepareToPlay()
      return audioPlayer
    } catch {
      print("Error: Can't play sound")
    }
    return audioPlayer
  }
}

