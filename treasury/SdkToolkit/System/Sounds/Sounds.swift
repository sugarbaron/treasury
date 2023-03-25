//
//  Sounds.swift
//  treasury
//
//  Created by sugarbaron on 25.03.2023.
//

import AVFoundation

public final class Sounds {
    
    public static func play(_ sound: SystemSound) { AudioServicesPlaySystemSound(sound.id) }
    
    public enum SystemSound : Int {
        case keyPressed1 = 1104
        case keyPressed2 = 1105
        
        var id: SystemSoundID { .init(rawValue) }
    }
    
}
