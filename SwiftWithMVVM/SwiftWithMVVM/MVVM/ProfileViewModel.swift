//
//  ProfileViewModel.swift
//  SwiftWithMVVM
//
//  Created by QDSG on 2019/4/29.
//  Copyright © 2019 unitTao. All rights reserved.
//

import Foundation

class ProfileViewModel {
    let profile: Profile
    
    init(withProfile profile: Profile) {
        self.profile = profile
    }
}

extension ProfileViewModel {
    func timeForProfile() -> String {
        return profile.duration.toString()
    }
    
    func numberOfRows(forSegmentOfType type: SegmentType) -> Int {
        var result = 1
        guard let segment = profile.segment(ofType: type) else { return result }
        switch type {
        case .WarmUp:
            result = segment.enabled ? 2 : 1
        case .CoolDown:
            if segment.enabled {
                result = segment.soundEnabled(ofType: .Begin) ? 4 : 3
            }
        default: result = 1
        }
        return result
    }
    
    func timeForSegment(ofType type: SegmentType) -> String {
        guard let segment = profile.segment(ofType: type) else { return "00:00" }
        return segment.duration.toString()
    }
    
    func segmentEnabled(ofType type: SegmentType) -> Bool {
        guard let segment = profile.segment(ofType: type) else { return false }
        return segment.enabled
    }
    
    func setSegment(ofType type: SegmentType, enabled: Bool) {
        if let segment = profile.segment(ofType: type) {
            segment.enabled = enabled
        } else {
            let segment = Segment(type: type)
            segment.enabled = enabled
            
            profile.segments.append(segment)
        }
    }
    
    func soundEnabled(ofType type: SoundType, forSegmentType segmentType: SegmentType) -> Bool {
        guard let segment = profile.segment(ofType: segmentType) else { return false }
        return segment.soundEnabled(ofType: type)
    }
    
    func setSound(ofType type: SoundType, enabled: Bool, forSegmentType segmentType: SegmentType) {
        if let segment = profile.segment(ofType: segmentType),
            let sound = segment.sound(ofType: type) {
            sound.enabled = enabled
        } else {
            let segment = Segment(type: segmentType)
            let sound = Sound(type: type)
            sound.enabled = enabled
            segment.sounds.append(sound)
            profile.segments.append(segment)
        }
    }
}

enum ProfileSection: Int {
    case Time, WarmUp, CoolDown, Count
    
    static var count: Int {
        return ProfileSection.Count.rawValue
    }
    
    static let sectionTitles = [
        Time: "Time",
        WarmUp: "WarmUp",
        CoolDown: "CoolDown",
    ]
    
    func sectionTitle() -> String {
        if let sectionTitle = ProfileSection.sectionTitles[self] {
            return sectionTitle
        } else {
            return ""
        }
    }
}
