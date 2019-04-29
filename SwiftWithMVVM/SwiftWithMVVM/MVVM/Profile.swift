//
//  Profile.swift
//  SwiftWithMVVM
//
//  Created by QDSG on 2019/4/29.
//  Copyright © 2019 unitTao. All rights reserved.
//

import Foundation

class Profile {
    var name = "Profile"
    var segments = [Segment]()
    var duration: TimeInterval = 450.0
    
    init() {
        let segment = Segment(type: .Main)
        segments.append(segment)
    }
    
    func segment(ofType type: SegmentType) -> Segment? {
        var result: Segment? = nil
        
        for segment in segments {
            if segment.type == type {
                result = segment
            }
        }
        return result
    }
}

enum SegmentType {
    case Main
    case WarmUp
    case CoolDown
}

class Segment {
    var enabled: Bool
    var type: SegmentType
    var sounds = [Sound]()
    var duration = 300.0
    
    init(type: SegmentType) {
        self.type = type
        enabled = true
    }
    
    func sound(ofType type: SoundType) -> Sound? {
        var result: Sound? = nil
        
        for sound in sounds {
            if sound.type == type {
                result = sound
            }
        }
        return result
    }
    
    func soundEnabled(ofType type: SoundType) -> Bool {
        guard let sound = sound(ofType: type) else { return false }
        return sound.enabled
    }
}

enum SoundType {
    case Repeat
    case Begin
    case End
}

class Sound {
    var enabled: Bool
    var type: SoundType
    var name = ""
    var iterations = 0
    var timeInterval = 300.0
    
    init(type: SoundType) {
        self.type = type
        enabled = true
    }
}
